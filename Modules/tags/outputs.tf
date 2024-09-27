output "name" {
  value       = local.name
  description = "Normalized name."
}


output "environment" {
  value       = local.environment
  description = "Normalized environment"
}

# output "attributes" {
#   value       = local.attributes
#   description = "Normalized attributes."
# }

output "tags" {
  value       = local.tags
  description = "Normalized Tag map."
}

output "label_order" {
  value       = local.label_order
  description = "Normalized Tag map."
}