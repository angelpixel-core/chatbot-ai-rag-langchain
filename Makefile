COMPOSE ?= docker compose
COMPOSE_FILE ?= infra/runtime/compose.yaml
STACK_ENV ?= dev
CLUSTER_SCRIPT ?= infra/runtime/scripts/cluster.sh
ARGOCD_BOOTSTRAP_SCRIPT ?= infra/runtime/scripts/bootstrap-argocd.sh

COMPOSE_CMD = $(COMPOSE) --env-file infra/environments/$(STACK_ENV)/orchestration/compose.env -f $(COMPOSE_FILE)

.PHONY: stack/up stack/down stack/logs stack/status db/shell db/logs server/shell server/logs web/shell web/logs cluster/up cluster/down cluster/logs cluster/status cluster/apply cluster/delete delivery/bootstrap

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

cluster/up:
	sh $(CLUSTER_SCRIPT) up

cluster/down:
	sh $(CLUSTER_SCRIPT) down

cluster/logs:
	sh $(CLUSTER_SCRIPT) logs

cluster/status:
	sh $(CLUSTER_SCRIPT) status

cluster/apply:
	sh $(CLUSTER_SCRIPT) apply

cluster/delete:
	sh $(CLUSTER_SCRIPT) delete

delivery/bootstrap:
	sh $(ARGOCD_BOOTSTRAP_SCRIPT)
