# Part 1: Data definition and querying

## Outcome

Understand how SQL defines a table, then build a readable query that answers a
precise business question: which completed orders are the largest?

## Definitions used in the video

- **Database:** an organised collection of data managed by a database system.
- **Table:** related data stored in named columns and rows.
- **Row:** one record at the table's declared grain.
- **Column:** one named attribute with a data type.
- **Schema:** a namespace that groups database objects.
- **Query:** a request for a result, expressed in SQL.
- **Clause:** a section of a statement such as `FROM`, `WHERE`, or `ORDER BY`.
- **NULL:** a marker for missing or unknown data; it is not zero or an empty string.
- **DDL:** data definition language; statements such as `CREATE`, `ALTER`, and
  `DROP` that change database structure.
- **Constraint:** a rule the database enforces on allowed rows or relationships.

## Files

- Start with [`starter.sql`](starter.sql).
- Compare your work with [`completed.sql`](completed.sql).
- Then attempt [`exercises.sql`](exercises.sql) before opening
  [`solutions.sql`](solutions.sql).
- Run [`ddl.sql`](ddl.sql) for the demonstrated DDL sequence.
- Attempt [`ddl-exercises.sql`](ddl-exercises.sql) before opening
  [`ddl-solutions.sql`](ddl-solutions.sql).

Run the DDL demonstration from the repository root:

```bash
./scripts/run-ddl.sh
```

The script creates and alters `order_reviews`, inspects its columns, and rolls the
transaction back. The table does not remain after the demonstration.

## Mental model

For the queries in this lesson, reason in this order:

```text
FROM -> WHERE -> SELECT -> ORDER BY -> LIMIT
```

That is a reasoning model, not the only optimisation strategy PostgreSQL may use.
