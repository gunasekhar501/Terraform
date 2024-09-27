######## Tags Module########
module "tags" {

  source      = "../../../../modules/tags"
  project     = var.project_name
  application = var.application
  environment = var.environment
  location    = var.location
  department  = var.department
  owner       = var.owner
  created_by  = var.created_by
}
