---
id: design
aliases: []
tags: []
created_at: 2026-08-13T00:00:00Z
status: draft
updated_at: 2026-08-14T00:00:00Z
---

# Design: AWS EKS Migration

## Document Status

- [x] Design file is present in `docs/work-items/001-aws-eks-migration/`.
- [x] Frontmatter metadata added.
- [x] References updated to the prefixed work-item path.

## Technical Approach

- [x] Move the platform from Render to an AWS-first stack built around EKS.
- [x] Run Django and Next.js as separate containerized workloads in Kubernetes.
- [x] Move PostgreSQL to RDS.
- [x] Use AWS-managed secrets and config injection.
- [x] Keep local development aligned with production through a local Kubernetes cluster.

## Architecture Decisions

### Decision: Use EKS as the primary orchestration layer

**Choice**: Standardize on EKS for app runtime and deployment orchestration.
**Alternatives considered**: ECS Fargate, EC2-only deployments, EKS plus ECS split.
**Rationale**: EKS keeps local and production tooling aligned through Kubernetes primitives. It gives a more portable platform abstraction than ECS, and it avoids fragmenting the system across multiple deployment models.

### Decision: Run both Django and Next.js as containers on the cluster

**Choice**: Deploy the Django server and the Next.js app as separate Kubernetes workloads.
**Alternatives considered**: Next.js as static assets on S3/CloudFront; Next.js on ECS; merging Next into the Django runtime.
**Rationale**: Next.js is expected to use SSR, so it should remain a Node server process rather than being flattened into static hosting. Keeping Django and Next separate preserves clear runtime boundaries and avoids introducing NestJS without a concrete need.

### Decision: Use RDS PostgreSQL for shared persistence

**Choice**: Host PostgreSQL in RDS and keep app databases external to the cluster.
**Alternatives considered**: In-cluster Postgres, Aurora Serverless, self-managed Postgres on EC2.
**Rationale**: RDS reduces operational burden while preserving a managed relational backend. It matches the app's current PostgreSQL assumptions and keeps state outside the application cluster.

### Decision: Use AWS-native secrets and config

**Choice**: Store runtime secrets in AWS Secrets Manager or SSM Parameter Store and inject them into Kubernetes.
**Alternatives considered**: Plain Kubernetes Secrets only, Render-style env files, application-level secret files.
**Rationale**: AWS-managed secret storage is a better fit for the target platform and supports separate envs cleanly.

## Platform Notes

### kind

**What it is**: Kubernetes in Docker.
**Benefits**: Fast to spin up, very common in local dev, simple mental model, easy to reset.
**Contras**: It is still a local simulation, not a managed cluster; networking and storage behavior can differ from AWS; it is less convenient for multi-node scenarios than a full cluster.

### k3d

**What it is**: k3s running in Docker.
**Benefits**: Lightweight, fast, and closer to a real cluster feel than plain Compose; good when you want a very small local footprint.
**Contras**: k3s is not upstream Kubernetes; some production behaviors and add-ons can differ from EKS more than expected; debugging can be slightly more opinionated.

### Secrets Manager vs SSM

**Secrets Manager**: Best when the value is an actual secret that may need rotation, auditability, or tighter secret semantics. It is the cleanest home for credentials, API keys, and database passwords.
**SSM Parameter Store**: Best when the value is configuration rather than a secret, or when you want a simpler and often cheaper store for many environment values.
**Tradeoff**: Secrets Manager is usually stronger for secret lifecycle and rotation; SSM is often simpler for general config. In practice, many teams use Secrets Manager for credentials and SSM for non-secret parameters.

### Next.js as a single Node server in EKS

**Meaning**: Next.js is deployed as one Node runtime that serves SSR, API routes if needed, and the frontend bundle from the same process.
**Why it matters**: This avoids splitting the frontend into separate web and rendering services too early.
**Benefit**: Simpler deployment and fewer moving parts while preserving SSR.
**Contras**: If traffic or responsibilities grow, the Node server can become a bottleneck, and static asset delivery may later be better split out to CDN/object storage.

## Data Flow

    Browser
      │
      ▼
   Route53 / ALB
      │
      ├──────────────► Next.js pod(s)
      │                 │
      │                 └──────► Django API pod(s)
      │                              │
      └──────────────────────────────┴──────► RDS PostgreSQL

Static assets and build artifacts are produced in CI, pushed to ECR, and deployed into EKS. Runtime config is injected from AWS-managed secrets and environment variables. Local development uses the same service split but runs on a local Kubernetes cluster instead of AWS.

## File Changes

| File | Action | Description |
|------|--------|-------------|
| `docs/work-items/001-aws-eks-migration/proposal.md` | Create | Migration proposal with checklist-style scope and outcomes. |
| `docs/work-items/001-aws-eks-migration/design.md` | Create | Architecture design for the AWS migration, including platform tradeoffs. |
| `infra/provisioning/terraform/aws/` | Create | New AWS provisioning root for VPC, EKS, RDS, ECR, IAM, and DNS. |
| `infra/local/kubernetes/` | Create | Local Kubernetes manifests or dev overlays for `kind` or `k3d`. |
| `infra/environments/README.md` | Modify | Update environment guidance away from Render-specific wording. |
| `README.md` | Modify | Replace Render references with AWS/EKS deployment architecture. |
| `infra/tooling/` | Modify | Add cluster/bootstrap scripts for local Kubernetes and AWS workflows. |

## Interfaces / Contracts

Planned environment contracts:

```bash
STACK_ENV=dev|qa|staging|prod
DB_CONNECTION_STRING=...
DB_QA_CONNECTION_STRING=...
DB_STAGING_CONNECTION_STRING=...
DB_PROD_CONNECTION_STRING=...
AWS_REGION=...
AWS_ACCOUNT_ID=...
```

Planned Kubernetes boundary:

```text
server deployment -> Django WSGI app
web deployment    -> Next.js server
db                -> external RDS PostgreSQL
```

## Testing Strategy

| Layer | What to Test | Approach |
|-------|--------------|----------|
| Unit | Env parsing, DB config, service config | Python/Node tests against config helpers. |
| Integration | Django + Postgres connectivity | Local Kubernetes or containerized integration run. |
| E2E | Web request through ingress to app and DB | Smoke test against local cluster, then QA AWS deployment. |

## Migration / Rollout

1. Create the AWS Terraform root and shared network/IAM foundations.
2. Stand up a local Kubernetes workflow with `kind` or `k3d` so the team can work against the same orchestration model.
3. Deploy Django and Next to a non-production EKS environment.
4. Move database connectivity to RDS and migrate data.
5. Cut QA, then staging, then production over to AWS.

## Open Questions

- [ ] Do we standardize local Kubernetes on `kind` or `k3d`?
- [ ] Do we want Kubernetes manifests directly or Helm/Kustomize overlays?
- [ ] Should secrets flow from Secrets Manager or SSM Parameter Store?
- [ ] Do we keep the Next.js app as a single Node server in EKS, or split SSR from static asset delivery later?
