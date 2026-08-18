# Coffee Chatbot

Monorepo inicial para un chatbot de cafetería con backend Django y cliente web Next.

## Estructura

- `apps/services/chatbot/` - backend Django y futura API
- `apps/web/chatbot/` - cliente web Next.js
- `datasets/coffee-shop/` - fuente inicial de conocimiento
- `infra/local/compose/compose.yaml` - orquestación local con Compose
- `infra/local/kubernetes/` - manifests locales para k3d
- `infra/local/scripts/` - helpers de orquestación local
- `infra/runtime/bootstrap/db/` - bootstrap de PostgreSQL para Compose y k3d
- `infra/runtime/bootstrap/` - bootstrap de plataforma y valores compartidos
- `infra/environments/` - variables por ambiente
- `infra/provisioning/aws/` - infraestructura declarativa de AWS/EKS
- `infra/tooling/` - scripts y lint

## Objetivo

Evolucionar desde texto plano a una arquitectura con dominio separado, adaptadores intercambiables y administración web del catálogo.

## Database config

- Local/dev/test usan `DB_CONNECTION_STRING`.
- QA/staging/prod usan el mismo `DB_CONNECTION_STRING`, inyectado desde Kubernetes y respaldado por RDS.
