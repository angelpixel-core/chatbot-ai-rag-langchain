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

- [ ] Define the AWS Organizations structure.
  - [ ] Confirm the management account.
  - [ ] Define OUs for `shared`, `nonprod`, and `prod`.
  - [ ] Create or confirm the `shared/platform` account.
  - [ ] Create or confirm the `nonprod` account.
  - [ ] Create or confirm the `prod` account.
- [ ] Define human access.
  - [ ] Define the admin identity source.
  - [ ] Define who can access `shared/platform`.
  - [ ] Define who can access `nonprod`.
  - [ ] Define who can access `prod`.
  - [ ] Define break-glass access.
- [ ] Define CI/CD access.
  - [ ] Define the deploy role for `shared/platform`.
  - [ ] Define the deploy role for `nonprod`.
  - [ ] Define the deploy role for `prod`.
  - [ ] Define trust relationships between accounts.
  - [ ] Define least-privilege permissions per role.
- [ ] Define baseline security controls.
  - [ ] Define SCPs for prod protection.
  - [ ] Define SCPs for nonprod guardrails.
  - [ ] Define MFA requirements.
  - [ ] Define password/session policy if applicable.
- [ ] Define audit and encryption foundations.
  - [ ] Define CloudTrail ownership.
  - [ ] Define AWS Config ownership.
  - [ ] Define KMS key strategy if needed.
  - [ ] Define log retention expectations.
- [ ] Define bootstrap inputs.
  - [ ] Replace placeholder account IDs with real IDs.
  - [ ] Replace placeholder owner/contact metadata.
  - [ ] Confirm region.
  - [ ] Confirm tags and naming convention.
- [ ] Validate the bootstrap model.
  - [ ] Confirm role assumption path works.
  - [ ] Confirm humans can access the right accounts.
  - [ ] Confirm CI/CD can assume deploy roles.
  - [ ] Confirm prod remains isolated.

## Notes

- This subtask is intentionally before VPC, EKS, and ECR.
- If AWS Identity Center or another identity source is already in place, wire that into the human access section rather than inventing a new path.
