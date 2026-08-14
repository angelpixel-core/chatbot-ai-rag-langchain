# IAM

Terraform module scaffold for IAM bootstrap.

## Responsibility

- Define admin, deploy, and break-glass roles.
- Keep human and CI/CD access separated.
- Model trust relationships for cross-account access.

## Inputs

- region
- shared account ID
- shared account email
- nonprod account ID
- nonprod account email
- prod account ID
- prod account email
- tags
