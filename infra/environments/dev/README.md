# Development Environment

This directory contains development-only environment files, split by consumer.

## Layout

- `app/` - Application runtime variables.
- `db/` - Database bootstrap variables.
- `orchestration/` - Compose/build variables.

## Notes

- Keep development values aligned with the local bootstrap work item.
- Do not place unrelated service variables here.
- `orchestration/compose.env` must define `STACK_ENV=dev` for compose interpolation.
- `secrets.local.env` files hold versioned placeholders for secret values when needed.
