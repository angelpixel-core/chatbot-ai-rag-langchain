output "environment_layout" {
  value       = local.environment_layout
  description = "Declarative map of the production account and environments."
}

output "bootstrap_notes" {
  value       = local.bootstrap_notes
  description = "Notes about what belongs in prod."
}
