variable "name" {
  type = string
}

variable "region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_cidr_a" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_cidr_b" {
  type    = string
  default = "10.0.2.0/24"
}

variable "private_cidr_a" {
  type    = string
  default = "10.0.11.0/24"
}

variable "private_cidr_b" {
  type    = string
  default = "10.0.12.0/24"
}

variable "tags" {
  type    = map(string)
  default = {}
}
