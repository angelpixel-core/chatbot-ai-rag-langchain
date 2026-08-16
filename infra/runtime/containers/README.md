# Runtime Containers

Este directorio contiene los contenedores de ejecución y sus entrypoints.

## Layout

- `server/` - contenedor de la API Django.
- `web/` - contenedor del cliente Next.js.
- `db/` - assets de inicialización de PostgreSQL.

## Stages

- `base` - local/dev, con herramientas de DX.
- `test` - verificación de build/check sin herramientas extra.
- `runtime` - imagen mínima para Kubernetes/EKS.
