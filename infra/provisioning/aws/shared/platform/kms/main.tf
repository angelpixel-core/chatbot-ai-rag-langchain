locals {
  key_layout = {
    state      = "kms/state"
    audit_logs = "kms/audit-logs"
    secrets    = "kms/secrets"
    rds        = "kms/rds"
    s3_media   = "kms/s3-media"
  }

  key_purpose = {
    state      = "terraform state and bootstrap metadata"
    audit_logs = "CloudTrail, Config, and centralized logs"
    secrets    = "Secrets Manager and secret material"
    rds        = "database encryption at rest"
    s3_media   = "media and object storage encryption"
  }
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "key" {
  for_each = local.key_layout

  statement {
    sid    = "EnableRootAccess"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    actions   = ["kms:*"]
    resources = ["*"]
  }
}

resource "aws_kms_key" "this" {
  for_each = local.key_layout

  description             = "${each.key} key for AWS bootstrap"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.key[each.key].json

  tags = merge(var.tags, {
    Name    = each.value
    purpose = local.key_purpose[each.key]
  })
}

resource "aws_kms_alias" "this" {
  for_each = local.key_layout

  name          = "alias/${each.value}"
  target_key_id = aws_kms_key.this[each.key].key_id
}
