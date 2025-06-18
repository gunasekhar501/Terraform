VPC Terraform Module
This Terraform module creates a complete VPC infrastructure with the following components:
Architecture
* **1 VPC** with IPv4 and IPv6 support
* **3 Private Subnets** (IPv4 only)
* **2 Public Subnets** (IPv4 only)
* **2 Public Subnets** (IPv4 + IPv6)
* **NAT Gateways** for private subnet internet access (optional)
* **Internet Gateway** for public subnet internet access
* **Route Tables** configured appropriately for each subnet type
Directory Structure

```
.
├── main.tf                 # Parent module configuration
├── variables.tf            # Parent module variables
├── outputs.tf              # Parent module outputs
├── terraform.tfvars.example # Example variables file
└── modules/
    └── vpc/
        ├── main.tf         # VPC child module
        ├── variables.tf    # VPC module variables
        └── outputs.tf      # VPC module outputs
```

Usage
Basic Usage

```
hcl
```


```hcl
module "vpc" {
  source = "./modules/vpc"

  name_prefix        = "my-project"
  vpc_cidr          = "10.0.0.0/16"
  create_nat_gateway = true

  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

Full Parent Module Usage
1. Copy the terraform.tfvars.example to terraform.tfvars
2. Modify the variables according to your needs
3. Run terraform commands:

```
bash
```


```bash
terraform init
terraform plan
terraform apply
```

Variables
Parent Module Variables

```
NameDescriptionTypeDefaultRequiredaws_regionAWS regionstringus-east-1noenvironmentEnvironment namestringdevnovpc_cidrCIDR block for VPCstring10.0.0.0/16nocreate_nat_gatewayCreate NAT Gatewaysbooltruenocommon_tagsCommon tags for resourcesmap(string){}no
```

VPC Module Variables

```
NameDescriptionTypeDefaultRequiredname_prefixName prefix for resourcesstring-yesvpc_cidrCIDR block for VPCstring10.0.0.0/16nocreate_nat_gatewayCreate NAT GatewaysbooltruenotagsResource tagsmap(string){}no
```

Outputs
VPC Information
* `vpc_id` - VPC ID
* `vpc_cidr_block` - VPC IPv4 CIDR block
* `vpc_ipv6_cidr_block` - VPC IPv6 CIDR block
* `internet_gateway_id` - Internet Gateway ID
Subnet Information
* `private_subnet_ids` - List of private subnet IDs
* `private_subnet_cidrs` - List of private subnet CIDR blocks
* `public_ipv4_subnet_ids` - List of public IPv4 subnet IDs
* `public_ipv4_subnet_cidrs` - List of public IPv4 subnet CIDR blocks
* `public_ipv6_subnet_ids` - List of public IPv6 subnet IDs
* `public_ipv6_subnet_cidrs` - List of public IPv6 subnet CIDR blocks
* `public_ipv6_subnet_ipv6_cidrs` - List of IPv6 CIDR blocks for IPv6 subnets
NAT Gateway Information
* `nat_gateway_ids` - List of NAT Gateway IDs
* `nat_public_ips` - List of NAT Gateway public IPs
Subnet CIDR Allocation
The module automatically calculates subnet CIDRs using the `cidrsubnet()` function:
* **Private subnets**: 10.0.0.0/24, 10.0.1.0/24, 10.0.2.0/24
* **Public IPv4 subnets**: 10.0.10.0/24, 10.0.11.0/24
* **Public IPv6 subnets**: 10.0.20.0/24, 10.0.21.0/24 (+ IPv6 blocks)
High Availability
* Subnets are distributed across multiple Availability Zones
* Each private subnet gets its own NAT Gateway for redundancy
* NAT Gateways are placed in public IPv4 subnets
Requirements
* Terraform >= 1.0
* AWS Provider ~> 5.0
* Sufficient AWS permissions to create VPC resources
Cost Considerations
* NAT Gateways incur hourly charges and data processing fees
* Set `create_nat_gateway = false` if you don't need internet access from private subnets
* Each private subnet gets its own NAT Gateway for high availability