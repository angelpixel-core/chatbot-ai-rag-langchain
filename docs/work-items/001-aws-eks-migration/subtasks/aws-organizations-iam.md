---
id: aws-organizations-iam
aliases: []
tags: []
created_at: 2026-08-14T00:00:00Z
status: draft
updated_at: 2026-08-14T00:00:00Z
---

# Subtask: AWS Organizations and IAM

## Goal

Define the AWS Organizations structure, account boundaries, and IAM access model before network or cluster provisioning.

## Required Inputs

- management account ID
- shared/platform account ID
- nonprod account ID
- prod account ID
- admin identity source
- deploy identity source
- break-glass contacts
- billing and security contacts

## Recommendation

- Use `shared/platform` for common bootstrap and shared tooling.
- Use `nonprod` for QA and staging.
- Use `prod` for production.
- Keep human and CI/CD access separated.
- Use least-privilege roles with explicit trust relationships.
- Add baseline guardrails before provisioning workloads.

## Execution Checklist

- [x] Define the AWS Organizations structure.
  - [x] Confirm the management account.
  - [x] Define OUs for `shared`, `nonprod`, and `prod`.
  - [x] Create or confirm the `shared/platform` account.
  - [x] Create or confirm the `nonprod` account.
  - [x] Create or confirm the `prod` account.
- [ ] Define human access.
  - [ ] Define the admin identity source.
  - [ ] Define who can access `shared/platform`.
  - [ ] Define who can access `nonprod`.
  - [ ] Define who can access `prod`.
  - [ ] Define break-glass access.
- [x] Define CI/CD access.
  - [x] Define the deploy role for `shared/platform`.
  - [x] Define the deploy role for `nonprod`.
  - [x] Define the deploy role for `prod`.
  - [x] Define trust relationships between accounts.
  - [x] Define least-privilege permissions per role.
- [x] Define baseline security controls.
  - [x] Define SCPs for prod protection.
  - [x] Define SCPs for nonprod guardrails.
  - [x] Define MFA requirements.
  - [x] Define password/session policy if applicable.
- [x] Define audit and encryption foundations.
  - [x] Define CloudTrail ownership.
  - [x] Define AWS Config ownership.
  - [x] Define KMS key strategy if needed.
  - [x] Define log retention expectations.
- [x] Define bootstrap inputs.
  - [x] Replace placeholder account IDs with real IDs.
  - [x] Replace placeholder owner/contact metadata.
  - [x] Confirm region.
  - [x] Confirm tags and naming convention.
- [ ] Validate the bootstrap model.
  - [ ] Confirm role assumption path works.
  - [ ] Confirm humans can access the right accounts.
  - [ ] Confirm CI/CD can assume deploy roles.
  - [ ] Confirm prod remains isolated.

## Notes

- This subtask is intentionally before VPC, EKS, and ECR.
- If AWS Identity Center or another identity source is already in place, wire that into the human access section rather than inventing a new path.
