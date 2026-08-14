output "account_layout" {
  value       = local.account_layout
  description = "Declarative map of the AWS account layout used by the migration."
}

output "bootstrap_notes" {
  value       = local.bootstrap_notes
  description = "Notes about the bootstrap phase and what belongs in shared/platform."
}
