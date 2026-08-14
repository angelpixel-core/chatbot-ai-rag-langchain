---
id: remocion-de-render
aliases: []
tags: []
created_at: 2026-08-14T00:00:00Z
status: draft
updated_at: 2026-08-14T00:00:00Z
---

# Subtask: Remocion de Render

## Goal

Define what can be reused from the Render layout during the AWS/EKS migration, what must be adapted, and what should be retired.

## Recommendation

- Reuse the structure and the intent where it is platform-agnostic.
- Adapt environment separation and resource naming to AWS/EKS.
- Retire all `render_*` provider code and any Render-specific import workflow.
- Do not create a permanent always-on worker unless the app has a real async job queue.

## Execution Checklist

- [x] Mark `infra/provisioning/terraform/render/README.md` as historical reference only.
- [x] Extract `components/web/` into the AWS deployment/service/ingress document.
- [x] Remove `components/web/` from the active Render tree.
- [ ] Decide whether `components/database/` remains as reference material or gets removed.
- [ ] Decide whether `components/dns/` remains as reference material or gets removed.
- [ ] Remove or archive `components/worker/` unless a real async queue appears.
- [ ] Migrate QA, staging, and prod env docs to the AWS tree.
- [ ] Retire Render-specific provider resources from the active migration path.

## Worker Decision

At the moment, there is no evidence of a dedicated async job system in the repo.

- If we later introduce background jobs, model them as a separate Kubernetes `Deployment` only for long-running workers.
- Typical examples: sending emails, generating PDFs, processing webhooks, image/video processing, retrying failed integrations.
- If the work is scheduled, use `CronJob` instead.
- If the work is request-bound, keep it in Django/Next.js rather than splitting infrastructure prematurely.

## Matrix

| Render path | Verdict | AWS/EKS target | Notes |
| --- | --- | --- | --- |
| `infra/provisioning/terraform/render/README.md` | Retire as active doc | `infra/provisioning/aws/README.md` | Keep only as historical context if needed. |
| `infra/provisioning/terraform/render/components/web/` | Retired | `docs/work-items/001-aws-eks-migration/subtasks/deployment-service-ingress.md` | Extracted the useful contract and removed the active Render component. |
| `infra/provisioning/terraform/render/components/database/` | Adapt | RDS + app DB config | Reuse the database sizing and environment input ideas, not the provider resource. |
| `infra/provisioning/terraform/render/components/dns/` | Adapt | Route53 + ingress hostnames | Reuse domain/hostname conventions, not Render-managed DNS. |
| `infra/provisioning/terraform/render/components/worker/` | Retire unless needed | Kubernetes `Deployment` or `CronJob` | Only recreate if a real async background workload exists. |
| `infra/provisioning/terraform/render/envs/qa/` | Adapt | `infra/provisioning/aws/nonprod/` | Keep QA-specific runtime intent, drop Render imports and service IDs. |
| `infra/provisioning/terraform/render/envs/staging/` | Adapt | `infra/provisioning/aws/nonprod/` | Keep staging promotion logic as an AWS environment overlay. |
| `infra/provisioning/terraform/render/envs/prod/` | Adapt | `infra/provisioning/aws/prod/` | Keep prod rollout intent, but move to AWS account/cluster layout. |
| `infra/provisioning/terraform/render/components/*/*.tf` | Retire | New AWS Terraform modules | Provider-specific resources do not transfer directly. |

## Practical Reuse Rules

- Reuse names, environment boundaries, and lifecycle intent.
- Reuse nothing that depends on `render_*` resources or Render imports.
- Rebuild infrastructure resources as AWS-native modules.
- Keep the AWS tree as the source of truth once the migration starts.
