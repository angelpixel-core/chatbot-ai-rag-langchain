---
id: 007-prepare-iam-cluster-access
aliases: []
tags: []
created_at: 2026-08-14T00:00:00Z
status: draft
updated_at: 2026-08-14T00:00:00Z
---

# Subtask: Prepare IAM and Cluster Access

## Goal

Define the access model for EKS and AWS before the cluster exists, keeping the cluster-specific mechanism abstract until live AWS execution is available.

## Recommendation

- Keep the cluster access mechanism abstract for now.
- Separate human access, CI/CD access, workload identity, and break-glass access.
- Keep `prod` stricter than `nonprod`.
- Make the model work for either GitHub-based or GitLab-based CI/CD.

## Access Layers

### Human Access

- `platform-admins` -> cluster/admin access
- `platform-deploys` -> deploy access
- `platform-readers` -> read-only access
- `dev-leads` -> deploy only in `nonprod`
- `devs` -> read-only in `nonprod`
- `platform-break-glass` -> emergency-only access

### CI/CD Access

- Use account-scoped deploy roles.
- Keep one role per account boundary.
- Minimize the permissions each pipeline can assume.
- Support either GitHub Actions or GitLab CI without baking the provider into the cluster model.

### Workload Access

- Use IRSA/OIDC for Kubernetes workloads.
- Scope AWS permissions to service accounts.
- Keep permissions minimum and service-specific.

### Cluster Access

- Leave the concrete EKS access mechanism undecided until the cluster exists.
- Use the documented human and CI/CD role model as the source of truth.
- Decide later whether to map it through EKS Access Entries or the equivalent AWS-native path.

## Execution Checklist

- [x] Define roles for admins, developers, and CI/CD.
- [x] Define human access to EKS by account.
- [x] Define CI/CD assume-role paths per account.
- [x] Define workload identity via IRSA/OIDC.
- [x] Define minimum AWS permissions by namespace or service.
- [x] Define break-glass cluster access.
- [x] Keep the cluster access model abstract until EKS exists.
- [x] Confirm `prod` stays stricter than `nonprod`.
- [ ] Choose the concrete EKS access mechanism when the cluster is available.
- [ ] Validate the model against live AWS credentials.

## Notes

- GitHub or GitLab only matter at the CI/CD boundary; they should not change the AWS access model.
- This subtask bridges account strategy, identity, and the eventual EKS base.
