variable "vpc_name" {
  type        = string
  description = "AWS VPC name"
}
variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR"
}
variable "region" {
  type        = string
  description = "AWS region"
}

variable "vpc_availability_zones" {
  type        = list(string)
  description = "Availability zones"
}

variable "vpc_private_subnets" {
  type        = list(string)
  description = "Private subnet cidr"
}

variable "vpc_public_subnets" {
  type        = list(string)
  description = "Public subnet cidr"

}

variable "vpc_enable_nat_gateway" {
  type        = bool
  description = "Enable_nat_gateway"
}

variable "vpc_single_nat_gateway" {
  type        = bool
  description = "Single_nat_gateway"
}

variable "vpc_enable_dns_hostnames" {
  type        = bool
  description = "Enable_dns_hostnames"
}

variable "vpc_enable_dns_support" {
  type        = bool
  description = "Enable_dns_support "
}