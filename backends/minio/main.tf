terraform {
  required_version = ">= 1.7"
  required_providers {
    aws = { source = "hashicorp/aws"; version = "~> 5.0" }
  }

  # MinIO is S3-compatible — point the S3 backend at the local MinIO instance.
  # Run `terraform init -backend-config=backend.hcl` using the file below.
  backend "s3" {
    bucket = "terraform-state"
    key    = "java-secure-pipeline/local/terraform.tfstate"
    region = "us-east-1"                        # MinIO ignores region but it must be set

    # MinIO endpoint — override the AWS S3 endpoint
    endpoint                    = "http://localhost:9000"
    access_key                  = "minioadmin"  # override with $AWS_ACCESS_KEY_ID
    secret_key                  = "minioadmin_secret"  # override with $AWS_SECRET_ACCESS_KEY
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true          # required for MinIO
    encrypt                     = false         # no KMS locally
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = var.minio_access_key
  secret_key                  = var.minio_secret_key
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3 = "http://localhost:9000"
  }
}

variable "minio_access_key" {
  default = "minioadmin"
}
variable "minio_secret_key" {
  default   = "minioadmin_secret"
  sensitive = true
}

# Example: create a bucket via Terraform for pipeline artefacts
resource "aws_s3_bucket" "pipeline_reports" {
  bucket = "pipeline-reports"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state"
}
