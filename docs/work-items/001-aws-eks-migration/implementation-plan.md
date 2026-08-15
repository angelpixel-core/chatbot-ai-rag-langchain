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

- [ ] Organizations / IAM
  - [x] Define the AWS Organizations structure.
  - [x] Define human access.
  - [x] Define the identity layer abstraction.
  - [x] Define CI/CD access.
  - [x] Define baseline security controls.
  - [x] Define audit and encryption foundations.
  - [x] Define bootstrap inputs.
  - [ ] Validate the bootstrap model.

- [ ] Foundation
  - [x] Define the AWS account strategy.
    - [x] Use `shared/platform` for central tooling.
    - [x] Use `nonprod` for QA and staging.
    - [x] Use `prod` for production.
    - [ ] Create the AWS accounts in Organizations.
    - [x] Define human access per account.
    - [x] Define CI/CD roles per account.
    - [x] Define what belongs in each account.
    - [x] Define naming conventions for accounts and resources.
  - [x] Create the AWS provisioning skeleton.
    - [x] Create `infra/provisioning/aws/`.
    - [x] Create `infra/provisioning/aws/shared/platform/`.
    - [x] Create `infra/provisioning/aws/nonprod/`.
    - [x] Create `infra/provisioning/aws/prod/`.
    - [ ] Decide which Render Terraform pieces to reuse as migration inputs.
    - [ ] Decide which Render Terraform pieces to retire.
  - [x] Document the AWS bootstrap inputs and placeholder convention.
  - [x] Establish the base network per account.
    - [ ] Create one VPC per account.
    - [ ] Define public and private subnets.
    - [ ] Define NAT and egress paths.
    - [x] Reserve non-overlapping CIDR ranges.
    - [ ] Define DNS and naming conventions.
  - [x] Prepare IAM and cluster access.
    - [x] Define roles for admins, developers, and CI/CD.
    - [x] Define initial EKS access.
    - [x] Prepare IRSA/OIDC for workloads.
    - [x] Define minimum permissions by namespace or service.
  - [ ] Provision the EKS base.
    - [ ] Create the initial cluster in `nonprod`.
    - [ ] Define the initial node groups.
    - [ ] Enable base logging and monitoring.
    - [ ] Validate access from the local environment.
  - [ ] Provision ECR.
    - [ ] Create repos for `django`.
    - [ ] Create repos for `nextjs`.
    - [ ] Define lifecycle and permission policies.
    - [ ] Validate push and pull from CI/CD.
  - [ ] Define the environment layout.
    - [ ] Map QA to `nonprod`.
    - [ ] Map staging to `nonprod`.
    - [ ] Keep production in a separate account.
    - [ ] Align variables, domains, and credentials per environment.
  - [ ] Validate the foundation.
    - [ ] Confirm human access to the cluster.
    - [ ] Confirm CI/CD can publish images.
    - [ ] Confirm network connectivity is functional.
    - [ ] Confirm roles are isolated by account.
- [ ] Local Workflow
  - [ ] Standardize local Kubernetes on `k3d`.
  - [ ] Add local manifests or overlays that mirror the app split used in EKS.
- [ ] Application Packaging
  - [ ] Containerize Django and Next.js as separate workloads.
  - [ ] Confirm image build and push flow into ECR.
- [ ] Data and Secrets
  - [x] Document the RDS/PostgreSQL boundary.
  - [ ] Move PostgreSQL to RDS.
  - [ ] Inject secrets from Secrets Manager and config from SSM Parameter Store.
- [ ] Background Jobs and Media
  - [x] Document the async worker and media pipeline boundary.
  - [ ] Define the worker runtime and queueing strategy.
  - [ ] Define media storage and processing flow.
- [ ] Environment Layout
  - [x] Document QA, staging, and production account mapping.
  - [ ] Define runtime config per environment.
  - [ ] Define promotion flow from QA to staging to prod.
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
