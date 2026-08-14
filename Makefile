COMPOSE ?= docker compose
COMPOSE_FILE ?= infra/local/compose.yaml
STACK_ENV ?= dev

COMPOSE_CMD = $(COMPOSE) --env-file infra/environments/$(STACK_ENV)/orchestration/compose.env -f $(COMPOSE_FILE)

.PHONY: stack/up stack/down stack/logs stack/status db/shell db/logs server/shell server/logs web/shell web/logs

stack/up:
	$(COMPOSE_CMD) up -d

stack/down:
	$(COMPOSE_CMD) down

stack/logs:
	$(COMPOSE_CMD) logs -f

stack/status:
	$(COMPOSE_CMD) ps

db/shell:
	$(COMPOSE_CMD) exec db psql -U "$${POSTGRES_USER:-app}" -d "$${POSTGRES_DB:-coffee_chatbot_development}"

db/logs:
	$(COMPOSE_CMD) logs -f db

server/shell:
	$(COMPOSE_CMD) exec server sh

server/logs:
	$(COMPOSE_CMD) logs -f server

web/shell:
	$(COMPOSE_CMD) exec web sh

web/logs:
	$(COMPOSE_CMD) logs -f web
