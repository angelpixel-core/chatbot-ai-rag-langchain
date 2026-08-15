---
id: 005-identity-layer
aliases: []
tags: []
created_at: 2026-08-14T00:00:00Z
status: draft
updated_at: 2026-08-14T00:00:00Z
---

# Subtask: Identity Layer

## Goal

Define the identity abstraction independently from any specific IdP, while implementing it in AWS with IAM Identity Center.

## Recommended Model

Identity Source -> Identity Groups -> Access Profiles -> Account Assignments -> IAM Roles / Permission Sets

## Suggested Human Access Matrix

| Account | Admin | Deploy | Read Only | Break Glass |
| --- | --- | --- | --- | --- |
| `shared/platform` | `platform-admins` | `platform-deploys` | `platform-readers` | `platform-break-glass` |
| `nonprod` | `platform-admins`, `dev-leads` | `platform-deploys`, `dev-leads` | `platform-readers`, `devs` | `platform-break-glass` |
| `prod` | `platform-admins` only | `platform-deploys` only | `platform-readers` only if required | `platform-break-glass` |

## Access Profiles

- `admin`
  - full control within the assigned account
  - intended for platform operators
- `deploy`
  - can deploy workloads and inspect runtime state
  - no broad destructive access
- `read-only`
  - can inspect resources and troubleshoot without changing state
- `break-glass`
  - emergency-only access
  - highly restricted and auditable

## IAM Identity Center Mapping

| Group | Access Profile | Permission Set | Accounts |
| --- | --- | --- | --- |
| `platform-admins` | `admin` | `Admin` | `shared/platform`, `nonprod`, `prod` |
| `platform-deploys` | `deploy` | `Deploy` | `shared/platform`, `nonprod`, `prod` |
| `platform-readers` | `read-only` | `ReadOnly` | `shared/platform`, `nonprod`, `prod` |
| `dev-leads` | `deploy` | `NonProdDeploy` | `nonprod` |
| `devs` | `read-only` | `NonProdReadOnly` | `nonprod` |
| `platform-break-glass` | `break-glass` | `BreakGlass` | `shared/platform`, `nonprod`, `prod` |

## Assignment Rules

- One access profile maps to one permission set.
- One permission set can be assigned to multiple accounts.
- `prod` assignments are the strictest and should be the smallest set.
- `dev-leads` only get deploy access in `nonprod`.
- `platform-break-glass` is emergency-only and must be heavily audited.

## Access Notes

- `dev-leads` get deploy access only in `nonprod`.
- `prod` stays limited to `platform-admins` and `platform-deploys` unless a documented exception is required.
- `prod` does not grant `dev-leads` or `devs` access by default.

## Execution Checklist

- [x] Define the identity source abstraction.
- [ ] Define the human identity provider.
- [x] Define the group model.
- [x] Define the access profile model.
- [x] Define the account assignment model.
- [x] Define the break-glass path.
- [x] Define MFA requirements.
- [x] Define session duration policy.
- [x] Define role assumption path.
- [x] Define audit requirements for identity actions.
- [x] Define how the model maps to AWS IAM Identity Center.
- [x] Define how the model could map to another IdP later.
- [x] Define the human access matrix for `shared/platform`.
- [x] Define the human access matrix for `nonprod`.
- [x] Define the human access matrix for `prod`.
- [x] Define the admin access profile.
- [x] Define the deploy access profile.
- [x] Define the read-only access profile.
- [x] Define the break-glass access profile.
- [x] Validate that each group maps to the correct access profile.
- [x] Validate that each access profile maps to the correct account.
- [x] Validate that prod access stays stricter than nonprod.

## Notes

- Keep this model abstract in documentation, then implement it in AWS as IAM Identity Center permission sets and account assignments.
- Human access is the missing piece in the Organizations/IAM bootstrap, so this subtask is the bridge between the abstract model and the AWS implementation.
- The recommended access split is `platform-admins`, `platform-deploys`, `platform-readers`, `dev-leads`, `devs`, and `platform-break-glass` with prod kept stricter than nonprod.
