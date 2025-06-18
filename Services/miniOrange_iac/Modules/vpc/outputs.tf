output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_arn" {
  description = "ARN of the VPC"
  value       = aws_vpc.main.arn
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "vpc_ipv6_cidr_block" {
  description = "The IPv6 CIDR block of the VPC"
  value       = aws_vpc.main.ipv6_cidr_block
}

output "vpc_ipv6_association_id" {
  description = "The association ID for the IPv6 CIDR block"
  value       = aws_vpc.main.ipv6_association_id
}

output "vpc_default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = aws_vpc.main.default_security_group_id
}

output "vpc_default_network_acl_id" {
  description = "The ID of the default network ACL"
  value       = aws_vpc.main.default_network_acl_id
}

output "vpc_default_route_table_id" {
  description = "The ID of the default route table"
  value       = aws_vpc.main.default_route_table_id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = var.create_internet_gateway ? aws_internet_gateway.main[0].id : null
}

output "internet_gateway_arn" {
  description = "The ARN of the Internet Gateway"
  value       = var.create_internet_gateway ? aws_internet_gateway.main[0].arn : null
}

# Private Subnet Outputs
output "private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private[*].id
}

output "private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = aws_subnet.private[*].arn
}

output "private_subnet_cidrs" {
  description = "List of CIDR blocks of private subnets"
  value       = aws_subnet.private[*].cidr_block
}

output "private_subnet_azs" {
  description = "List of availability zones of private subnets"
  value       = aws_subnet.private[*].availability_zone
}

# Public IPv4 Subnet Outputs
output "public_ipv4_subnet_ids" {
  description = "List of IDs of public IPv4 subnets"
  value       = aws_subnet.public_ipv4[*].id
}

output "public_ipv4_subnet_arns" {
  description = "List of ARNs of public IPv4 subnets"
  value       = aws_subnet.public_ipv4[*].arn
}

output "public_ipv4_subnet_cidrs" {
  description = "List of CIDR blocks of public IPv4 subnets"
  value       = aws_subnet.public_ipv4[*].cidr_block
}

output "public_ipv4_subnet_azs" {
  description = "List of availability zones of public IPv4 subnets"
  value       = aws_subnet.public_ipv4[*].availability_zone
}

# Public IPv6 Subnet Outputs
output "public_ipv6_subnet_ids" {
  description = "List of IDs of public IPv6 subnets"
  value       = aws_subnet.public_ipv6[*].id
}

output "public_ipv6_subnet_arns" {
  description = "List of ARNs of public IPv6 subnets"
  value       = aws_subnet.public_ipv6[*].arn
}

output "public_ipv6_subnet_cidrs" {
  description = "List of CIDR blocks of public IPv6 subnets"
  value       = aws_subnet.public_ipv6[*].cidr_block
}

output "public_ipv6_subnet_ipv6_cidrs" {
  description = "List of IPv6 CIDR blocks of public IPv6 subnets"
  value       = aws_subnet.public_ipv6[*].ipv6_cidr_block
}

output "public_ipv6_subnet_azs" {
  description = "List of availability zones of public IPv6 subnets"
  value       = aws_subnet.public_ipv6[*].availability_zone
}

# NAT Gateway Outputs
output "nat_gateway_ids" {
    description = "Provide the list of natgateway id"
    value = aws_nat_gateway.main[*].id
}

output "nat_public_ips" {
  description = "List of public Elastic IPs of NAT Gateways"
  value       = var.create_nat_gateway ? aws_eip.nat[*].public_ip : []
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = aws_route_table.private[*].id
}

