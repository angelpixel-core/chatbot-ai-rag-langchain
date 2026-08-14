# Development Database Variables

Este directorio contiene variables de entorno usadas por PostgreSQL y por la aplicación en desarrollo.

## Files

- `bootstrap.env` - Valores consumidos por el contenedor de base de datos en bootstrap.
- `secrets.local.env` - Overrides versionados de ejemplo para valores sensibles.
- `app/db.env` - Variables de conexión usadas por la aplicación, incluyendo `DB_CONNECTION_STRING`.
