locals {
  environment_layout = {
    account_id        = var.account_id
    shared_account_id = var.shared_account_id
    environments      = ["prod"]
    purpose           = "production"
  }

  bootstrap_notes = [
    "This root will host the production AWS stack.",
    "Add prod VPC, EKS, ECR access, and prod-specific shared services here.",
  ]
}
