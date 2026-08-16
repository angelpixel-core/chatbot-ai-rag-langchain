# Runtime Infra

Este directorio contiene la infraestructura de ejecución del proyecto.

## Archivos

- `compose.yaml` - definición principal del stack de ejecución local.
- `containers/` - contenedores y entrypoints de ejecución.

## Puertos externos

- `server` - `10001:8000`
- `web` - `10002:3000`
- `db` - `10003:5432`
