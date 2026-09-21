#!/usr/bin/env sh
set -eu

docker compose exec -T db psql \
  -U masterclass \
  -d sql_masterclass \
  -v ON_ERROR_STOP=1 \
  -f /work/database/03-validate.sql

for sql_file in \
  /work/part-01-querying/completed.sql \
  /work/part-01-querying/ddl.sql \
  /work/part-01-querying/ddl-solutions.sql \
  /work/part-01-querying/solutions.sql \
  /work/part-02-joins-and-aggregation/completed.sql \
  /work/part-02-joins-and-aggregation/solutions.sql \
  /work/part-03-analytical-sql/completed.sql \
  /work/part-03-analytical-sql/solutions.sql
do
  docker compose exec -T db psql \
    -U masterclass \
    -d sql_masterclass \
    -v ON_ERROR_STOP=1 \
    -f "$sql_file" >/dev/null
done

printf '%s\n' 'All course SQL files passed.'
