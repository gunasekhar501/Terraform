###############################################
# EKS Clsuter 
###############################################
region = "us-east-1"
## Application Cluster ##
cluster_name                    = ""
cluster_version                 = "1.30"
vpc_id                          = ""
cluster_endpoint_public_access  = false
cluster_endpoint_private_access = true
subnets_ids                     = [""]
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