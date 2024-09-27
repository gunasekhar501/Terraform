# EKS and VPC Setup using Terraform

This repository contains Terraform scripts to create an Amazon EKS (Elastic Kubernetes Service) cluster and a VPC (Virtual Private Cloud). The infrastructure is provisioned on AWS using best practices for security, scalability, and high availability.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) v1.0 or later
- AWS CLI installed and configured with necessary credentials
- AWS IAM permissions to provision EKS, VPC, EC2, IAM, and related resources
- [kubectl](https://kubernetes.io/docs/tasks/tools/) installed for interacting with the Kubernetes cluster
- Optional: [Helm](https://helm.sh/) for managing Kubernetes packages

### AWS IAM Permissions
Make sure your AWS user has the following permissions:
- `eks:*`
- `ec2:*`
- `iam:*`
- `autoscaling:*`

### S3 Backend (Optional)
If using remote state management, configure an S3 bucket for storing Terraform state and DynamoDB for state locking:
```hcl
terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "eks-cluster/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-lock"
  }
}
