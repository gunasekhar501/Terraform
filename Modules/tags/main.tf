#This terraform module is designed to provide label names and tags for resources. By using these we can implement a strict naming convention.
locals {
  label_order_defaults = {
    label_order = ["environment", "name"]
  }

  id_context = {
    name        = var.name
    environment = var.environment
  }

  label_order = length(var.label_order) > 0 ? var.label_order : local.label_order_defaults.label_order

  enabled = var.enabled

  name        = var.enabled == true ? lower(format("%v", var.name)) : ""
  project     = var.enabled == true ? lower(format("%v", var.project)) : ""
  application = var.enabled == true ? lower(format("%v", var.application)) : ""
  environment = var.enabled == true ? lower(format("%v", var.environment)) : ""
  location    = var.enabled == true ? lower(format("%v", var.location)) : ""
  department  = var.enabled == true ? lower(format("%v", var.department)) : ""
  owner       = var.enabled == true ? lower(format("%v", var.owner)) : ""
  created_by  = var.enabled == true ? lower(format("%v", var.created_by)) : ""  

  tags_context = {
    project     = local.project
    application = local.application
    environment = local.environment
    location    = local.location
    department  = local.department
    owner       = local.owner
    created_by  = local.created_by 
  }

  generated_tags = { for l in keys(local.tags_context) : title(l) => local.tags_context[l] if length(local.tags_context[l]) > 0 }

  tags = merge(local.generated_tags, var.extra_tags)
}