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

  policy_dir = "${path.module}/../policies/scp"
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

resource "aws_organizations_policy" "shared_platform_root_guardrails" {
  name        = "shared-platform-root-guardrails"
  description = "Root guardrails for the shared platform organization scaffold."
  content     = file("${local.policy_dir}/shared-platform-root-guardrails.json")
}

resource "aws_organizations_policy" "nonprod_guardrails" {
  name        = "nonprod-guardrails"
  description = "Guardrails for non-production accounts."
  content     = file("${local.policy_dir}/nonprod-guardrails.json")
}

resource "aws_organizations_policy" "prod_guardrails" {
  name        = "prod-guardrails"
  description = "Guardrails for production accounts."
  content     = file("${local.policy_dir}/prod-guardrails.json")
}

resource "aws_organizations_policy_attachment" "shared_platform_root_guardrails" {
  policy_id = aws_organizations_policy.shared_platform_root_guardrails.id
  target_id = aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_policy_attachment" "nonprod_guardrails" {
  policy_id = aws_organizations_policy.nonprod_guardrails.id
  target_id = aws_organizations_organizational_unit.nonprod.id
}

resource "aws_organizations_policy_attachment" "prod_guardrails" {
  policy_id = aws_organizations_policy.prod_guardrails.id
  target_id = aws_organizations_organizational_unit.prod.id
}
