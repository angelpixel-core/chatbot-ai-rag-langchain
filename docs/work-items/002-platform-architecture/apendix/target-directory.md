---
id: target-directory
aliases: []
tags: []
---

STAGE 1 - TARGET PLATFORM DIRECTORY TREE

Purpose: Complete reference tree for the Stage 1 monorepo architecture
agreed during the repository redesign discussion.

Important:
- This is a target/reference taxonomy, not a requirement to create every optional directory before a real artifact exists.
- Stage 1 remains a single Git repository.
- Applications are classified by execution/interaction target.
- Services are neutral deployable/executable server-side units; the tree does not force a microservice architecture.
- Application Dockerfiles remain with the application they package.
- Actual secrets remain outside Git; only examples and references appear here.
- Infrastructure separates provisioning, platform capabilities, delivery, and local orchestration.
- Compose is the normal fast local path; local Kubernetes exists for infrastructure/runtime-fidelity validation.
- Delivery owns canonical workload definitions. Local Kubernetes should reuse/patch canonical definitions where practical rather than become a divergent second source of truth.
- Build once, configure at runtime, and promote the same immutable artifact.
- Stage 2 repository extraction/submodules and Stage 3 released-artifact composition are intentionally NOT represented here.
- Example categories (desktop, CLI, embedded, multiple services, etc.) are shown because they were explicitly requested as a complete reference.

