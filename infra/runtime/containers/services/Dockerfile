# syntax=docker/dockerfile:1.5

ARG PYTHON_VERSION=3.15.0rc1
ARG UID=1000
ARG GID=1000
ARG SERVICES_PORT=8000

FROM python:${PYTHON_VERSION}-alpine3.24 AS wheels

WORKDIR /build

RUN apk add --no-cache build-base linux-headers postgresql-dev

COPY requeriments.txt ./

RUN python -m pip install --upgrade pip setuptools wheel && \
  pip wheel --wheel-dir /wheels -r requeriments.txt

FROM python:${PYTHON_VERSION}-alpine3.24 AS deps

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
    SERVICES_PORT=${SERVICES_PORT}

RUN apk add --no-cache \
  ca-certificates \
  mariadb-connector-c \
  postgresql-client \
  postgresql-libs \
  sqlite \
  tzdata

COPY pyproject.toml ./
COPY requeriments.txt ./
COPY --from=wheels /wheels /wheels

RUN python -m pip install --upgrade pip setuptools wheel && \
  pip install --no-index --find-links=/wheels -r requeriments.txt

FROM deps AS base

ARG UID=1000
ARG GID=1000
ARG SERVICES_PORT=8000

RUN apk add --no-cache \
  bash \
  bash-completion \
  curl \
  fzf \
  git \
  less

COPY . .
COPY --chmod=755 infra/runtime/containers/services/entrypoint.sh /app/infra/runtime/containers/services/entrypoint.sh

RUN if ! getent group app >/dev/null 2>&1; then addgroup -S app; fi && \
  if ! getent passwd app >/dev/null 2>&1; then adduser -S app -G app; fi && \
  chown -R app:app /app

USER app

ENTRYPOINT ["/app/infra/runtime/containers/services/entrypoint.sh"]
CMD ["/bin/sh", "-lc", "gunicorn --chdir apps/services/chatbot config.wsgi:application --bind 0.0.0.0:${SERVICES_PORT} --workers 2 --threads 4"]

FROM deps AS test

COPY . .

RUN python -m pip install --no-cache-dir pytest && \
  python -m compileall apps/services/chatbot && \
  python apps/services/chatbot/manage.py check

FROM deps AS runtime

ARG UID=1000
ARG GID=1000
ARG SERVICES_PORT=8000

COPY . .
COPY --chmod=755 infra/runtime/containers/services/entrypoint.sh /app/infra/runtime/containers/services/entrypoint.sh

RUN if ! getent group app >/dev/null 2>&1; then addgroup -S app; fi && \
  if ! getent passwd app >/dev/null 2>&1; then adduser -S app -G app; fi && \
  chown -R app:app /app

USER app

ENTRYPOINT ["/app/infra/runtime/containers/services/entrypoint.sh"]
CMD ["/bin/sh", "-lc", "gunicorn --chdir apps/services/chatbot config.wsgi:application --bind 0.0.0.0:${SERVICES_PORT} --workers 2 --threads 4"]
