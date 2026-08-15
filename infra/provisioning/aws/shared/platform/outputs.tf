output "account_layout" {
  value       = local.account_layout
  description = "Declarative map of the AWS account layout used by the migration."
}

output "bootstrap_notes" {
  value       = local.bootstrap_notes
  description = "Notes about the bootstrap phase and what belongs in shared/platform."
}

output "org" {
  value       = module.org
  description = "Planned Organizations scaffold for bootstrap."
}

output "iam" {
  value       = module.iam
  description = "Planned IAM scaffold for bootstrap."
}

output "audit" {
  value       = module.audit
  description = "Planned audit scaffold for bootstrap."
}

output "kms" {
  value       = module.kms
  description = "Planned KMS scaffold for bootstrap."
}

output "network" {
  value       = module.vpc
  description = "Planned shared/platform network scaffold."
}
