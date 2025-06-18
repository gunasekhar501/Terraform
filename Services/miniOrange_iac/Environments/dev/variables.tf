################################ VPC ##################################

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = ""
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = ""
}

variable "enable_ipv6" {
  description = "Enable IPv6 for VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS support in VPC"
  type        = bool
  default     = true
}

# Private Subnet Configuration
variable "private_subnet_count" {
  description = "Number of private subnets to create"
  type        = number
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets (leave empty for auto-calculation)"
  type        = list(string)
  default     = []
}

variable "private_subnet_azs" {
  description = "List of availability zones for private subnets (leave empty for auto-selection)"
  type        = list(string)
  default     = []
}

# Public IPv4 Subnet Configuration
variable "public_ipv4_subnet_count" {
  description = "Number of public IPv4 subnets to create"
  type        = number
}

variable "public_ipv4_subnet_cidrs" {
  description = "List of CIDR blocks for public IPv4 subnets (leave empty for auto-calculation)"
  type        = list(string)
  default     = []
}

variable "public_ipv4_subnet_azs" {
  description = "List of availability zones for public IPv4 subnets (leave empty for auto-selection)"
  type        = list(string)
  default     = []
}

variable "map_public_ip_on_launch_ipv4" {
  description = "Auto-assign public IP on launch for IPv4 subnets"
  type        = bool
  default     = true
}

# Public IPv6 Subnet Configuration
variable "public_ipv6_subnet_count" {
  description = "Number of public IPv6 subnets to create"
  type        = number
}

variable "public_ipv6_subnet_cidrs" {
  description = "List of CIDR blocks for public IPv6 subnets (leave empty for auto-calculation)"
  type        = list(string)
  default     = []
}

variable "public_ipv6_subnet_ipv6_cidrs" {
  description = "List of IPv6 CIDR blocks for public IPv6 subnets (leave empty for auto-calculation)"
  type        = list(string)
  default     = []
}

variable "public_ipv6_subnet_azs" {
  description = "List of availability zones for public IPv6 subnets (leave empty for auto-selection)"
  type        = list(string)
  default     = []
}

variable "map_public_ip_on_launch_ipv6" {
  description = "Auto-assign public IP on launch for IPv6 subnets"
  type        = bool
  default     = true
}

variable "assign_ipv6_address_on_creation" {
  description = "Auto-assign IPv6 address on instance creation"
  type        = bool
  default     = true
}

# NAT Gateway Configuration
variable "create_nat_gateway" {
  description = "Whether to create NAT Gateways for private subnets"
  type        = bool
  default     = true
}

variable "nat_gateway_per_subnet" {
  description = "Create one NAT Gateway per private subnet (true) or one per AZ (false)"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Use a single shared NAT Gateway across all private subnets"
  type        = bool
  default     = false
}

# Internet Gateway Configuration
variable "create_internet_gateway" {
  description = "Whether to create Internet Gateway"
  type        = bool
  default     = true
}

# Route Table Configuration
variable "create_separate_route_tables" {
  description = "Create separate route tables for each subnet type"
  type        = bool
  default     = true
}

variable "propagate_private_route_tables_vgw" {
  description = "Should be true if you want route table propagation for private route tables"
  type        = bool
  default     = false
}

variable "propagate_public_route_tables_vgw" {
  description = "Should be true if you want route table propagation for public route tables"
  type        = bool
  default     = false
}

# CIDR Calculation Settings
variable "private_subnet_suffix" {
  description = "Suffix to append to private subnets name"
  type        = string
  default     = "private"
}

variable "public_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
  default     = "public"
}

variable "private_subnet_offset" {
  description = "Starting number for private subnet CIDR calculation"
  type        = number
  default     = 0
}

variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default = {
    Terraform   = "true"
    Project     = "vpc-setup"
    ManagedBy   = "terraform"
  }
}

##########################################################
# EKS Cluster
##########################################################
##management Cluster##
variable "cluster_name" {
  type        = string
  description = "Provide a name for the eks cluster"
}
variable "cluster_version" {
  type        = string
  description = "Provide a value for the cluster version"
}
variable "vpc_id" {
  type        = string
  description = "Provide a value for vpc id to create the cluster within the particular network"
}
variable "cluster_endpoint_public_access" {
  type        = bool
  description = "Choose if the endpoint is public or not"
}
variable "cluster_endpoint_private_access" {
  type        = bool
  description = "Choose if the endpoint is private or not"
}
variable "subnets_ids" {
  type        = list(string)
  description = "Prvide a value for subnet ids"
}
variable "min_size" {
  type        = string
  description = "Provide a value for min size for node group"
}
variable "desired_size" {
  type        = string
  description = "Provide a value for desired size for node group"
}
variable "max_size" {
  type        = string
  description = "Provide a value for max size for node group"
}
variable "instance_types" {
  type        = list(string)
  description = "Provide instance types for node group"
}
variable "capacity_type" {
  type        = string
  description = "Provide a capacity type for node group"
}