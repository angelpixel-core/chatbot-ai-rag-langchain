output "organization_structure" {
  value       = local.organization_structure
  description = "Planned AWS Organizations account structure."
}

output "planned_resources" {
  value       = local.planned_resources
  description = "Planned org-level bootstrap resources."
}

output "organization_id" {
  value       = aws_organizations_organization.this.id
  description = "AWS Organization ID."
}

output "organizational_units" {
  value = {
    shared  = aws_organizations_organizational_unit.shared.id
    nonprod = aws_organizations_organizational_unit.nonprod.id
    prod    = aws_organizations_organizational_unit.prod.id
  }
  description = "Created AWS Organizations OUs."
}

output "accounts" {
  value = {
    shared  = aws_organizations_account.shared_platform.id
    nonprod = aws_organizations_account.nonprod.id
    prod    = aws_organizations_account.prod.id
  }
  description = "Created AWS account IDs."
}
