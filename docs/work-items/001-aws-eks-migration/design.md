---
id: design
aliases: []
tags: []
created_at: 2026-08-13T00:00:00Z
status: done
updated_at: 2026-08-16T00:00:00Z
---

# Design: AWS EKS Migration

## Document Status

- [x] Design file is present in `docs/work-items/001-aws-eks-migration/`.
- [x] Frontmatter metadata added.
- [x] References updated to the prefixed work-item path.

## Technical Approach

- [x] Move the platform from the previous provider to an AWS-first stack built around EKS.
- [x] Run Django and Next.js as separate containerized workloads in Kubernetes.
- [x] Move PostgreSQL to RDS.
- [x] Use AWS-managed secrets and config injection.
- [x] Keep local development aligned with production through a local Kubernetes cluster.
- [x] Standardize local Kubernetes on `k3d`.

## Related Subtasks

- [001-aws-bootstrap-inputs](./subtasks/001-aws-bootstrap-inputs.md)
- [002-account-strategy](./subtasks/002-account-strategy.md)
- [003-network-layout](./subtasks/003-network-layout.md)
- [004-vpc-layout](./subtasks/004-vpc-layout.md)
- [005-identity-layer](./subtasks/005-identity-layer.md)
- [006-aws-organizations-iam](./subtasks/006-aws-organizations-iam.md)
- [007-prepare-iam-cluster-access](./subtasks/007-prepare-iam-cluster-access.md)
- [008-provision-eks-base](./subtasks/008-provision-eks-base.md)
- [009-environment-layout](./subtasks/009-environment-layout.md)
- [010-deployment-service-ingress](./subtasks/010-deployment-service-ingress.md)
- [011-rds-postgresql](./subtasks/011-rds-postgresql.md)
- [012-background-jobs](./subtasks/012-background-jobs.md)

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
**Alternatives considered**: Plain Kubernetes Secrets only, provider-style env files, application-level secret files.
**Rationale**: AWS-managed secret storage is a better fit for the target platform and supports separate envs cleanly.

### Decision: Use AWS Secrets Manager for secrets and SSM Parameter Store for non-secret config

**Choice**: Put credentials, API keys, and passwords in Secrets Manager, and use SSM Parameter Store for non-sensitive environment values.
**Alternatives considered**: Secrets Manager only, SSM only, Kubernetes Secrets only.
**Rationale**: Secrets Manager is the better fit for actual secrets and rotation; SSM is simpler and usually cheaper for plain configuration.

### Decision: Use ArgoCD for GitOps deployment and a separate Ingress Controller for traffic

**Choice**: Use ArgoCD to reconcile manifests from Git, and use an Ingress Controller to expose HTTP/HTTPS routes.
**Alternatives considered**: Imperative `kubectl` deploys, Spinnaker, direct `Service` exposure, NodePort.
**Rationale**: ArgoCD and Ingress Controller solve different problems. ArgoCD manages desired state and drift; the Ingress Controller manages inbound traffic.

### Decision: Use k3d for local Kubernetes development

**Choice**: Standardize local cluster workflows on k3d.
**Alternatives considered**: kind, minikube, Docker Compose only.
**Rationale**: k3d is lightweight, fast to reset, and close enough to the Kubernetes model used in EKS for day-to-day development.

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
```
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
```
Static assets and build artifacts are produced in CI, pushed to ECR, and deployed into EKS. Runtime config is injected from AWS-managed secrets and environment variables. Local development uses the same service split but runs on a local Kubernetes cluster instead of AWS.

## File Changes

| File | Action | Description |
|------|--------|-------------|
| `docs/work-items/001-aws-eks-migration/proposal.md` | Create | Migration proposal with checklist-style scope and outcomes. |
| `docs/work-items/001-aws-eks-migration/design.md` | Create | Architecture design for the AWS migration, including platform tradeoffs. |
| `infra/provisioning/terraform/aws/` | Create | New AWS provisioning root for VPC, EKS, RDS, ECR, IAM, and DNS. |
| `infra/runtime/kubernetes/` | Create | Local Kubernetes manifests or dev overlays for `k3d`. |
| `infra/environments/README.md` | Modify | Update environment guidance away from legacy provider wording. |
| `README.md` | Modify | Replace legacy provider references with AWS/EKS deployment architecture. |
| `infra/tooling/` | Modify | Add cluster/bootstrap scripts for local Kubernetes and AWS workflows. |

## Interfaces / Contracts

Planned environment contracts:

