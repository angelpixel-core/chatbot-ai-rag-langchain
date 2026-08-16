# Environment Files

This directory stores environment-specific configuration for local development, CI testing, production, examples, and future environments.

## Layout

- `dev/` - Local compose values.
- `test/` - CI verification values.
- `qa/` - QA values mapped to AWS `nonprod`.
- `staging/` - Staging values mapped to AWS `nonprod`.
- `prod/` - Production values mapped to AWS `prod`.
- `example/` - Non-secret reference values and templates.

Each environment is split by consumer:

- `app/` - Application runtime variables.
- `db/` - Database bootstrap variables.
- `orchestration/` - Compose/build variables for the local runtime or environment-specific stack.
- `secrets.local.env` - Versioned placeholder secrets file in each consumer directory when needed.

## Notes

- Keep consumer-specific variables in the matching subdirectory.
- Avoid mixing app runtime values with database bootstrap values unless a target explicitly needs both.
- Use `secrets.local.env` files for versioned placeholders when a value is not ready yet.
- In `prod/`, `qa/`, and `staging/`, version the environment files with placeholders and fill the live values manually in the local secret store.
- When an environment file is checked into git, keep secrets and live connection strings as placeholders only.
- Use the shared `DB_CONNECTION_STRING` contract in `app/db.env` across dev, test, qa, staging, and prod.
