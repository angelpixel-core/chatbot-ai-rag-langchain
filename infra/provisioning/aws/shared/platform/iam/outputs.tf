output "role_layout" {
  value       = local.role_layout
  description = "Planned IAM role layout."
}

output "access_principles" {
  value       = local.access_principles
  description = "IAM access principles for bootstrap."
}

output "roles" {
  value = {
    admin       = aws_iam_role.shared_platform_admin.arn
    deploy      = aws_iam_role.shared_platform_deploy.arn
    break_glass = aws_iam_role.shared_platform_break_glass.arn
  }
  description = "Bootstrap IAM roles in shared/platform."
}
