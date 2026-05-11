variable "cluster_name"         { type = string }
variable "oidc_provider_arn"    { type = string }
variable "oidc_issuer_url"      { type = string }
variable "ecr_repository_arn"   { type = string }
variable "environment"          { type = string }
variable "namespace"            { type = string; default = "java-pipeline" }
variable "service_account_name" { type = string; default = "java-secure-pipeline" }
variable "tags"                 { type = map(string); default = {} }
