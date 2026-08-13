# Coffee Chatbot

Monorepo inicial para un chatbot de cafetería con backend Django y cliente web Next.

## Estructura

- `apps/server/` - backend Django y futura API
- `apps/web/` - cliente web Next.js
- `datasets/coffee-shop.txt` - fuente inicial de conocimiento
- `infra/local/compose.yaml` - orquestación local con Compose
- `infra/local/containers/` - contenedores y entrypoints locales
- `infra/environments/` - variables por ambiente
- `infra/provisioning/terraform/render/` - infraestructura declarativa del proveedor
- `infra/tooling/` - scripts y lint

## Objetivo

Evolucionar desde texto plano a una arquitectura con dominio separado, adaptadores intercambiables y administración web del catálogo.
