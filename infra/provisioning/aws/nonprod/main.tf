locals {
  environment_layout = {
    account_id        = var.account_id
    shared_account_id = var.shared_account_id
    environments      = var.environment_names
    purpose           = "qa and staging"
  }

  bootstrap_notes = [
    "This root will host the non-production AWS stack for QA and staging.",
    "Add VPC, EKS, ECR access, and nonprod-specific shared services here.",
  ]
}
