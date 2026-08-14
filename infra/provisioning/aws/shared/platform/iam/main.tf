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
}
