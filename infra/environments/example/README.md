# Example Environment

This directory is reserved for example environment files.

## Layout

- `app/` - Example application runtime values.
- `db/` - Example database bootstrap values.
- `orchestration/` - Example stack variables.

## Notes

- Keep values versioned as placeholders only.
- `orchestration/compose.env` must define `STACK_ENV=example` for compose interpolation.
