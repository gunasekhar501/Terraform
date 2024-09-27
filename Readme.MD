EKS and VPC Setup using Terraform
This repository contains Terraform scripts to create an Amazon EKS (Elastic Kubernetes Service) cluster and a VPC (Virtual Private Cloud). The infrastructure is provisioned on AWS using best practices for security, scalability, and high availability.

Prerequisites
Terraform v1.0 or later
AWS CLI installed and configured with necessary credentials
AWS IAM permissions to provision EKS, VPC, EC2, IAM, and related resources
kubectl installed for interacting with the Kubernetes cluster
Optional: Helm for managing Kubernetes packages
AWS IAM Permissions
Make sure your AWS user has the following permissions:

eks:*
ec2:*
iam:*
autoscaling:*
S3 Backend (Optional)
If using remote state management, configure an S3 bucket for storing Terraform state and DynamoDB for state locking:

hcl
Copy code
terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "eks-cluster/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-lock"
  }
}
VPC and EKS Architecture
The Terraform code creates the following resources:

VPC: Custom VPC with private and public subnets across multiple availability zones (AZs).
EKS Cluster: Kubernetes control plane with worker nodes (EC2 instances) deployed in the private subnets.
Node Groups: Managed and self-managed node groups for the worker nodes.
IAM Roles and Policies: Necessary roles and permissions for EKS and EC2 instances.
Directory Structure
graphql
Copy code
├── main.tf               # Main Terraform file for resource creation
├── vpc.tf                # VPC configuration
├── eks.tf                # EKS configuration
├── outputs.tf            # Outputs for VPC and EKS
├── variables.tf          # Input variables
├── versions.tf           # Terraform and provider versions
└── README.md             # Project documentation
Getting Started
Step 1: Clone the Repository
bash
Copy code
git clone https://github.com/your-repo/eks-terraform
cd eks-terraform
Step 2: Initialize Terraform
bash
Copy code
terraform init
This will download the necessary provider plugins and set up your working directory.

Step 3: Review and Update Variables
Open variables.tf and update the values as needed:

VPC CIDR block
Subnet CIDR blocks
Cluster name
Instance types
Desired node count
Example:

hcl
Copy code
variable "cluster_name" {
  description = "The name of the EKS cluster"
  default     = "my-eks-cluster"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}
You can also define these variables in a separate file (terraform.tfvars):

hcl
Copy code
cluster_name = "my-eks-cluster"
vpc_cidr     = "10.0.0.0/16"
Step 4: Plan the Infrastructure
Generate an execution plan and review it:

bash
Copy code
terraform plan
Step 5: Apply the Configuration
Deploy the infrastructure:

bash
Copy code
terraform apply
Type yes when prompted to confirm the creation of resources.

Step 6: Configure kubectl
Once the EKS cluster is up, configure your kubectl to connect to the cluster:

bash
Copy code
aws eks --region <region> update-kubeconfig --name <cluster_name>
Step 7: Verify the Cluster
Check the nodes and Kubernetes components:

bash
Copy code
kubectl get nodes
kubectl get pods --all-namespaces
Variables
Name	Description	Default
cluster_name	The name of the EKS cluster	my-eks-cluster
vpc_cidr	CIDR block for the VPC	10.0.0.0/16
private_subnets	List of CIDR blocks for private subnets	["10.0.1.0/24"]
public_subnets	List of CIDR blocks for public subnets	["10.0.2.0/24"]
instance_type	EC2 instance type for worker nodes	t3.medium
desired_capacity	Desired number of worker nodes	3
max_size	Maximum number of worker nodes	5
min_size	Minimum number of worker nodes	1
Outputs
EKS Cluster Endpoint: The URL to connect to the EKS cluster
VPC ID: The ID of the created VPC
Security Groups: Security groups attached to the EKS cluster
Node Group Information: Details about the worker nodes
Cleaning Up
To destroy the infrastructure when no longer needed, run:

bash
Copy code
terraform destroy
Troubleshooting
Common Issues
Permission Errors: Ensure your AWS credentials have the necessary permissions to create EKS and VPC resources.
Cluster Connectivity: Verify that kubectl is correctly configured by running aws eks update-kubeconfig.