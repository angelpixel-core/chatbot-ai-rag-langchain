# syntax=docker/dockerfile:1.5

ARG NODE_VERSION=22.0.0
ARG WEB_PORT=3000
ARG UID=1000
ARG GID=1000

FROM node:${NODE_VERSION}-alpine AS deps

WORKDIR /app

ENV WEB_PORT=${WEB_PORT}

RUN apk add --no-cache ca-certificates tzdata

COPY apps/web/chatbot/package.json ./

RUN npm install

FROM deps AS base

ARG UID=1000
ARG GID=1000
ARG WEB_PORT=3000

ENV NODE_ENV=development

RUN apk add --no-cache \
  bash \
  bash-completion \
  curl \
  fzf \
  git \
  less

COPY apps/web/chatbot ./

RUN if ! getent group app >/dev/null 2>&1; then addgroup -S app; fi && \
  if ! getent passwd app >/dev/null 2>&1; then adduser -S app -G app; fi && \
  chown -R app:app /app

USER app

CMD ["sh", "-lc", "npm run dev -- --hostname 0.0.0.0 --port ${WEB_PORT}"]

FROM deps AS test

COPY apps/web/chatbot ./

RUN npm run build

FROM node:${NODE_VERSION}-alpine AS runtime

WORKDIR /app

ENV NODE_ENV=production \
    WEB_PORT=${WEB_PORT}

RUN apk add --no-cache ca-certificates libc6-compat tzdata

COPY --from=test /app/.next/standalone ./
COPY --from=test /app/.next/static ./.next/static

RUN if ! getent group app >/dev/null 2>&1; then addgroup -S app; fi && \
  if ! getent passwd app >/dev/null 2>&1; then adduser -S app -G app; fi && \
  chown -R app:app /app

USER app

CMD ["node", "server.js"]
