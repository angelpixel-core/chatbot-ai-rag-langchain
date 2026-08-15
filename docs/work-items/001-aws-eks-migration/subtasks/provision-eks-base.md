---
id: provision-eks-base
aliases: []
tags: []
created_at: 2026-08-14T00:00:00Z
status: draft
updated_at: 2026-08-14T00:00:00Z
---

# Subtask: Provision the EKS Base

## Goal

Provision the first AWS EKS cluster in `nonprod` with a minimal but production-shaped baseline.

## Recommendation

- Create the initial cluster in `nonprod`.
- Use managed node groups.
- Start with one small baseline node group.
- Keep the cluster private by default unless ingress or admin access requires otherwise.
- Enable base logging and monitoring from the start.
- Use the documented IAM and cluster access model, but keep the concrete access mechanism aligned with the cluster implementation.

## Cluster Baseline

- Kubernetes version: choose a current supported EKS version.
- Cluster type: managed EKS control plane.
- Node strategy: one managed node group for the initial rollout.
- Capacity strategy: enough for platform add-ons and one or two app workloads.
- Networking: use the reserved `nonprod` VPC and private app subnets.
- Access: map platform/admin/deploy/read roles into cluster access.

## Initial Scope

- EKS control plane in `nonprod`
- one managed node group
- logging enabled
- monitoring hooks enabled
- baseline cluster access validated from local environment

## Inputs

- nonprod VPC ID
- private app subnet IDs
- shared IAM/cluster access model
- region
- tags

## Execution Checklist

- [x] Create the initial cluster in `nonprod`.
- [x] Define the initial node groups.
- [x] Enable base logging and monitoring.
- [ ] Validate access from the local environment.
- [ ] Wire cluster access to the IAM model.
- [ ] Confirm workloads can schedule on the initial node group.
- [ ] Confirm `prod` stays out of scope until nonprod is stable.

## Notes

- This subtask is the first real Kubernetes bootstrap step.
- Keep the initial footprint small so the cluster can be validated before expanding.
