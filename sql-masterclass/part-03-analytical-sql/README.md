# Part 3: Analytical SQL

## Outcome

Build a readable analytical query in stages, then compare each result row with
other rows without collapsing the result.

## Definitions used in the video

- **CTE:** a named query expression defined with `WITH` for use by one statement.
- **Result grain:** what one row of the current query result represents.
- **Window function:** a calculation across rows related to the current row.
- **Partition:** the rows assigned to the same window calculation.
- **Window order:** the sequence used inside a window calculation.
- **Frame:** the subset of a partition visible to a frame-sensitive function.
- **Validation query:** a separate check that tests an important assumption or total.

CTEs improve structure, but a name alone does not guarantee performance. Use them
to make each transformation and grain explicit.
