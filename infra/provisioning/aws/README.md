# AWS Provisioning

AWS-first provisioning layout for the EKS migration.

## Structure

- `shared/platform/` for shared tooling and bootstrap resources.
- `nonprod/` for QA and staging.
- `prod/` for production.

## Current State

- These directories are Terraform root scaffolds for the AWS migration.
- `shared/platform` is the first bootstrap root.
- `nonprod` and `prod` currently capture the account/environment layout and will host their AWS resources next.

## Notes

- This tree replaces the Render-specific provisioning layout over time.
- Existing Render Terraform components can be used as reference material when shaping the AWS modules and env layouts.
- Keep shared concerns in `shared/platform` and environment-specific concerns in `nonprod` or `prod`.
