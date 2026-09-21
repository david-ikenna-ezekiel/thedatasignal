#!/usr/bin/env sh
set -eu

query_id=${1:-}

case "$query_id" in
  P1-Q*) sql_file="part-01-querying/completed.sql" ;;
  P2-Q*) sql_file="part-02-joins-and-aggregation/completed.sql" ;;
  P3-Q*) sql_file="part-03-analytical-sql/completed.sql" ;;
  *)
    printf '%s\n' "Usage: $0 P1-Q01 | P2-Q04 | P3-Q06" >&2
    exit 2
    ;;
esac

if ! grep -q "^-- ${query_id}:" "$sql_file"; then
  printf '%s\n' "Unknown query identifier: $query_id" >&2
  exit 3
fi

{
  printf '%s\n' 'SET search_path TO masterclass, public;'
  awk -v query_id="$query_id" '
    $0 ~ "^-- " query_id ":" { in_query = 1; next }
    in_query && $0 ~ "^-- P[123]-Q[0-9][0-9]:" { exit }
    in_query { print }
  ' "$sql_file"
} | docker compose exec -T db psql \
  -U masterclass \
  -d sql_masterclass \
  -v ON_ERROR_STOP=1 \
  -P pager=off
