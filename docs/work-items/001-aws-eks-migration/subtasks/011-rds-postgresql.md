---
id: 011-rds-postgresql
aliases: []
tags: []
created_at: 2026-08-14T00:00:00Z
status: draft
updated_at: 2026-08-14T00:00:00Z
---

# Subtask: RDS PostgreSQL

## Goal

Define the AWS-managed PostgreSQL boundary for the migration and retire the old legacy database component.

## Source Material Extracted From Legacy Provider

- `name` becomes the database resource naming convention.
- `database_name` becomes the application database/schema name.
- `database_user` becomes the application database user.
- `postgres_version` becomes the target engine version in RDS.
- `plan` becomes the RDS instance class / size choice.
- `ip_allow_list` becomes the network/security-group access model.
- `connection_info` becomes the secret and connection-string contract for the app.

## Recommendation

- Use Amazon RDS PostgreSQL as the managed database layer.
- Keep the database outside the Kubernetes cluster.
- Keep one database per environment boundary that matters operationally.
- Treat QA and staging as separate datasets if their release workflows or test data need isolation.
- Inject the connection string through AWS-managed secrets, not hardcoded env files.

## Execution Checklist

- [ ] Define the RDS PostgreSQL contract.
  - [ ] Choose the target PostgreSQL major version.
  - [ ] Choose the instance class / size for each environment.
  - [ ] Define the database name and user convention.
  - [ ] Define the backup, retention, and maintenance posture.
- [ ] Define network access to RDS.
  - [ ] Define security groups / allow lists from EKS to RDS.
  - [ ] Keep access private inside the AWS network.
  - [ ] Validate connectivity from the cluster.
- [ ] Define the app connection contract.
  - [ ] Define the secret name for the connection string.
  - [ ] Map app env vars to AWS-managed secrets.
  - [ ] Keep the DB URL out of plaintext manifests.
- [ ] Remove legacy provider-specific database artifacts from the active migration path.
  - [ ] Retire the legacy Postgres resource as an active resource.
  - [ ] Retire import blocks and database state adoption.
  - [ ] Remove the legacy database component tree.

## Notes

- This document is the AWS/EKS replacement for the old legacy database component.
- The same pattern should be mirrored by environment-specific AWS provisioning modules.
