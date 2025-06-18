aws_region = "us-east-1"
environment = ""  ## Provide environment name
vpc_cidr = "10.50.0.0/16"
enable_ipv6 = true
enable_dns_hostnames = true
enable_dns_support = true
private_subnet_count = 3
private_subnet_cidrs = [ "10.50.0.0/20", "10.50.16.0/20", "10.50.32.0/20" ]
private_subnet_azs = [ "us-east-1a", "us-east-1b", "us-east-1c" ]
public_ipv4_subnet_count = 2
public_ipv4_subnet_cidrs = [ "10.50.100.0/22", "10.50.104.0/22" ]
public_ipv6_subnet_count = 2
public_ipv6_subnet_cidrs = [ "10.50.200.0/22", "10.50.204.0/22" ]
create_nat_gateway = true
nat_gateway_per_subnet = false
single_nat_gateway = true
create_internet_gateway = true