```bash
STACK_ENV=dev|test|qa|staging|prod
DB_CONNECTION_STRING=...
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
2. Stand up a local Kubernetes workflow with `k3d` so the team can work against the same orchestration model.
3. Deploy Django and Next to a non-production EKS environment.
4. Move database connectivity to RDS and migrate data.
5. Cut QA, then staging, then production over to AWS.

## Resolved Questions

- [x] Keep the Next.js app as a single Node server in EKS.
- [x] Make app deploys GitOps-driven with ArgoCD; keep only bootstrap-only operations imperative when needed.
- [x] Use Kustomize overlays for app and platform configuration, with Helm reserved for upstream add-ons when needed.

## GitOps Layout

### Platform Add-ons

```text
gitops-manifests/
└── core-platform/
    └── telemetry/
        ├── applications/
        │   ├── prometheus.yaml
        │   ├── grafana.yaml
        │   ├── alertmanager.yaml
        │   ├── ingress-nginx.yaml
        │   ├── cert-manager.yaml
        │   └── external-dns.yaml
        ├── base/
        │   ├── prometheus/
        │   ├── grafana/
        │   ├── alertmanager/
        │   └── common/
        └── overlays/
            ├── nonprod/
            └── prod/
```

### Application Workloads

```text
gitops-manifests/
└── user-apps/
    ├── base/
    │   ├── django/
    │   └── nextjs/
    └── overlays/
        ├── local/
        ├── nonprod/
        └── prod/
```

### Responsibilities

- `applications/*.yaml` should hold ArgoCD `Application` resources.
- `base/` should hold shared manifests and config.
- `overlays/` should hold environment-specific differences.
- Helm should be used for upstream add-ons when that is the clearest install path.

### Workflow
```
[Tu PC] -> Usas GitHub CLI para enviar código modificado a GitHub.
   ↓
[CI/CD] -> Docker empaqueta el nuevo código en una imagen.
    ↓
[Git]   -> Helm/Kustomize actualizan los planos con la nueva versión de Docker.
    ↓
[ArgoCD] -> Detecta el cambio en Git y reconcilia el estado deseado.
   ↓
[Kubernetes] -> Descarga la imagen de Docker y reemplaza la app vieja sin caídas.
    ↓
[Ingress Controller] -> Publica el tráfico HTTP/HTTPS hacia los servicios.
    ↓
[Prometheus + Grafana] -> Monitorean que la nueva versión no consuma demasiada RAM.
```

### Boceto de directorio
Orden lógico recomendado: `provisioning -> configuration -> source-code -> gitops-manifests -> automation`.

```
mi-proyecto-monorepo/

├── provisioning/              # ARTEFACTO: Estado de la Infraestructura Física
│   │                          # Ciclo de vida: Lento (se ejecuta una vez al mes/año)
│   └── cloud-resources/       # Planos de Terraform para levantar servidores, VPCs y discos
│       ├── clusters.tf
│       └── networks.tf

├── configuration/             # ARTEFACTO: Estado del Sistema Operativo y Nodos
│   │                          # Ciclo de vida: Medio (se ejecuta en parches o escalabilidad)
│   └── runtime/               # Helpers operativos y manifests locales
│       ├── cluster.sh
│       └── kubernetes/

├── source-code/               # ARTEFACTO: Lógica de Negocio Pura (Tus aplicaciones)
│   │                          # Ciclo de vida: Continuo (múltiples cambios al día)
│   └── billing-service/       # Tu app con arquitectura Hexagonal / DDD / CQRS
│       ├── src/               # Código agnóstico a la infraestructura
│       └── artifacts/         # El puente: Dockerfile para empaquetar la app
│           └── Dockerfile

├── gitops-manifests/          # ARTEFACTO: El Estado Deseado del Clúster (El "Qué")
│   │                          # Ciclo de vida: Rápido (cambia con cada nueva versión de la app)
│   ├── core-platform/         # Infraestructura interna de Kubernetes (Herramientas de soporte)
│   │   ├── telemetry/         # Planos para Prometheus y Grafana
│   │   └── controllers/       # Planos para ArgoCD, Ingress Controllers y otros add-ons
│   │
│   └── user-apps/             # Planos de tus aplicaciones (Helm / Kustomize)
│       ├── base/              # Plantillas base del despliegue (Deployment, Service)
│       └── environments/      # Parámetros específicos por entorno
│           ├── local/         # Réplicas: 1, Recursos: Bajos, Modo: Debug
│           └── cloud-prod/    # Réplicas: 3, Recursos: Altos, Modo: Production

└── .github/automation/        # ARTEFACTO: Las Reglas de Tránsito (El "Cómo" se mueve todo)
    │                          # Ciclo de vida: Estable (rara vez cambia)
    └── pipelines/             # GitHub Actions / GitHub CLI scripts que coordinan el flujo
        ├── build-app.yaml     # Toma 'source-code', testea, compila y sube a Docker Hub
        └── sync-gitops.yaml   # Modifica 'gitops-manifests' para avisarle a ArgoCD
```
