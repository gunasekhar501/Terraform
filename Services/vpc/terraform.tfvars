vpc_name   = "test-project"
vpc_cidr_block = "10.0.0.0/16"
region = "us-east-1"
vpc_availability_zones = [ "us-east-1a", "us-east-1b", "us-east-1c" ]
vpc_private_subnets = ["10.0.0.0/21", "10.0.8.0/21",]
vpc_public_subnets = ["10.0.16.0/21", "10.0.24.0/21", "10.0.32.0/21"]
vpc_enable_nat_gateway = true
vpc_single_nat_gateway = true
vpc_enable_dns_hostnames = true
vpc_enable_dns_support = true