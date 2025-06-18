data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  max_subnet_length = max(
    var.private_subnet_count,
    var.public_ipv4_subnet_count,
    var.public_ipv6_subnet_count
  )
  
  # Use provided AZs or auto-select from available
  private_subnet_azs = length(var.private_subnet_azs) > 0 ? var.private_subnet_azs : [
    for i in range(var.private_subnet_count) : data.aws_availability_zones.available.names[i % length(data.aws_availability_zones.available.names)]
  ]
  
  public_ipv4_subnet_azs = length(var.public_ipv4_subnet_azs) > 0 ? var.public_ipv4_subnet_azs : [
    for i in range(var.public_ipv4_subnet_count) : data.aws_availability_zones.available.names[i % length(data.aws_availability_zones.available.names)]
  ]
  
  public_ipv6_subnet_azs = length(var.public_ipv6_subnet_azs) > 0 ? var.public_ipv6_subnet_azs : [
    for i in range(var.public_ipv6_subnet_count) : data.aws_availability_zones.available.names[i % length(data.aws_availability_zones.available.names)]
  ]
  
  # Calculate CIDRs if not provided
  private_subnet_cidrs = length(var.private_subnet_cidrs) > 0 ? var.private_subnet_cidrs : [
    for i in range(var.private_subnet_count) : cidrsubnet(var.vpc_cidr, var.newbits, i + var.private_subnet_offset)
  ]
  
  public_ipv4_subnet_cidrs = length(var.public_ipv4_subnet_cidrs) > 0 ? var.public_ipv4_subnet_cidrs : [
    for i in range(var.public_ipv4_subnet_count) : cidrsubnet(var.vpc_cidr, var.newbits, i + var.public_ipv4_subnet_offset)
  ]
  
  public_ipv6_subnet_cidrs = length(var.public_ipv6_subnet_cidrs) > 0 ? var.public_ipv6_subnet_cidrs : [
    for i in range(var.public_ipv6_subnet_count) : cidrsubnet(var.vpc_cidr, var.newbits, i + var.public_ipv6_subnet_offset)
  ]
  
  # Calculate IPv6 CIDRs for IPv6 subnets
  public_ipv6_subnet_ipv6_cidrs = length(var.public_ipv6_subnet_ipv6_cidrs) > 0 ? var.public_ipv6_subnet_ipv6_cidrs : var.enable_ipv6 ? [
    for i in range(var.public_ipv6_subnet_count) : cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, i + var.public_ipv6_subnet_offset)
  ] : []
  
  # NAT Gateway configuration
  nat_gateway_count = var.create_nat_gateway ? (
    var.single_nat_gateway ? 1 : (
      var.nat_gateway_per_subnet ? var.private_subnet_count : length(distinct(local.private_subnet_azs))
    )
  ) : 0
}

# VPC
resource "aws_vpc" "main" {
  cidr_block                       = var.vpc_cidr
  assign_generated_ipv6_cidr_block = var.enable_ipv6
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-vpc"
  })
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  count = var.create_internet_gateway ? 1 : 0

  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-igw"
  })
}

# Private Subnets
resource "aws_subnet" "private" {
  count = var.private_subnet_count

  vpc_id            = aws_vpc.main.id
  cidr_block        = local.private_subnet_cidrs[count.index]
  availability_zone = local.private_subnet_azs[count.index]

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-${var.private_subnet_suffix}-subnet-${count.index + 1}"
    Type = "Private"
  })
}

# IPv4 Public Subnets
resource "aws_subnet" "public_ipv4" {
  count = var.public_ipv4_subnet_count

  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.public_ipv4_subnet_cidrs[count.index]
  availability_zone       = local.public_ipv4_subnet_azs[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch_ipv4

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-${var.public_subnet_suffix}-ipv4-subnet-${count.index + 1}"
    Type = "Public-IPv4"
  })
}

