
module "vpc" {
  source                = "terraform-aws-modules/vpc/aws"
  version               = "5.2.0"
  name                  = var.vpc_name
  cidr                  = var.vpc_cidr_block
  azs                   = var.vpc_availability_zones
  private_subnets       = var.vpc_private_subnets
  public_subnets        = var.vpc_public_subnets

  enable_nat_gateway   = var.vpc_enable_nat_gateway
  single_nat_gateway   = var.vpc_single_nat_gateway
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  enable_dns_support   = var.vpc_enable_dns_support
  ## VPC flow logs
  enable_flow_log                      = "false"
  create_flow_log_cloudwatch_log_group = "false"
  create_flow_log_cloudwatch_iam_role  = "false"
  tags = module.tags.tags
}