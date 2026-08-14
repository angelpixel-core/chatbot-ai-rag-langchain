output "role_layout" {
  value       = local.role_layout
  description = "Planned IAM role layout."
}

output "access_principles" {
  value       = local.access_principles
  description = "IAM access principles for bootstrap."
}
