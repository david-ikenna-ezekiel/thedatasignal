# SQL Masterclass in 30 Minutes

This repository accompanies a three-part SQL video course from The Data Signal.
It uses one small ecommerce database to teach data definition, querying, joins,
aggregation, common table expressions, and window functions.

The course uses PostgreSQL 17. Most queries use standard SQL, but date functions,
casts, and a few details may differ in another database.

## Course path

1. Part 1: Data definition and querying — [watch the video](https://youtu.be/rVMVKsfha1U) · [open the course files](part-01-querying/README.md)
2. Part 2: Joins and aggregation — [watch the video](https://youtu.be/uHEE1QPo9hQ) · [open the course files](part-02-joins-and-aggregation/README.md)
3. Part 3: Analytical SQL — [watch the video](https://youtu.be/cco9F4rlb9Y) · [open the course files](part-03-analytical-sql/README.md)

Each part contains:

- `starter.sql` for following the video
- `completed.sql` with the exact numbered examples
- `exercises.sql` for independent practice
- `solutions.sql` with worked answers

Part one also includes a safe DDL demonstration and separate DDL exercises. The
examples run inside a transaction and roll back when complete.

Code identifiers such as `P1-D01` and `P2-Q04` match the labels used in the video
scripts and screen-recording plan.

## Choose your setup

You only need a working PostgreSQL 17 database. If PostgreSQL already runs on
your Windows, macOS, or Linux system, use it directly. Docker is optional and is
provided as a convenient fallback when you do not have PostgreSQL installed or
do not want to configure a local database.

### Option 1: Use an existing PostgreSQL installation

From the repository's `sql-masterclass` directory, create a database and load
the course files in order:

```bash
createdb sql_masterclass
psql -d sql_masterclass -v ON_ERROR_STOP=1 -f database/00-schema.sql
psql -d sql_masterclass -v ON_ERROR_STOP=1 -f database/01-seed.sql
psql -d sql_masterclass -v ON_ERROR_STOP=1 -f database/02-indexes.sql
psql -d sql_masterclass -v ON_ERROR_STOP=1 -f database/03-validate.sql
```

If your PostgreSQL setup requires a host, port, or username, add the appropriate
`psql` connection options. You can also run the same four files in order from
DBeaver, DataGrip, VS Code, pgAdmin, or another PostgreSQL client.

Open an interactive session:

```bash
psql -d sql_masterclass
```

Then run a completed lesson from inside `psql`:

```text
\i part-01-querying/completed.sql
```

### Option 2: Use Docker

Use this option if PostgreSQL is not already available on your system. You need
Docker Desktop or another Docker environment with Compose support.

Start the included PostgreSQL environment:

```bash
docker compose up -d
```

Wait until the database is healthy:

```bash
docker compose ps
```

Open an interactive PostgreSQL session:

```bash
docker compose exec db psql -U masterclass -d sql_masterclass
```

From inside `psql`, run a completed lesson:

```text
\i /work/part-01-querying/completed.sql
```

You can also connect from DBeaver, DataGrip, VS Code, or another SQL client:

```text
Host: localhost
Port: 5438
Database: sql_masterclass
Username: masterclass
Password: masterclass
```

These are local teaching credentials, not production credentials.

## Reset the database

With a native PostgreSQL installation, rerun `database/00-schema.sql`,
`database/01-seed.sql`, and `database/02-indexes.sql` in that order. The first
file replaces only the `masterclass` schema used by this course.

With Docker, the following commands delete only the volume created for this
course, then rebuild the synthetic database:

```bash
docker compose down -v
docker compose up -d
```

## Validate the course files

For a native installation, validate the dataset with:

```bash
psql -d sql_masterclass -v ON_ERROR_STOP=1 -f database/03-validate.sql
```

For Docker, run the full course validation with:

```bash
./scripts/validate.sh
```

The script checks the schema, seed data, completed examples, and exercise
solutions. It stops on the first SQL error.

## Dataset

The `Signal Store` dataset is synthetic and generated entirely by the SQL files
in this repository. It contains customers, products, orders, and order line
items. No personal or customer data is used.

See [the schema reference](reference/schema.md) and
[the glossary](reference/glossary.md) before starting if relational database
terms are new to you.

## Portability

The teaching ideas apply across major relational databases. PostgreSQL-specific
details in this repository include `date_trunc`, date literals, casts using
`::`, `FILTER`, and the Docker setup. Translate those expressions when using
MySQL, SQL Server, BigQuery, Snowflake, or another engine.

## Licence

A licence has not yet been selected. Do not assume permission beyond viewing
and running the material locally until the repository owner adds one.
