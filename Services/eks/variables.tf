variable "region" {
  description = "region for application"
  type        = string
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
variable "ond_min_size" {
  type        = string
  description = "Provide a value for min size for node group"
}
variable "ond_desired_size" {
  type        = string
  description = "Provide a value for desired size for node group"
}
variable "ond_max_size" {
  type        = string
  description = "Provide a value for max size for node group"
}
variable "ond_instance_types" {
  type        = list(string)
  description = "Provide instance types for node group"
}
variable "ond_capacity_type" {
  type        = string
  description = "Provide a capacity type for node group"
}
###################### Tags ##############################
variable "project_name" {
  description = "Name of the project"
  type        = string
}
variable "application" {
  description = "Name of the application"
  type        = string
}
variable "location" {
  description = "Provide location"
  type        = string
}
variable "department" {
  description = "Name of the department"
  type        = string
}
variable "owner" {
  description = "Name of the owner"
  type        = string
  default     = ""
}

