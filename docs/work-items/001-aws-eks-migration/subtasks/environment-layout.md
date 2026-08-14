---
id: environment-layout
aliases: []
tags: []
created_at: 2026-08-14T00:00:00Z
status: draft
updated_at: 2026-08-14T00:00:00Z
---

# Subtask: Environment Layout

## Goal

Define how QA, staging, and production map onto AWS accounts, clusters, and promotion flow.

## Source Material Extracted From Render

- `STACK_ENV` becomes the environment selector across AWS deploys.
- `DB_QA_CONNECTION_STRING` becomes the QA database secret/connection contract.
- `DB_PROD_CONNECTION_STRING` becomes the production database secret/connection contract.
- QA becomes the first deployed compatibility checkpoint.
- Staging becomes the release-readiness gate between QA and production.
- Production becomes the final release environment.
- QA validation uses a smoke check against the deployed app before promotion.

## Recommendation

- Map QA and staging to `nonprod`.
- Keep production in `prod`.
- Keep `shared/platform` for central tooling and shared platform bootstrap.
- Make environment names, domains, and credentials consistent across AWS.
- Use promotion flow rather than provider-side environment duplication.

## Execution Checklist

- [ ] Define the environment/account mapping.
  - [ ] Map QA to `nonprod`.
  - [ ] Map staging to `nonprod`.
  - [ ] Map production to `prod`.
  - [ ] Define what is shared in `shared/platform`.
- [ ] Define environment-specific runtime contracts.
  - [ ] Define QA secrets and config.
  - [ ] Define staging secrets and config.
  - [ ] Define production secrets and config.
  - [ ] Keep `STACK_ENV` aligned with deployment targets.
- [ ] Define promotion flow.
  - [ ] QA validates the artifact first.
  - [ ] QA promotes to staging.
  - [ ] Staging smoke checks pass.
  - [ ] Release PR or tag promotes to production.
- [ ] Remove Render-specific environment artifacts from the active migration path.
  - [ ] Retire `render` env import/adoption workflows.
  - [ ] Remove `infra/provisioning/terraform/render/envs/qa/`.
  - [ ] Remove `infra/provisioning/terraform/render/envs/staging/`.
  - [ ] Remove `infra/provisioning/terraform/render/envs/prod/`.

## Notes

- This document replaces the three Render environment READMEs as the active source of truth.
- If environment-specific infra grows substantially, split each environment into its own AWS provisioning doc later.
