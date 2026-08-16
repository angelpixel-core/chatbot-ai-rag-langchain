# QA Environment

This directory is reserved for QA environment files.

## Layout

- `app/` - QA application runtime values.
- `db/` - QA database bootstrap values.
- `orchestration/` - QA stack variables.

## Notes

- Version `app/core.env` and `orchestration/compose.env` when they are non-secret.
- Keep `app/db.env` and `db/bootstrap.env` versioned with placeholders when values are not yet final.
- Use `secrets.local.env` files in `app/`, `db/`, and `orchestration/` for versioned placeholder secret values when needed.
- `orchestration/compose.env` must define `STACK_ENV=qa` for compose interpolation.
- `app/db.env` uses the shared `DB_CONNECTION_STRING` contract.
