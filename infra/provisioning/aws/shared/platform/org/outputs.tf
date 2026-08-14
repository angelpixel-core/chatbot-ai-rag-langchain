output "organization_structure" {
  value       = local.organization_structure
  description = "Planned AWS Organizations account structure."
}

output "planned_resources" {
  value       = local.planned_resources
  description = "Planned org-level bootstrap resources."
}
