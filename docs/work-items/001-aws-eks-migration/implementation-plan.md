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

- [ ] Organizations / IAM ([006-aws-organizations-iam](./subtasks/006-aws-organizations-iam.md))
  - [x] Define the AWS Organizations structure ([006-aws-organizations-iam](./subtasks/006-aws-organizations-iam.md)).
  - [x] Define human access ([005-identity-layer](./subtasks/005-identity-layer.md), [006-aws-organizations-iam](./subtasks/006-aws-organizations-iam.md)).
  - [x] Define the identity layer abstraction ([005-identity-layer](./subtasks/005-identity-layer.md)).
  - [x] Define CI/CD access ([006-aws-organizations-iam](./subtasks/006-aws-organizations-iam.md), [007-prepare-iam-cluster-access](./subtasks/007-prepare-iam-cluster-access.md)).
  - [x] Define baseline security controls ([006-aws-organizations-iam](./subtasks/006-aws-organizations-iam.md)).
  - [x] Define audit and encryption foundations ([006-aws-organizations-iam](./subtasks/006-aws-organizations-iam.md)).
  - [x] Define bootstrap inputs ([001-aws-bootstrap-inputs](./subtasks/001-aws-bootstrap-inputs.md)).
  - [ ] Create the AWS accounts in Organizations ([006-aws-organizations-iam](./subtasks/006-aws-organizations-iam.md)).
  - [ ] Validate the bootstrap model ([006-aws-organizations-iam](./subtasks/006-aws-organizations-iam.md)).

- [ ] Foundation
  - [x] Define the AWS account strategy ([002-account-strategy](./subtasks/002-account-strategy.md)).
    - [x] Use `shared/platform` for central tooling.
    - [x] Use `nonprod` for QA and staging.
    - [x] Use `prod` for production.
    - [x] Define human access per account ([005-identity-layer](./subtasks/005-identity-layer.md), [007-prepare-iam-cluster-access](./subtasks/007-prepare-iam-cluster-access.md)).
    - [x] Define CI/CD roles per account ([006-aws-organizations-iam](./subtasks/006-aws-organizations-iam.md), [007-prepare-iam-cluster-access](./subtasks/007-prepare-iam-cluster-access.md)).
    - [x] Define what belongs in each account ([002-account-strategy](./subtasks/002-account-strategy.md)).
    - [x] Define naming conventions for accounts and resources ([002-account-strategy](./subtasks/002-account-strategy.md)).
  - [x] Create the AWS provisioning skeleton.
    - [x] Create `infra/provisioning/aws/`.
    - [x] Create `infra/provisioning/aws/shared/platform/`.
    - [x] Create `infra/provisioning/aws/nonprod/`.
    - [x] Create `infra/provisioning/aws/prod/`.
    - [x] Decide which legacy Terraform pieces to reuse as migration inputs.
    - [x] Decide which legacy Terraform pieces to retire.
  - [x] Document the AWS bootstrap inputs and placeholder convention ([001-aws-bootstrap-inputs](./subtasks/001-aws-bootstrap-inputs.md)).
  - [x] Establish the base network per account ([003-network-layout](./subtasks/003-network-layout.md), [004-vpc-layout](./subtasks/004-vpc-layout.md)).
    - [x] Define the VPC layout ([004-vpc-layout](./subtasks/004-vpc-layout.md)).
    - [x] Implement the VPC module in Terraform ([004-vpc-layout](./subtasks/004-vpc-layout.md)).
    - [x] Instantiate the module in each account root ([004-vpc-layout](./subtasks/004-vpc-layout.md)).
    - [x] Create one VPC per account ([004-vpc-layout](./subtasks/004-vpc-layout.md)).
    - [x] Define public and private subnets ([004-vpc-layout](./subtasks/004-vpc-layout.md)).
    - [x] Define NAT and egress paths ([004-vpc-layout](./subtasks/004-vpc-layout.md)).
    - [x] Reserve non-overlapping CIDR ranges ([003-network-layout](./subtasks/003-network-layout.md), [004-vpc-layout](./subtasks/004-vpc-layout.md)).
    - [x] Define DNS and naming conventions ([003-network-layout](./subtasks/003-network-layout.md), [004-vpc-layout](./subtasks/004-vpc-layout.md)).
  - [x] Prepare IAM and cluster access ([007-prepare-iam-cluster-access](./subtasks/007-prepare-iam-cluster-access.md)).
    - [x] Define roles for admins, developers, and CI/CD ([005-identity-layer](./subtasks/005-identity-layer.md), [007-prepare-iam-cluster-access](./subtasks/007-prepare-iam-cluster-access.md)).
    - [x] Define initial EKS access ([007-prepare-iam-cluster-access](./subtasks/007-prepare-iam-cluster-access.md)).
    - [x] Prepare IRSA/OIDC for workloads ([007-prepare-iam-cluster-access](./subtasks/007-prepare-iam-cluster-access.md)).
    - [x] Define minimum permissions by namespace or service ([007-prepare-iam-cluster-access](./subtasks/007-prepare-iam-cluster-access.md)).
  - [x] Provision the EKS base ([008-provision-eks-base](./subtasks/008-provision-eks-base.md)).
    - [x] Create the initial cluster in `nonprod` ([008-provision-eks-base](./subtasks/008-provision-eks-base.md)).
    - [x] Define the initial node groups ([008-provision-eks-base](./subtasks/008-provision-eks-base.md)).
    - [x] Enable base logging and monitoring ([008-provision-eks-base](./subtasks/008-provision-eks-base.md)).
    - [ ] Validate access from the local environment ([008-provision-eks-base](./subtasks/008-provision-eks-base.md)).
  - [ ] Provision ECR.
    - [x] Create repos for `django`.
    - [x] Create repos for `nextjs`.
    - [x] Define lifecycle and permission policies.
    - [ ] Validate push and pull from CI/CD.
  - [x] Define the environment layout.
    - [x] Keep dev local/compose.
    - [x] Keep test in CI.
    - [x] Map QA to `nonprod`.
    - [x] Map staging to `nonprod`.
    - [x] Keep production in a separate account.
    - [x] Align variables, domains, and credentials per environment.
  - [ ] Validate the foundation.
    - [ ] Confirm human access to the cluster.
    - [ ] Confirm CI/CD can publish images.
    - [ ] Confirm network connectivity is functional.
    - [ ] Confirm roles are isolated by account.