# IPv6 Public Subnets
resource "aws_subnet" "public_ipv6" {
  count = var.public_ipv6_subnet_count

  vpc_id                          = aws_vpc.main.id
  cidr_block                      = local.public_ipv6_subnet_cidrs[count.index]
  ipv6_cidr_block                 = var.enable_ipv6 ? local.public_ipv6_subnet_ipv6_cidrs[count.index] : null
  availability_zone               = local.public_ipv6_subnet_azs[count.index]
  map_public_ip_on_launch         = var.map_public_ip_on_launch_ipv6
  assign_ipv6_address_on_creation = var.enable_ipv6 ? var.assign_ipv6_address_on_creation : false

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-${var.public_subnet_suffix}-ipv6-subnet-${count.index + 1}"
    Type = "Public-IPv6"
  })
}

# Elastic IPs for NAT Gateways
resource "aws_eip" "nat" {
  count = local.nat_gateway_count

  domain = "vpc"
  
  depends_on = [aws_internet_gateway.main]

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-nat-eip-${count.index + 1}"
  })
}

# NAT Gateways
resource "aws_nat_gateway" "main" {
  count = local.nat_gateway_count

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = var.single_nat_gateway ? aws_subnet.public_ipv4[0].id : aws_subnet.public_ipv4[count.index % length(aws_subnet.public_ipv4)].id

  depends_on = [aws_internet_gateway.main]

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-nat-gateway-${count.index + 1}"
  })
}

# Route Tables - Private
resource "aws_route_table" "private" {
  count = var.create_separate_route_tables ? var.private_subnet_count : (var.private_subnet_count > 0 ? 1 : 0)

  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, {
    Name = var.create_separate_route_tables ? "${var.name_prefix}-${var.private_subnet_suffix}-rt-${count.index + 1}" : "${var.name_prefix}-${var.private_subnet_suffix}-rt"
  })
}

# Routes for private subnets (to NAT Gateway)
resource "aws_route" "private_nat" {
  count = var.create_nat_gateway && var.private_subnet_count > 0 ? (var.create_separate_route_tables ? var.private_subnet_count : 1) : 0

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.single_nat_gateway ? aws_nat_gateway.main[0].id : aws_nat_gateway.main[count.index % local.nat_gateway_count].id
}

# Route Table Associations - Private
resource "aws_route_table_association" "private" {
  count = var.private_subnet_count

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = var.create_separate_route_tables ? aws_route_table.private[count.index].id : aws_route_table.private[0].id
}

# Route Table - Public IPv4
resource "aws_route_table" "public_ipv4" {
  count = var.public_ipv4_subnet_count > 0 ? 1 : 0

  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-${var.public_subnet_suffix}-ipv4-rt"
  })
}

# Route for public IPv4 subnets (to Internet Gateway)
resource "aws_route" "public_ipv4_internet" {
  count = var.create_internet_gateway && var.public_ipv4_subnet_count > 0 ? 1 : 0

  route_table_id         = aws_route_table.public_ipv4[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main[0].id
}

# Route Table Associations - Public IPv4
resource "aws_route_table_association" "public_ipv4" {
  count = var.public_ipv4_subnet_count

  subnet_id      = aws_subnet.public_ipv4[count.index].id
  route_table_id = aws_route_table.public_ipv4[0].id
}

# Route Table - Public IPv6
resource "aws_route_table" "public_ipv6" {
  count = var.public_ipv6_subnet_count > 0 ? 1 : 0

  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-${var.public_subnet_suffix}-ipv6-rt"
  })
}

# Routes for public IPv6 subnets (to Internet Gateway)
resource "aws_route" "public_ipv6_internet_ipv4" {
  count = var.create_internet_gateway && var.public_ipv6_subnet_count > 0 ? 1 : 0

  route_table_id         = aws_route_table.public_ipv6[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main[0].id
}

resource "aws_route" "public_ipv6_internet_ipv6" {
  count = var.create_internet_gateway && var.enable_ipv6 && var.public_ipv6_subnet_count > 0 ? 1 : 0

  route_table_id              = aws_route_table.public_ipv6[0].id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.main[0].id
}

# Route Table Associations - Public IPv6
resource "aws_route_table_association" "public_ipv6" {
  count = var.public_ipv6_subnet_count

  subnet_id      = aws_subnet.public_ipv6[count.index].id
  route_table_id = aws_route_table.public_ipv6[0].id
}