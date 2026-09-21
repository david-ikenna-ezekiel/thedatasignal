# SQL glossary

## Database structure

- **Database:** data and database objects managed together.
- **Schema:** a namespace inside a database.
- **Table:** a named relation represented as rows and columns.
- **Row:** one record at a declared grain.
- **Column:** a named attribute with a data type.
- **Data type:** the kind of value a column or expression can hold.
- **NULL:** missing or unknown information.

## Relationships

- **Grain:** the meaning of one row.
- **Primary key:** a value that uniquely identifies a row.
- **Foreign key:** a value constrained to reference a key in another table.
- **One-to-many:** one row may relate to several rows in another table.
- **Join:** a table expression made by matching rows from two inputs.

## Querying and analysis

- **Clause:** a structural part of a SQL statement.
- **Expression:** a calculation that produces a value.
- **Aggregate:** a function that summarises several input rows.
- **CTE:** a named query expression declared in a `WITH` clause.
- **Window function:** a calculation over rows related to the current result row.
- **Partition:** the rows assigned to the same window calculation.
- **Frame:** the ordered subset visible to a frame-sensitive window function.
