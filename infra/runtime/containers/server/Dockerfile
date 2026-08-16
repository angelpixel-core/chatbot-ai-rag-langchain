# syntax=docker/dockerfile:1.5

ARG PYTHON_VERSION=3.15.0rc1
ARG UID=1000
ARG GID=1000
ARG SERVER_PORT=8000

FROM python:${PYTHON_VERSION}-alpine3.24 AS base

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
    SERVER_PORT=${SERVER_PORT}

RUN apk add --no-cache \
  bash \
  curl \
  build-base \
  git \
  linux-headers \
  tzdata \
  sqlite \
  postgresql-libs \
  mariadb-connector-c

COPY pyproject.toml ./
COPY requeriments.txt ./

RUN python -m pip install --upgrade pip setuptools wheel && \
  if [ -f requeriments.txt ]; then pip install -r requeriments.txt; fi

COPY . .

RUN chmod +x /app/infra/runtime/containers/server/entrypoint.sh || true

RUN addgroup -g "$GID" -S app && adduser -S app -G app -u "$UID" && \
  chown -R app:app /app

USER app

ENTRYPOINT ["/bin/sh", "-lc", "python apps/server/manage.py runserver 0.0.0.0:${SERVER_PORT}"]
