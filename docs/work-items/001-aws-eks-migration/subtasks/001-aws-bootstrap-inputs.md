---
id: 001-aws-bootstrap-inputs
aliases: []
tags: []
created_at: 2026-08-14T00:00:00Z
status: draft
updated_at: 2026-08-14T00:00:00Z
---

# Subtask: AWS Bootstrap Inputs

## Goal

Collect the minimum information needed to initialize the AWS provisioning roots before real AWS execution is available.

## Required Inputs

- AWS region
- shared/platform account ID
- nonprod account ID
- prod account ID
- account owner contacts or emails
- admin/deploy access model
- common tagging convention
- optional shared bootstrap notes

## Placeholder Convention

- Use `REPLACE_ME_*` values in the example tfvars files.
- Replace every placeholder before running `terraform plan` against a real account.

## Execution Checklist

- [x] Fill `infra/provisioning/aws/shared/platform/terraform.tfvars.example`.
- [x] Fill `infra/provisioning/aws/nonprod/terraform.tfvars.example`.
- [x] Fill `infra/provisioning/aws/prod/terraform.tfvars.example`.
- [ ] Replace placeholder account IDs with real AWS account numbers.
- [ ] Replace placeholder contacts and tags with real team metadata.
- [ ] Confirm the shared/nonprod/prod mapping before any apply.
