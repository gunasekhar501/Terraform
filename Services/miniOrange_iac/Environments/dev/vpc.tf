module "vpc" {
  source = "../../Modules/vpc"

  # General Configuration
  name_prefix = var.environment

  # VPC Configuration
  vpc_cidr             = var.vpc_cidr
  enable_ipv6          = var.enable_ipv6
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  # Private Subnet Configuration
  private_subnet_count = var.private_subnet_count
  private_subnet_cidrs = var.private_subnet_cidrs
  private_subnet_azs   = var.private_subnet_azs

  # Public IPv4 Subnet Configuration
  public_ipv4_subnet_count        = var.public_ipv4_subnet_count
  public_ipv4_subnet_cidrs        = var.public_ipv4_subnet_cidrs
  public_ipv4_subnet_azs          = var.public_ipv4_subnet_azs
  map_public_ip_on_launch_ipv4    = var.map_public_ip_on_launch_ipv4

  # Public IPv6 Subnet Configuration
  public_ipv6_subnet_count        = var.public_ipv6_subnet_count
  public_ipv6_subnet_cidrs        = var.public_ipv6_subnet_cidrs
  public_ipv6_subnet_ipv6_cidrs   = var.public_ipv6_subnet_ipv6_cidrs
  public_ipv6_subnet_azs          = var.public_ipv6_subnet_azs
  map_public_ip_on_launch_ipv6    = var.map_public_ip_on_launch_ipv6
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation

  # NAT Gateway Configuration
  create_nat_gateway       = var.create_nat_gateway
  nat_gateway_per_subnet   = var.nat_gateway_per_subnet
  single_nat_gateway       = var.single_nat_gateway

  # Internet Gateway Configuration
  create_internet_gateway = var.create_internet_gateway

  # Route Table Configuration
  create_separate_route_tables        = var.create_separate_route_tables
  propagate_private_route_tables_vgw  = var.propagate_private_route_tables_vgw
  propagate_public_route_tables_vgw   = var.propagate_public_route_tables_vgw

  # CIDR Calculation Settings
  private_subnet_suffix       = var.private_subnet_suffix
  public_subnet_suffix        = var.public_subnet_suffix

  # Tags
  tags = merge(var.common_tags, {
    Name = "miniOrange-${var.environment}-vpc"
  })
}