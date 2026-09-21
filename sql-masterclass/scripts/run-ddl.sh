#!/usr/bin/env sh
set -eu

docker compose exec -T db psql \
  -U masterclass \
  -d sql_masterclass \
  -v ON_ERROR_STOP=1 \
  -P pager=off \
  -f /work/part-01-querying/ddl.sql
