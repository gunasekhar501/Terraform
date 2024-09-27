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

### Folder Descriptions:

- **services/eks**: Contains all Terraform configurations related to provisioning the Amazon EKS cluster, including resources like worker nodes, IAM roles, and security groups.
  
- **services/vpc**: Contains Terraform configurations for setting up the VPC, including subnets, route tables, internet gateways, and NAT gateways.
  
- **terraform.tfvars**: This file holds the variable values that are passed into the `variables.tf` files, such as cluster name, VPC CIDR, etc.
  
- **backend.tf**: Configuration file for managing Terraform state remotely using S3 and DynamoDB for state locking (optional).
  
- **providers.tf**: Configures the AWS provider, which connects Terraform to AWS and allows it to provision resources.

This directory structure helps maintain a clean and modular separation of concerns between the VPC and EKS setup.
