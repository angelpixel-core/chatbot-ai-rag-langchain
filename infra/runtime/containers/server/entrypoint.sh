#!/usr/bin/env sh
set -e

echo "Waiting for database..."

DB_HOST="${DB_HOST:-db}"
DB_PORT="${DB_PORT:-5432}"
DB_USER="${DB_USER:-app}"
DB_PASSWORD="${DB_PASSWORD:-app_password}"

for i in 1 2 3 4 5 6 7 8 9 10; do
  if PGPASSWORD="$DB_PASSWORD" pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" >/dev/null 2>&1; then
    break
  fi
  sleep 1
  if [ "$i" = "10" ]; then
    echo "Database not ready"
    exit 1
  fi
done

exec "$@"
