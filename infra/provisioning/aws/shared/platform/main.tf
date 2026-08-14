locals {
  account_layout = {
    shared_platform = {
      account_id = var.shared_account_id
      purpose    = "shared tooling and platform bootstrap"
      envs       = ["shared"]
    }
    nonprod = {
      account_id = var.nonprod_account_id
      purpose    = "qa and staging"
      envs       = ["qa", "staging"]
    }
    prod = {
      account_id = var.prod_account_id
      purpose    = "production"
      envs       = ["prod"]
    }
  }

  bootstrap_notes = [
    "This root is the starting point for shared AWS platform bootstrap.",
    "Add Organizations, IAM, DNS, GitOps, and observability resources here as the migration matures.",
  ]
}

module "org" {
  source = "./org"

  shared_account_id  = var.shared_account_id
  nonprod_account_id = var.nonprod_account_id
  prod_account_id    = var.prod_account_id
  tags               = var.tags
}

module "iam" {
  source = "./iam"

  region             = var.region
  shared_account_id  = var.shared_account_id
  nonprod_account_id = var.nonprod_account_id
  prod_account_id    = var.prod_account_id
  tags               = var.tags
}

module "audit" {
  source = "./audit"

  region            = var.region
  shared_account_id = var.shared_account_id
  tags              = var.tags
}

module "kms" {
  source = "./kms"

  region             = var.region
  shared_account_id  = var.shared_account_id
  nonprod_account_id = var.nonprod_account_id
  prod_account_id    = var.prod_account_id
  tags               = var.tags
}
