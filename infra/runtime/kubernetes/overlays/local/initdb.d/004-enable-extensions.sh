#!/usr/bin/env sh
set -eu

: "${POSTGRES_DB:?POSTGRES_DB is required}"

for db_name in \
  "$POSTGRES_DB" \
  "${POSTGRES_QUEUE_DB:-${POSTGRES_DB}_queue}" \
  "${POSTGRES_CABLE_DB:-${POSTGRES_DB}_cable}" \
  "${POSTGRES_TEST_DB:-coffee_chatbot_test}" \
  "${POSTGRES_TEST_QUEUE_DB:-${POSTGRES_TEST_DB:-coffee_chatbot_test}_queue}" \
  "${POSTGRES_TEST_CABLE_DB:-${POSTGRES_TEST_DB:-coffee_chatbot_test}_cable}"
do
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$db_name" <<-EOSQL
    CREATE EXTENSION IF NOT EXISTS pgcrypto;
EOSQL
done
