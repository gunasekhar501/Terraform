variable "region" {
  type    = string
  default = "us-east-1"
}

variable "owner" {
  type    = string
  default = "secureops-team"
}

variable "node_instance_types" {
  type    = list(string)
  default = ["t2.micro"]
}

variable "capacity_type" {
  type    = string
  default = "ON_DEMAND"
}

variable "node_desired" {
  type    = number
  default = 2
}

variable "node_min" {
  type    = number
  default = 1
}

variable "node_max" {
  type    = number
  default = 4
}

variable "sonar_token" {
  type      = string
  default   = ""
  sensitive = true
}

variable "api_secret_key" {
  type      = string
  default   = "change-me-in-production"
  sensitive = true
}
