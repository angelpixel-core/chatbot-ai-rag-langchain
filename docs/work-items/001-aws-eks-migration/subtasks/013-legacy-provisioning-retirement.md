---
id: 013-legacy-provisioning-retirement
aliases: []
tags: []
created_at: 2026-08-14T00:00:00Z
status: draft
updated_at: 2026-08-14T00:00:00Z
---

# Subtask: Legacy Provisioning Retirement

## Goal

Define what can be reused from the legacy provider layout during the AWS/EKS migration, what must be adapted, and what should be retired.

## Recommendation

- Reuse the structure and the intent where it is platform-agnostic.
- Adapt environment separation and resource naming to AWS/EKS.
- Retire all legacy provider-specific code and any import workflow tied to the old stack.
- Do not create a permanent always-on worker unless the app has a real async job queue.

## Execution Checklist

- [x] Mark the legacy provisioning README as historical reference only.
- [x] Extract `components/web/` into the AWS deployment/service/ingress document.
- [x] Remove the legacy web component from the active tree.
- [x] Extract `components/database/` into the AWS RDS/PostgreSQL document.
- [x] Remove the legacy database component from the active tree.
- [x] Integrate `components/dns/` into the AWS deployment/service/ingress document.
- [x] Remove the legacy DNS component from the active tree.
- [x] Extract `components/worker/` into the AWS background jobs document.
- [x] Remove the legacy worker component from the active tree.
- [x] Extract QA, staging, and prod env docs into the AWS environment layout document.
- [x] Remove the legacy QA environment tree.
- [x] Remove the legacy staging environment tree.
- [x] Remove the legacy production environment tree.
- [x] Retire legacy provider-specific resources from the active migration path.

## Worker Decision

At the moment, there is no evidence of a dedicated async job system in the repo.

- If we later introduce background jobs, model them as a separate Kubernetes `Deployment` only for long-running workers.
- Typical examples: sending emails, generating PDFs, processing webhooks, image/video processing, retrying failed integrations.
- If the work is scheduled, use `CronJob` instead.
- If the work is request-bound, keep it in Django/Next.js rather than splitting infrastructure prematurely.

## Matrix

| Legacy path | Verdict | AWS/EKS target | Notes |
| --- | --- | --- | --- |
| legacy provisioning README | Retire as active doc | `infra/provisioning/aws/README.md` | Keep only as historical context if needed. |
| legacy web component | Retired | `docs/work-items/001-aws-eks-migration/subtasks/010-deployment-service-ingress.md` | Extracted the useful contract and removed the active component. |
| legacy database component | Retired | `docs/work-items/001-aws-eks-migration/subtasks/011-rds-postgresql.md` | Extracted the useful database contract and removed the active component. |
| legacy DNS component | Retired | `docs/work-items/001-aws-eks-migration/subtasks/010-deployment-service-ingress.md` | Extracted the useful hostname/TLS/routing contract and removed the active component. |
| legacy worker component | Retired | `docs/work-items/001-aws-eks-migration/subtasks/012-background-jobs.md` | Extracted the async worker and media pipeline contract and removed the active component. |
| legacy QA environment tree | Retired | `docs/work-items/001-aws-eks-migration/subtasks/009-environment-layout.md` | Extracted QA runtime, database, and validation intent into AWS environment mapping. |
| legacy staging environment tree | Retired | `docs/work-items/001-aws-eks-migration/subtasks/009-environment-layout.md` | Extracted staging promotion flow into AWS environment mapping. |
| legacy production environment tree | Retired | `docs/work-items/001-aws-eks-migration/subtasks/009-environment-layout.md` | Extracted production release flow into AWS environment mapping. |
| legacy component Terraform resources | Retired | New AWS Terraform modules | Provider-specific resources do not transfer directly. |

## Practical Reuse Rules

- Reuse names, environment boundaries, and lifecycle intent.
- Reuse nothing that depends on legacy provider-specific resources or imports.
- Rebuild infrastructure resources as AWS-native modules.
- Keep the AWS tree as the source of truth once the migration starts.
