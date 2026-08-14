output "role_layout" {
  value       = local.role_layout
  description = "Planned IAM role layout."
}

output "access_principles" {
  value       = local.access_principles
  description = "IAM access principles for bootstrap."
}

output "policy_files" {
  value = {
    admin_trust             = "${local.trust_dir}/shared-platform-admin-trust.json"
    deploy_trust            = "${local.trust_dir}/shared-platform-deploy-trust.json"
    break_glass             = "${local.trust_dir}/shared-platform-break-glass-trust.json"
    future_admin_federation = "${local.trust_dir}/admin-federation.json"
    future_cicd_nonprod     = "${local.trust_dir}/cicd-nonprod-trust.json"
    future_cicd_prod        = "${local.trust_dir}/cicd-prod-trust.json"
    future_break_glass      = "${local.trust_dir}/break-glass.json"
    admin_policy            = "${local.policy_dir}/shared-platform-admin.json"
    nonprod_policy          = "${local.policy_dir}/nonprod-deploy.json"
    prod_policy             = "${local.policy_dir}/prod-deploy.json"
    break_policy            = "${local.policy_dir}/break-glass.json"
  }
  description = "Policy file locations used by the IAM scaffold."
}

output "roles" {
  value = {
    admin       = aws_iam_role.shared_platform_admin.arn
    deploy      = aws_iam_role.shared_platform_deploy.arn
    break_glass = aws_iam_role.shared_platform_break_glass.arn
  }
  description = "Bootstrap IAM roles in shared/platform."
}
