# Staging Environment

This directory is reserved for staging environment files.

## Layout

- `app/` - Staging application runtime values.
- `db/` - Staging database bootstrap values.
- `orchestration/` - Staging stack variables.

## Notes

- Version `app/core.env` and `orchestration/compose.env` when they are non-secret.
- Keep `app/db.env` and `db/bootstrap.env` versioned with placeholders when values are not yet final.
- Use `secrets.local.env` files in `app/`, `db/`, and `orchestration/` for versioned placeholder secret values when needed.
- `orchestration/compose.env` must define `STACK_ENV=staging` for compose interpolation.
- `app/db.env` uses the shared `DB_CONNECTION_STRING` contract.
