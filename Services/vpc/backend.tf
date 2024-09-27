# backend configuration for storing the statefile
terraform {
  backend "s3" {
    bucket         = "terra-state-east"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state"
  }
}