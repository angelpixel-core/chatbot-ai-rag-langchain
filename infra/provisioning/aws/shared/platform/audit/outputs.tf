output "audit_layout" {
  value       = local.audit_layout
  description = "Planned audit baseline."
}

output "audit_scope" {
  value       = local.audit_scope
  description = "Audit services included in the bootstrap scaffold."
}
