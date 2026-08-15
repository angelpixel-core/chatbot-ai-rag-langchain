---
id: 010-deployment-service-ingress
aliases: []
tags: []
created_at: 2026-08-14T00:00:00Z
status: draft
updated_at: 2026-08-14T00:00:00Z
---

# Subtask: Deployment, Service, and Ingress

## Goal

Define the Kubernetes boundary for the application runtime, internal service exposure, and external ingress routing.

## Source Material Extracted From Legacy Provider

- `name` becomes the workload/service naming convention.
- `health_check_path` maps to readiness/liveness probe paths.
- `start_command` maps to the container entrypoint or command only when the image needs it.
- `build_command` belongs in CI, not in the Kubernetes runtime layer.
- `env_vars` becomes Kubernetes `env`/`envFrom` plus AWS-managed config injection.
- `auto_deploy` and deploy triggers become GitOps reconciliation, not provider-side deploy hooks.
- `hostname` becomes the public domain or subdomain contract.
- `service_name` maps hostname routing to the backend service.
- `tls_enabled` becomes ingress TLS policy, not a provider toggle.
- `environment` becomes the environment/account boundary for DNS and routing.

## Recommendation

- Use a `Deployment` for the app runtime.
- Use a `Service` for stable in-cluster access.
- Use an `Ingress` for external HTTP/HTTPS routing.
- Use `/up` as the default health endpoint unless the app needs a different contract.
- Keep build steps in CI and deploy steps in GitOps.

## Execution Checklist

- [ ] Define the `Deployment` contract.
  - [ ] Set image, replicas, resources, and rollout strategy.
  - [ ] Map runtime environment variables.
  - [ ] Define readiness and liveness probes.
- [ ] Define the `Service` contract.
  - [ ] Choose `ClusterIP` for internal routing.
  - [ ] Decide service port and target port mapping.
  - [ ] Keep the service name stable for internal callers.
- [ ] Define the `Ingress` contract.
  - [ ] Choose hostnames and path routing.
  - [ ] Define TLS termination.
  - [ ] Connect ingress rules to the service.
  - [ ] Map public hostname to the correct environment.
  - [ ] Define how DNS records point to the ingress entrypoint.
  - [ ] Decide whether hostnames are per account, per env, or both.
  - [ ] Define certificate ownership and renewal behavior.
  - [ ] Keep `tls_enabled` as an ingress-level concern, not a legacy-provider concern.
- [ ] Remove legacy provider-specific deployment concepts from the active migration path.
  - [ ] Retire `build_command` from infrastructure code.
  - [ ] Retire `auto_deploy` and provider-side deploy triggers.
  - [ ] Retire the legacy web-service artifact as an active resource.

## Notes

- This document is the AWS/EKS replacement for the old legacy web-service component.
- Background jobs, if needed later, should be separate from this runtime boundary.
