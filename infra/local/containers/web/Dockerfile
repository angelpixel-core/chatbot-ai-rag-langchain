# syntax=docker/dockerfile:1.5

ARG NODE_VERSION=22.0.0
ARG WEB_PORT=3000
ARG UID=1000
ARG GID=1000

FROM node:${NODE_VERSION}-alpine AS base

WORKDIR /app

ENV NODE_ENV=development \
    WEB_PORT=${WEB_PORT}

RUN apk add --no-cache bash curl

COPY apps/web/package.json ./

RUN npm install

COPY apps/web ./

RUN addgroup -g "$GID" -S app && adduser -S app -G app -u "$UID" && \
  chown -R app:app /app

USER app

EXPOSE ${WEB_PORT}

CMD ["sh", "-lc", "npm run dev -- --hostname 0.0.0.0 --port ${WEB_PORT}"]
