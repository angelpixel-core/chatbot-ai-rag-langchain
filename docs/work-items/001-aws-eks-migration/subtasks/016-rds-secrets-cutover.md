---
id: 016-rds-secrets-cutover
aliases: []
tags: []
created_at: 2026-08-17T00:00:00Z
status: draft
updated_at: 2026-08-17T00:00:00Z
---

# Subtask: RDS and Secret Cutover

## Goal

Move the database and runtime secret delivery onto AWS-managed services.

## Recommendation

- Keep PostgreSQL private in RDS and reuse the existing database contract.
- Move connection and runtime config into AWS-managed secrets and parameters.
- Validate the cluster-side connectivity after the cutover.

## Execution Checklist

- [ ] Move PostgreSQL to RDS ([011-rds-postgresql](./011-rds-postgresql.md)).
- [ ] Inject secrets from Secrets Manager and config from SSM Parameter Store.
- [ ] Validate connectivity from the cluster ([011-rds-postgresql](./011-rds-postgresql.md)).

## Notes

- This should be executed after credentialed access and ECR validation are stable.
