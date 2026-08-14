locals {
  role_layout = {
    admin_roles       = ["shared-platform-admin", "nonprod-admin", "prod-admin"]
    deploy_roles      = ["shared-platform-deploy", "nonprod-deploy", "prod-deploy"]
    break_glass_roles = ["shared-platform-break-glass", "prod-break-glass"]
  }

  access_principles = [
    "Separate human and CI/CD access.",
    "Use explicit trust relationships.",
    "Prefer role assumption over long-lived IAM users.",
  ]

  trust_dir  = "${path.module}/../policies/trust"
  policy_dir = "${path.module}/../policies/iam"
}

resource "aws_iam_role" "shared_platform_admin" {
  name               = "shared-platform-admin"
  assume_role_policy = file("${local.trust_dir}/shared-platform-admin-trust.json")

  tags = var.tags
}

resource "aws_iam_role_policy" "shared_platform_admin" {
  name   = "shared-platform-admin"
  role   = aws_iam_role.shared_platform_admin.id
  policy = file("${local.policy_dir}/shared-platform-admin.json")
}

resource "aws_iam_role" "shared_platform_deploy" {
  name               = "shared-platform-deploy"
  assume_role_policy = file("${local.trust_dir}/shared-platform-deploy-trust.json")

  tags = var.tags
}

resource "aws_iam_role_policy" "shared_platform_deploy" {
  name   = "shared-platform-deploy"
  role   = aws_iam_role.shared_platform_deploy.id
  policy = file("${local.policy_dir}/nonprod-deploy.json")
}

resource "aws_iam_role" "shared_platform_break_glass" {
  name               = "shared-platform-break-glass"
  assume_role_policy = file("${local.trust_dir}/shared-platform-break-glass-trust.json")

  tags = var.tags
}

resource "aws_iam_role_policy" "shared_platform_break_glass" {
  name   = "shared-platform-break-glass"
  role   = aws_iam_role.shared_platform_break_glass.id
  policy = file("${local.policy_dir}/break-glass.json")
}
