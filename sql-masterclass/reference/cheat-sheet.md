# SQL masterclass cheat sheet

## Query reasoning order

```text
FROM and JOIN
WHERE
GROUP BY
HAVING
SELECT
WINDOW
ORDER BY
LIMIT
```

This is a useful logical model. PostgreSQL may choose a different physical
execution strategy while preserving the query's meaning.

## Grain check

Before a join, say what one row represents in each input. After the join, say
what one result row represents. Use both counts when you need proof:

```sql
SELECT
    COUNT(*) AS result_rows,
    COUNT(DISTINCT order_id) AS distinct_orders
FROM ...;
```

## WHERE versus HAVING

- `WHERE` filters input rows before grouping.
- `HAVING` filters groups after aggregation.

## LEFT JOIN filter placement

Put a condition in `ON` when unmatched rows from the left table must survive.
A condition on the right table in `WHERE` can remove those NULL-extended rows.

## Window function anatomy

```sql
function_name(...) OVER (
    PARTITION BY grouping_expression
    ORDER BY sequencing_expression
    ROWS BETWEEN frame_start AND frame_end
)
```

## Production habits

1. Name the business question.
2. State the grain.
3. Build and inspect one transformation at a time.
4. Use deterministic ordering when selecting a limited result.
5. Validate row counts and important totals independently.
