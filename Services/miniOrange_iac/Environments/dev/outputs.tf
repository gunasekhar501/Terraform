############################### VPC #########################################
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_arn" {
  description = "ARN of the VPC"
  value       = module.vpc.vpc_arn
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "vpc_ipv6_cidr_block" {
  description = "The IPv6 CIDR block of the VPC"
  value       = module.vpc.vpc_ipv6_cidr_block
}

output "vpc_ipv6_association_id" {
  description = "The association ID for the IPv6 CIDR block"
  value       = module.vpc.vpc_ipv6_association_id
}

output "vpc_default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = module.vpc.vpc_default_security_group_id
}

output "vpc_default_network_acl_id" {
  description = "The ID of the default network ACL"
  value       = module.vpc.vpc_default_network_acl_id
}

output "vpc_default_route_table_id" {
  description = "The ID of the default route table"
  value       = module.vpc.vpc_default_route_table_id
}

# Internet Gateway Outputs
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

output "internet_gateway_arn" {
  description = "The ARN of the Internet Gateway"
  value       = module.vpc.internet_gateway_arn
}

# Private Subnet Outputs
output "private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnet_ids
}

output "private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = module.vpc.private_subnet_arns
}

output "private_subnet_cidrs" {
  description = "List of CIDR blocks of private subnets"
  value       = module.vpc.private_subnet_cidrs
}

output "private_subnet_azs" {
  description = "List of availability zones of private subnets"
  value       = module.vpc.private_subnet_azs
}

# Public IPv4 Subnet Outputs
output "public_ipv4_subnet_ids" {
  description = "List of IDs of public IPv4 subnets"
  value       = module.vpc.public_ipv4_subnet_ids
}

output "public_ipv4_subnet_arns" {
  description = "List of ARNs of public IPv4 subnets"
  value       = module.vpc.public_ipv4_subnet_arns
}

output "public_ipv4_subnet_cidrs" {
  description = "List of CIDR blocks of public IPv4 subnets"
  value       = module.vpc.public_ipv4_subnet_cidrs
}

output "public_ipv4_subnet_azs" {
  description = "List of availability zones of public IPv4 subnets"
  value       = module.vpc.public_ipv4_subnet_azs
}

# Public IPv6 Subnet Outputs
output "public_ipv6_subnet_ids" {
  description = "List of IDs of public IPv6 subnets"
  value       = module.vpc.public_ipv6_subnet_ids
}

output "public_ipv6_subnet_arns" {
  description = "List of ARNs of public IPv6 subnets"
  value       = module.vpc.public_ipv6_subnet_arns
}

output "public_ipv6_subnet_cidrs" {
  description = "List of CIDR blocks of public IPv6 subnets"
  value       = module.vpc.public_ipv6_subnet_cidrs
}

output "public_ipv6_subnet_ipv6_cidrs" {
  description = "List of IPv6 CIDR blocks of public IPv6 subnets"
  value       = module.vpc.public_ipv6_subnet_ipv6_cidrs
}

output "public_ipv6_subnet_azs" {
  description = "List of availability zones of public IPv6 subnets"
  value       = module.vpc.public_ipv6_subnet_azs
}

# NAT Gateway Outputs
output "nat_gateway_ids" {
  description = "List of IDs of the NAT Gateways"
  value       = module.vpc.nat_gateway_ids
}
