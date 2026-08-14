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

resource "aws_organizations_organization" "this" {
  feature_set = "ALL"

  enabled_policy_types = [
    "SERVICE_CONTROL_POLICY",
  ]
}

resource "aws_organizations_organizational_unit" "shared" {
  name      = "shared"
  parent_id = aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_organizational_unit" "nonprod" {
  name      = "nonprod"
  parent_id = aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_organizational_unit" "prod" {
  name      = "prod"
  parent_id = aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_account" "shared_platform" {
  name      = "shared-platform"
  email     = var.shared_account_email
  parent_id = aws_organizations_organizational_unit.shared.id
  role_name = "OrganizationAccountAccessRole"

  tags = var.tags
}

resource "aws_organizations_account" "nonprod" {
  name      = "nonprod"
  email     = var.nonprod_account_email
  parent_id = aws_organizations_organizational_unit.nonprod.id
  role_name = "OrganizationAccountAccessRole"

  tags = var.tags
}

resource "aws_organizations_account" "prod" {
  name      = "prod"
  email     = var.prod_account_email
  parent_id = aws_organizations_organizational_unit.prod.id
  role_name = "OrganizationAccountAccessRole"

  tags = var.tags
}
