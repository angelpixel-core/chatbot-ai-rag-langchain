locals {
  organization_structure = {
    shared = {
      account_id = var.shared_account_id
      envs       = ["shared"]
    }
    nonprod = {
      account_id = var.nonprod_account_id
      envs       = ["qa", "staging"]
    }
    prod = {
      account_id = var.prod_account_id
      envs       = ["prod"]
    }
  }

  planned_resources = [
    "Organizations OUs",
    "Account assignments",
    "Tag conventions",
  ]
}
