terraform {
  required_version = ">= 1.7"
  required_providers {
    aws = { source = "hashicorp/aws"; version = "~> 5.0" }
    tls = { source = "hashicorp/tls"; version = "~> 4.0" }
  }
  backend "s3" {
    bucket         = "bank-terraform-state-dev"
    key            = "java-secure-pipeline/dev/terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    kms_key_id     = "alias/terraform-state"
    dynamodb_table = "terraform-locks"
  }
}

provider "aws" {
  region = "eu-west-2"
  default_tags {
    tags = {
      Environment = "dev"
      Project     = "java-secure-pipeline"
      ManagedBy   = "terraform"
      CostCentre  = "PLATFORM-001"
    }
  }
}

module "ecr" {
  source                 = "../../modules/ecr"
  name                   = "java-secure-pipeline"
  kms_key_arn            = data.aws_kms_key.ecr.arn
  gitlab_runner_role_arn = module.iam.gitlab_runner_role_arn
  eks_node_role_arn      = module.eks.node_group_role_arn
  tags = {
    Environment = "dev"
    Service     = "java-secure-pipeline"
  }
}

module "eks" {
  source               = "../../modules/eks"
  cluster_name         = "bank-eks-dev"
  cluster_version      = "1.29"
  vpc_id               = data.aws_vpc.main.id
  subnet_ids           = data.aws_subnets.private.ids
  kms_key_arn          = data.aws_kms_key.eks.arn
  node_instance_types  = ["m6i.large"]
  node_desired_size    = 2
  node_min_size        = 1
  node_max_size        = 5
  tags = {
    Environment = "dev"
  }
}

module "iam" {
  source               = "../../modules/iam"
  cluster_name         = module.eks.cluster_name
  oidc_provider_arn    = module.eks.oidc_provider_arn
  oidc_issuer_url      = module.eks.oidc_issuer_url
  ecr_repository_arn   = module.ecr.repository_arn
  environment          = "dev"
  namespace            = "java-pipeline-dev"
  tags = {
    Environment = "dev"
  }
}

data "aws_kms_key" "ecr"  { key_id = "alias/ecr-dev" }
data "aws_kms_key" "eks"  { key_id = "alias/eks-dev" }
data "aws_vpc" "main"     { tags = { Name = "bank-vpc-dev" } }

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
  tags = { Tier = "private" }
}

output "ecr_url"          { value = module.ecr.repository_url }
output "cluster_endpoint" { value = module.eks.cluster_endpoint }
output "app_role_arn"     { value = module.iam.app_role_arn }
