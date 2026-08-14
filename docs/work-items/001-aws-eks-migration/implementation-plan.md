---
id: implementation-plan
aliases: []
tags: []
created_at: 2026-08-14T00:00:00Z
status: draft
updated_at: 2026-08-14T00:00:00Z
---

# Implementation Plan: AWS EKS Migration

## Goal

Deliver the AWS/EKS platform incrementally without blocking local development.

## Phases

- [ ] Foundation
  - [ ] Provision AWS networking, IAM, ECR, and baseline EKS access.
  - [ ] Define the non-production and production account/environment layout.
- [ ] Local Workflow
  - [ ] Standardize local Kubernetes on `k3d`.
  - [ ] Add local manifests or overlays that mirror the app split used in EKS.
- [ ] Application Packaging
  - [ ] Containerize Django and Next.js as separate workloads.
  - [ ] Confirm image build and push flow into ECR.
- [ ] Data and Secrets
  - [ ] Move PostgreSQL to RDS.
  - [ ] Inject secrets from Secrets Manager and config from SSM Parameter Store.
- [ ] Delivery
  - [ ] Add GitOps deployment via ArgoCD.
  - [ ] Add an Ingress Controller for HTTP/HTTPS traffic.
- [ ] Rollout
  - [ ] Validate in QA, then staging, then production.

## Deliverables

- [ ] AWS infrastructure root for EKS, RDS, ECR, IAM, and networking.
- [ ] Local `k3d` workflow.
- [ ] GitOps manifests for platform and app workloads.
- [ ] Deployment and ingress path for the apps.

## Exit Criteria

- [ ] Local development works against `k3d`.
- [ ] Django and Next.js deploy separately on Kubernetes.
- [ ] Secrets are sourced from AWS-managed services.
- [ ] App deploys are reconciled from Git.
