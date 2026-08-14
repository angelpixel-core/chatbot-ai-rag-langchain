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

data "aws_iam_policy_document" "admin_trust" {
  statement {
    sid    = "AllowSharedAccountRoot"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.shared_account_id}:root"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "deploy_trust" {
  statement {
    sid    = "AllowSharedAccountRoot"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.shared_account_id}:root"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "break_glass_trust" {
  statement {
    sid    = "AllowSharedAccountRoot"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.shared_account_id}:root"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "admin_permissions" {
  statement {
    sid       = "AdminAccess"
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "deploy_permissions" {
  statement {
    sid    = "DeployAccess"
    effect = "Allow"

    actions = [
      "iam:GetRole",
      "iam:PassRole",
      "sts:AssumeRole",
      "eks:DescribeCluster",
      "eks:ListClusters",
      "eks:AccessKubernetesApi",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:PutImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "break_glass_permissions" {
  statement {
    sid       = "BreakGlassAccess"
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
}

resource "aws_iam_role" "shared_platform_admin" {
  name               = "shared-platform-admin"
  assume_role_policy = data.aws_iam_policy_document.admin_trust.json

  tags = var.tags
}

resource "aws_iam_role_policy" "shared_platform_admin" {
  name   = "shared-platform-admin"
  role   = aws_iam_role.shared_platform_admin.id
  policy = data.aws_iam_policy_document.admin_permissions.json
}

resource "aws_iam_role" "shared_platform_deploy" {
  name               = "shared-platform-deploy"
  assume_role_policy = data.aws_iam_policy_document.deploy_trust.json

  tags = var.tags
}

resource "aws_iam_role_policy" "shared_platform_deploy" {
  name   = "shared-platform-deploy"
  role   = aws_iam_role.shared_platform_deploy.id
  policy = data.aws_iam_policy_document.deploy_permissions.json
}

resource "aws_iam_role" "shared_platform_break_glass" {
  name               = "shared-platform-break-glass"
  assume_role_policy = data.aws_iam_policy_document.break_glass_trust.json

  tags = var.tags
}

resource "aws_iam_role_policy" "shared_platform_break_glass" {
  name   = "shared-platform-break-glass"
  role   = aws_iam_role.shared_platform_break_glass.id
  policy = data.aws_iam_policy_document.break_glass_permissions.json
}
