---
id: 009-environment-layout
aliases: []
tags: []
created_at: 2026-08-14T00:00:00Z
status: draft
updated_at: 2026-08-14T00:00:00Z
---

# Subtask: Environment Layout

## Goal

Define how dev, test, QA, staging, and production map onto local compose, CI, AWS accounts, and promotion flow.

## Source Material Extracted From Legacy Provider

- `STACK_ENV` becomes the environment selector across local compose, CI, and AWS deploys.
- `STACK_ENV=dev` drives local compose.
- `STACK_ENV=test` drives CI-backed verification.
- `DB_CONNECTION_STRING` becomes the shared database secret/connection contract.
- QA becomes the first deployed compatibility checkpoint.
- Staging becomes the release-readiness gate between QA and production.
- Production becomes the final release environment.
- QA validation uses a smoke check against the deployed app before promotion.

## Recommendation

- Keep `dev` local with compose.
- Keep `test` in CI as a versioned verification target.
- Map QA and staging to `nonprod`.
- Keep production in `prod`.
- Keep `shared/platform` for central tooling and shared platform bootstrap.
- Make environment names, domains, and credentials consistent across AWS.
- Use promotion flow rather than provider-side environment duplication.

## Execution Checklist

- [x] Define the environment/account mapping.
  - [x] Map dev to local compose.
  - [x] Map test to CI-backed verification.
  - [x] Map QA to `nonprod`.
  - [x] Map staging to `nonprod`.
  - [x] Map production to `prod`.
  - [x] Define what is shared in `shared/platform`.
- [x] Define environment-specific runtime contracts.
  - [x] Define dev secrets and config.
  - [x] Define test secrets and config.
  - [x] Define QA secrets and config.
  - [x] Define staging secrets and config.
  - [x] Define production secrets and config.
  - [x] Keep `STACK_ENV` aligned with deployment targets.
- [x] Define promotion flow.
  - [x] Dev validates locally.
  - [x] Test validates in CI.
  - [x] QA validates the artifact first.
  - [x] QA promotes to staging.
  - [x] Staging smoke checks pass.
  - [x] Release PR or tag promotes to production.
- [x] Remove legacy provider-specific environment artifacts from the active migration path.
  - [x] Retire legacy env import/adoption workflows.
  - [x] Remove the legacy QA environment tree.
  - [x] Remove the legacy staging environment tree.
  - [x] Remove the legacy production environment tree.

## Notes

- This document replaces the three legacy environment READMEs as the active source of truth.
- The active `infra/environments/{dev,test,qa,staging,prod}/` layout now reflects the AWS/local/CI model.
- If environment-specific infra grows substantially, split each environment into its own AWS provisioning doc later.
