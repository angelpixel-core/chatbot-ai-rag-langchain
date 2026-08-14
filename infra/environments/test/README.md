# Test Environment

This directory is reserved for test environment files.

## Layout

- `app/` - Test application runtime values.
- `db/` - Test database bootstrap values.
- `orchestration/` - Test stack variables.

## Notes

- Version `app/core.env` and `orchestration/compose.env` when they are non-secret.
- Keep `app/db.env` and `db/bootstrap.env` versioned with placeholders when values are not yet final.
- Use `secrets.local.env` files in `app/`, `db/`, and `orchestration/` for versioned placeholder secret values when needed.
- `orchestration/compose.env` must define `STACK_ENV=test` for compose interpolation.
