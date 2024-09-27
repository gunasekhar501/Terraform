###############################################
# EKS Clsuter 
###############################################
region = "us-east-1"
## Application Cluster ##
cluster_name                    = "Dev-World"
cluster_version                 = "1.30"
vpc_id                          = "vpc-04a09cda068fd2657"
cluster_endpoint_public_access  = false
cluster_endpoint_private_access = true
subnets_ids                     = ["subnet-082dfb56e248ebde0", "subnet-05381085fb0a71276"]
ond_min_size                    = 1
ond_desired_size                = 1
ond_max_size                    = 3
ond_instance_types              = ["t3a.xlarge"]
ond_capacity_type               = "ON_DEMAND"
############################## Tags ##################################
project_name = "Test-project"
application  = "Test-App"
location     = "us-east-1"
department   = "DevOps"
owner        = "Gunasekhar A"