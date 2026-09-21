# Part 2: Joins and aggregation

## Outcome

Combine customers, orders, line items, and products without losing control of
what one result row represents.

## Definitions used in the video

- **Grain:** what one row represents.
- **Primary key:** a column or set of columns that uniquely identifies a row.
- **Foreign key:** a value that references a key in another table.
- **Relationship:** the rule connecting rows in two tables.
- **One-to-many:** one row on one side may match several rows on the other.
- **Join:** an operation that combines matching rows from table expressions.
- **Aggregate:** a calculation over several rows, such as `SUM` or `COUNT`.
- **Group:** the rows that share the values named in `GROUP BY`.

The central rule is to state the grain before and after every join.
