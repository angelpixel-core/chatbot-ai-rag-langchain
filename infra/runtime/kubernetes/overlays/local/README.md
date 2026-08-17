# Local K3d Overlay

Full local Kubernetes stack for development and validation.

## What It Runs

- `services` deployment
- `web` deployment
- `db` StatefulSet

## Ports

- `services` - `10001:8000`
- `web` - `10002:3000`

## Contract

- Uses the shared `DB_CONNECTION_STRING` runtime contract.
- Database is provided by the in-cluster Postgres StatefulSet.
