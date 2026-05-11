terraform {
  required_version = ">= 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  # Bootstrap: run scripts/deploy-aws.sh first — it creates this bucket
  backend "s3" {
    bucket       = "secureops-tf-state-548039716453"
    key          = "secureops/aws/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = local.tags
  }
}

locals {
  name = "secureops"
  tags = {
    Project     = "java-secure-pipeline"
    Environment = "aws"
    ManagedBy   = "terraform"
    Owner       = var.owner
  }
}

# ── Random DB password ─────────────────────────────────────────────
resource "random_password" "db" {
  length  = 24
  special = false
}

# ── S3 + DynamoDB (state already bootstrapped, module manages reports) ──
module "s3" {
  source = "../../modules/s3"
  name   = local.name
  tags   = local.tags
}

# ── ECR repositories ──────────────────────────────────────────────
module "ecr" {
  source = "../../modules/ecr"
  repo_names = [
    "java-secure-pipeline",
    "secureops-api",
    "secureops-dashboard",
  ]
  tags = local.tags
}

# ── VPC ───────────────────────────────────────────────────────────
module "vpc" {
  source       = "../../modules/vpc"
  name         = local.name
  region       = var.region
  cluster_name = "${local.name}-eks"
  tags         = local.tags
}

# ── EKS ───────────────────────────────────────────────────────────
module "eks" {
  source             = "../../modules/eks"
  cluster_name       = "${local.name}-eks"
  private_subnet_ids = module.vpc.private_subnet_ids
  tags               = local.tags
}

# ── RDS PostgreSQL ────────────────────────────────────────────────
module "rds" {
  source             = "../../modules/rds"
  name               = local.name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  eks_node_sg_id     = module.eks.node_security_group_id
  db_password        = random_password.db.result
  tags               = local.tags
}

# ── Secrets Manager: app secrets bundle ───────────────────────────
resource "aws_secretsmanager_secret" "app" {
  name                    = "/${local.name}/app-secrets"
  recovery_window_in_days = 0
  tags                    = local.tags
}

resource "aws_secretsmanager_secret_version" "app" {
  secret_id = aws_secretsmanager_secret.app.id
  secret_string = jsonencode({
    db_host        = module.rds.host
    db_port        = tostring(module.rds.port)
    db_name        = module.rds.db_name
    db_password    = random_password.db.result
    reports_bucket = module.s3.reports_bucket
    sonar_token    = var.sonar_token
    api_secret_key = var.api_secret_key
  })
}

# ── Outputs ───────────────────────────────────────────────────────
output "eks_cluster_name"    { value = module.eks.cluster_name }
output "eks_endpoint"        { value = module.eks.cluster_endpoint }
output "ecr_registry"        { value = module.ecr.registry_id }
output "ecr_repo_urls"       { value = module.ecr.repo_urls }
output "rds_endpoint"        { value = module.rds.endpoint }
output "reports_bucket"      { value = module.s3.reports_bucket }
output "tf_state_bucket"     { value = module.s3.tf_state_bucket }

output "app_secrets_arn"     { value = aws_secretsmanager_secret.app.arn }

output "kubeconfig_command" {
  value = "aws eks update-kubeconfig --region ${var.region} --name ${module.eks.cluster_name}"
}
