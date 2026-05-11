variable "cluster_name" {
  type = string
}

variable "k8s_version" {
  type    = string
  default = "1.31"
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "public_access_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "app_namespace" {
  type    = string
  default = "secureops"
}

variable "tags" {
  type    = map(string)
  default = {}
}