- [x] Local Workflow
  - [x] Standardize local Kubernetes on `k3d`.
  - [x] Add local manifests or overlays that mirror the app split used in EKS.
- [ ] Application Packaging
  - [x] Containerize Django and Next.js as separate workloads.
    - [x] Add `base`, `test`, and `runtime` stages for each app image.
  - [ ] Confirm image build and push flow into ECR.
- [ ] Data and Secrets
  - [x] Document the RDS/PostgreSQL boundary ([011-rds-postgresql](./subtasks/011-rds-postgresql.md)).
  - [ ] Move PostgreSQL to RDS.
  - [ ] Inject secrets from Secrets Manager and config from SSM Parameter Store.
- [ ] Background Jobs and Media
  - [x] Document the async worker and media pipeline boundary ([012-background-jobs](./subtasks/012-background-jobs.md)).
  - [x] Define the worker runtime and queueing strategy.
  - [x] Define media storage and processing flow.
  - [x] Define the async job boundary.
- [ ] Environment Layout
  - [x] Document QA, staging, and production account mapping ([009-environment-layout](./subtasks/009-environment-layout.md)).
  - [x] Define runtime config per environment.
  - [x] Define promotion flow from QA to staging to prod.
- [ ] Delivery
  - [x] Add GitOps deployment via ArgoCD.
  - [x] Add an Ingress Controller for HTTP/HTTPS traffic ([010-deployment-service-ingress](./subtasks/010-deployment-service-ingress.md)).
- [ ] Rollout
  - [ ] Validate in QA, then staging, then production.

## Deliverables

- [ ] AWS infrastructure root for EKS, RDS, ECR, IAM, and networking.
- [x] Local `k3d` workflow.
- [x] GitOps manifests for platform and app workloads.
- [x] Deployment and ingress path for the apps.

## Exit Criteria

- [ ] Local development works against `k3d`.
- [ ] Django and Next.js deploy separately on Kubernetes.
- [ ] Secrets are sourced from AWS-managed services.
- [ ] App deploys are reconciled from Git.