DIRECTORY TREE
```
platform/
|-- apps/
|   |-- services/
|   |   |-- core/
|   |   |   |-- app/
|   |   |   |   |-- domains/
|   |   |   |   |   |-- identity/
|   |   |   |   |   |-- catalog/
|   |   |   |   |   |-- ordering/
|   |   |   |   |   |-- payments/
|   |   |   |   |   |-- billing/
|   |   |   |   |-- application/
|   |   |   |   |-- integrations/
|   |   |   |   |-- interfaces/
|   |   |   |   |-- config/
|   |   |   |   |-- db/
|   |   |   |   |-- lib/
|   |   |   |   |-- spec/
|   |   |   |   |-- bin/
|   |   |   |   |-- public/
|   |   |   |   |-- Dockerfile
|   |   |   |   |-- Gemfile
|   |   |   |   |-- Gemfile.lock
|   |   |   |   |-- Rakefile
|   |   |   |   |-- config.ru
|   |   |   |   |-- .dockerignore
|   |   |   |   |-- .env.example
|   |   |   |   |-- README.md
|   |   |-- chatbot/
|   |   |   |-- src/
|   |   |   |   |-- domain/
|   |   |   |   |-- application/
|   |   |   |   |-- retrieval/
|   |   |   |   |-- generation/
|   |   |   |   |-- evaluation/
|   |   |   |   |-- integrations/
|   |   |   |   |-- interfaces/
|   |   |   |-- tests/
|   |   |   |-- migrations/
|   |   |   |-- Dockerfile
|   |   |   |-- pyproject.toml
|   |   |   |-- requirements.txt
|   |   |   |-- .dockerignore
|   |   |   |-- .env.example
|   |   |   |-- README.md
|   |   |-- payments/
|   |   |   |-- app/
|   |   |   |   |-- domain/
|   |   |   |   |-- application/
|   |   |   |   |-- providers/
|   |   |   |   |-- persistence/
|   |   |   |   |-- events/
|   |   |   |   |-- interfaces/
|   |   |   |   |-- config/
|   |   |   |   |-- spec/
|   |   |   |-- Dockerfile
|   |   |   |-- Gemfile
|   |   |   |-- Gemfile.lock
|   |   |   |-- .dockerignore
|   |   |   |-- .env.example
|   |   |   |-- README.md
|   |   |-- search-indexer/
|   |   |   |-- src/
|   |   |   |   |-- consumers/
|   |   |   |   |-- indexing/
|   |   |   |   |-- persistence/
|   |   |   |   |-- observability/
|   |   |   |-- tests/
|   |   |   |-- Dockerfile
|   |   |   |-- pyproject.toml
|   |   |   |-- .dockerignore
|   |   |   |-- .env.example
|   |   |   |-- README.md
|   |   |-- notification-worker/
|   |       |-- src/
|   |       |   |-- consumers/
|   |       |   |-- jobs/
|   |       |   |-- channels/
|   |       |-- observability/
|   |       |-- tests/
|   |       |-- Dockerfile
|   |       |-- pyproject.toml
|   |       |-- .dockerignore
|   |       |-- .env.example
|   |       |-- README.md
|   |-- web/
|   |   |-- customer-portal/
|   |   |   |-- src/
|   |   |   |   |-- app/
|   |   |   |   |-- components/
|   |   |   |   |-- features/
|   |   |   |   |-- lib/
|   |   |   |   |-- styles/
|   |   |   |-- public/
|   |   |   |-- tests/
|   |   |   |-- Dockerfile
|   |   |   |-- package.json
|   |   |   |-- package-lock.json
|   |   |   |-- next.config.js
|   |   |   |-- tsconfig.json
|   |   |   |-- .dockerignore
|   |   |   |-- .env.example
|   |   |   |-- README.md
|   |   |-- admin-console/
|   |   |   |-- src/
|   |   |   |-- public/
|   |   |   |-- tests/
|   |   |   |-- Dockerfile
|   |   |   |-- package.json
|   |   |   |-- tsconfig.json
|   |   |   |-- .dockerignore
|   |   |   |-- .env.example
|   |   |   |-- README.md
|   |   |-- chatbot/
|   |       |-- src/
|   |       |   |-- app/
|   |       |   |-- components/
|   |       |   |-- chat/
|   |       |-- public/
|   |       |-- tests/
|   |       |-- Dockerfile
|   |       |-- package.json
|   |       |-- tsconfig.json
|   |       |-- .dockerignore
|   |       |-- .env.example
|   |       |-- README.md
|   |-- mobile/
|   |   |-- ios/
|   |   |   |-- customer-app/
|   |   |       |-- Sources/
|   |   |       |-- Tests/
|   |   |       |-- Resources/
|   |   |       |-- Package.swift
|   |   |       |-- README.md
|   |   |-- android/
|   |       |-- point-of-sale/
|   |           |-- app/
|   |           |   |-- src/
|   |           |   |   |-- main/
|   |           |   |   |-- test/
|   |           |-- gradle/
|   |           |-- build.gradle.kts
|   |           |-- settings.gradle.kts
|   |           |-- README.md
|   |-- desktop/
|   |   |-- operations-console/
|   |       |-- src/
|   |       |-- tests/
|   |       |-- package.json
|   |       |-- tsconfig.json
|   |       |-- README.md
|   |-- cli/
|   |   |-- platform-cli/
|   |       |-- src/
|   |       |   |-- commands/
|   |       |   |-- config/
|   |       |-- tests/
|   |       |-- package.json
|   |       |-- tsconfig.json
|   |       |-- README.md
|   |-- embedded/
|       |-- point-of-sale/
|           |-- terminal-controller/
|               |-- src/
|               |-- include/
|               |-- tests/
|               |-- Cargo.toml
|               |-- README.md
|-- packages/
|   |-- contracts/
|   |   |-- openapi/
|   |   |   |-- core.yaml
|   |   |   |-- chatbot.yaml
|   |   |   |-- payments.yaml
|   |   |-- protobuf/
|   |   |   |-- platform.proto
|   |   |-- events/
|   |   |   |-- ordering/
|   |   |   |-- payments/
|   |   |   |-- notifications/
|   |   |-- schemas/
|   |   |-- README.md
|   |-- clients/
|   |   |-- ruby/
|   |   |-- python/
|   |   |-- typescript/
|   |   |-- README.md
|   |-- design-system/
|   |   |-- src/
|   |   |   |-- components/
|   |   |   |-- tokens/
|   |   |-- styles/
|   |   |-- tests/
|   |   |-- package.json
|   |   |-- README.md
|   |-- shared/
|       |-- .keep
|-- datasets/
|   |-- coffee-shop/
|       |-- source/
|       |-- processed/
|       |-- fixtures/
|       |-- metadata.yaml
|       |-- README.md
|-- config/
|   |-- defaults/
|   |   |-- platform.env
|   |   |-- README.md
|   |-- schemas/
|   |   |-- environment.schema.json
|   |   |-- application.schema.json
|   |   |-- chatbot.env.example
|   |-- examples/
|       |-- core.env.example
|       |-- payments.env.example
|       |-- README.md
|-- infra/
|   |-- provisioning/
|   |   |-- aws/
|   |   |   |-- modules/
|   |   |   |   |-- network/
|   |   |   |   |   |-- vpc/
|   |   |   |   |       |-- main.tf
|   |   |   |   |       |-- subnets.tf
|   |   |   |   |       |-- routing.tf
|   |   |   |   |       |-- nat.tf
|   |   |   |   |       |-- dns.tf
|   |   |   |   |       |-- variables.tf
|   |   |   |   |       |-- outputs.tf
|   |   |   |   |       |-- versions.tf
|   |   |   |   |-- compute/
|   |   |   |   |   |-- eks/
|   |   |   |   |       |-- main.tf
|   |   |   |   |       |-- cluster.tf
|   |   |   |   |       |-- node-groups.tf
|   |   |   |   |       |-- iam.tf
|   |   |   |   |       |-- variables.tf
|   |   |   |   |       |-- outputs.tf
|   |   |   |   |       |-- versions.tf
|   |   |   |   |-- registry/
|   |   |   |   |   |-- ecr/
|   |   |   |   |       |-- main.tf
|   |   |   |   |       |-- variables.tf
|   |   |   |   |       |-- outputs.tf
|   |   |   |   |       |-- versions.tf
|   |   |   |   |-- data/
|   |   |   |   |   |-- rds/
|   |   |   |   |       |-- main.tf
|   |   |   |   |       |-- variables.tf
|   |   |   |   |       |-- outputs.tf
|   |   |   |   |       |-- versions.tf
|   |   |   |   |-- security/
|   |   |   |   |   |-- kms/
|   |   |   |   |       |-- main.tf
|   |   |   |   |       |-- variables.tf
|   |   |   |   |       |-- outputs.tf
|   |   |   |   |       |-- versions.tf
|   |   |   |   |-- shared/
|   |   |   |       |-- platform/
|   |   |   |       |   |-- main.tf
|   |   |   |       |   |-- variables.tf
|   |   |   |       |   |-- outputs.tf
|   |   |   |       |   |-- README.md
|   |   |   |       |-- org/
|   |   |   |       |   |-- main.tf
|   |   |   |       |   |-- variables.tf
|   |   |   |       |   |-- outputs.tf
|   |   |   |       |   |-- README.md
|   |   |   |       |-- iam/
|   |   |   |       |   |-- main.tf
|   |   |   |       |   |-- variables.tf
|   |   |   |       |   |-- outputs.tf
|   |   |   |       |   |-- README.md
|   |   |   |       |-- audit/
|   |   |   |       |   |-- main.tf
|   |   |   |       |   |-- variables.tf
|   |   |   |       |   |-- outputs.tf
|   |   |   |       |   |-- README.md
|   |   |   |       |-- policies/
|   |   |   |           |-- iam/
|   |   |   |           |   |-- scp/
|   |   |   |           |-- trust/
|   |   |   |               |-- README.md
|   |   |   |-- nonprod/
|   |   |   |   |-- main.tf
|   |   |   |   |-- network.tf
|   |   |   |   |-- compute.tf
|   |   |   |   |-- registry.tf
|   |   |   |   |-- data.tf
|   |   |   |   |-- providers.tf
|   |   |   |   |-- variables.tf
|   |   |   |   |-- outputs.tf
|   |   |   |   |-- terraform.tfvars.example
|   |   |   |   |-- README.md
|   |   |   |-- prod/
|   |   |       |-- main.tf
|   |   |       |-- network.tf
|   |   |       |-- compute.tf
|   |   |       |-- registry.tf
|   |   |       |-- data.tf
|   |   |       |-- providers.tf
|   |   |       |-- variables.tf
|   |   |       |-- outputs.tf
|   |   |       |-- terraform.tfvars.example
|   |   |       |-- README.md
|   |-- platform/
|       |-- networking/
|       |   |-- ingress/
|       |   |   |-- base/
|       |   |   |   |-- kustomization.yaml
|       |   |   |   |-- overlays/
|       |   |   |       |-- nonprod/
|       |   |   |       |-- prod/
|       |   |   |-- dns/
|       |   |   |   |-- base/
|       |   |   |   |-- overlays/
|       |   |   |       |-- nonprod/
|       |   |   |       |-- prod/
|       |   |   |-- security/
|       |   |   |   |-- certificates/
|       |   |   |   |   |-- base/
|       |   |   |   |   |-- overlays/
|       |   |   |   |-- secrets/
|       |   |   |       |-- external-secrets/
|       |   |   |           |-- README.md
|       |   |   |-- policies/
|       |   |-- observability/
|       |   |   |-- telemetry/
|       |   |   |   |-- base/
|       |   |   |   |   |-- namespace.yaml
|       |   |   |   |   |-- kustomization.yaml
|       |   |   |   |-- overlays/
|       |   |   |   |   |-- nonprod/
|       |   |   |   |   |-- prod/
|       |   |   |   |-- metrics/
|       |   |   |   |-- logs/
|       |   |   |   |-- traces/
|       |   |   |-- controllers/
|       |   |       |-- argocd/
|       |   |       |   |-- application.yaml
|       |   |       |   |-- README.md
|       |   |       |-- cert-manager/
|       |   |       |   |-- application.yaml
|       |   |       |   |-- README.md
|       |   |       |-- external-dns/
|       |   |       |   |-- application.yaml
|       |   |       |   |-- README.md
|       |   |       |-- ingress-nginx/
|       |   |           |-- application.yaml
|       |   |           |-- README.md
|       |   |-- delivery/
|       |       |-- applications/
|       |       |   |-- root.yaml
|       |       |   |-- platform.yaml
|       |       |   |-- workloads.yaml
|       |       |   |-- kustomization.yaml
|       |       |-- workloads/
|       |       |   |-- base/
|       |       |   |   |-- namespace.yaml
|       |       |   |   |-- deployment.yaml
|       |       |   |   |-- service.yaml
|       |       |   |   |-- kustomization.yaml
|       |       |   |-- services/
|       |       |   |   |-- core/
|       |       |   |   |   |-- chatbot/
|       |       |   |   |   |   |-- deployment.yaml
|       |       |   |   |   |   |-- service.yaml
|       |       |   |   |   |   |-- kustomization.yaml
|       |       |   |   |   |-- payments/
|       |       |   |   |   |   |-- deployment.yaml
|       |       |   |   |   |   |-- service.yaml
|       |       |   |   |   |   |-- kustomization.yaml
|       |       |   |   |   |-- web/
|       |       |   |   |       |-- customer-portal/
|       |       |   |   |       |   |-- deployment.yaml
|       |       |   |   |       |   |-- service.yaml
|       |       |   |   |       |   |-- ingress.yaml
|       |       |   |   |       |   |-- kustomization.yaml
|       |       |   |   |       |   |-- admin-console/
|       |       |   |   |       |       |-- deployment.yaml
|       |       |   |   |       |       |-- service.yaml
|       |       |   |   |       |       |-- kustomization.yaml
|       |       |   |   |       |-- kustomization.yaml
|       |       |   |-- overlays/
|       |       |   |   |-- development/
|       |       |   |   |   |-- patches/
|       |       |   |   |       |-- kustomization.yaml
|       |       |   |   |-- qa/
|       |       |   |   |   |-- patches/
|       |       |   |   |       |-- kustomization.yaml
|       |       |   |   |-- staging/
|       |       |   |   |   |-- patches/
|       |       |   |   |       |-- kustomization.yaml
|       |       |   |   |-- production/
|       |       |   |       |-- patches/
|       |       |   |           |-- kustomization.yaml
|       |       |   |-- strategies/
|       |       |       |-- rolling/
|       |       |       |-- canary/
|       |       |       |-- blue-green/
|       |       |-- README.md
|       |-- local/
|       |   |-- compose/
|       |   |   |-- compose.yaml
|       |   |   |-- .env.example
|       |   |   |-- README.md
|       |   |-- kubernetes/
|       |       |-- base/
|       |       |   |-- namespace.yaml
|       |       |   |-- deployment.yaml
|       |       |   |-- service.yaml
|       |       |   |-- kustomization.yaml
|       |       |   |-- dependencies/
|       |       |       |-- db/
|       |       |           |-- kustomization.yaml
|       |       |           |-- overlays/
|       |       |               |-- local/
|       |       |                   |-- patches/
|       |       |-- README.md
|-- environments/
|   |-- development/
|   |   |-- applications.yaml
|   |   |-- config.refs.yaml
|   |   |-- secrets.refs.yaml
|   |   |-- README.md
|   |-- qa/
|   |   |-- applications.yaml
|   |   |-- config.refs.yaml
|   |   |-- secrets.refs.yaml
|   |   |-- README.md
|   |-- staging/
|   |   |-- applications.yaml
|   |   |-- config.refs.yaml
|   |   |-- secrets.refs.yaml
|   |   |-- README.md
|   |-- production/
|       |-- applications.yaml
|       |-- config.refs.yaml
|       |-- secrets.refs.yaml
|       |-- README.md
|-- tooling/
|   |-- scripts/
|   |   |-- bootstrap.sh
|   |   |-- build.sh
|   |   |-- test.sh
|   |   |-- lint.sh
|   |   |-- local-up.sh
|   |   |-- local-down.sh
|   |   |-- k8s-up.sh
|   |   |-- k8s-down.sh
|   |   |-- db.sh
|   |   |-- secrets.sh
|   |   |-- stack.sh
|   |-- generators/
|   |   |-- service/
|   |   |-- web/
|   |-- hooks/
|   |   |-- setup-hooks.sh
|   |-- README.md
|-- docs/
|   |-- architecture/
|   |   |-- repository-structure.md
|   |   |-- application-boundaries.md
|   |   |-- platform-boundaries.md
|   |   |-- environment-model.md
|   |   |-- deployment-lifecycle.md
|   |   |-- secrets-model.md
|   |   |-- integration-ownership.md
|   |-- adr/
|   |   |-- 0001-monorepo.md
|   |   |-- 0002-application-taxonomy.md
|   |   |-- 0003-build-once-promote-artifact.md
|   |   |-- 0004-infrastructure-boundaries.md
|   |   |-- 0005-environment-model.md
|   |   |-- 0006-secret-management.md
|   |   |-- 0007-local-compose-and-kubernetes.md
|   |   |-- README.md
|   |-- operations/
|   |   |-- local-development.md
|   |   |-- qa.md
|   |   |-- staging.md
|   |   |-- production.md
|   |   |-- secret-provisioning.md
|   |   |-- incident-access.md
|   |-- diagrams/
|   |   |-- README.md
|   |-- README.md
|-- .github/
|   |-- workflows/
|       |-- ci.yml
|       |-- build.yml
|       |-- security.yml
|       |-- release.yml
|-- .private/
|   |-- .gitkeep
|   |-- .gitignore
|-- .dockerignore
|-- .editorconfig
|-- .env.example
|-- .tool-versions
|-- Makefile
|-- README.md
|-- LICENSE
````
END OF STAGE 1 TREE

Stage boundaries: Stage 1 = monorepo with applications + packages + infrastructure + environments + tooling + datasets + documentation.
Stage 2 = selected products/components may acquire independent repositories and, only where source composition is intentional, may be referenced by submodules.
Stage 3 = platform composition should preferentially pin immutable released artifacts (container versions, charts, packages, etc.) rather than compose application source repositories.
