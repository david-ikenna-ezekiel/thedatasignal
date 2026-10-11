# Source table columns

Use the first CSV row as column headers. Check these inferred types before creating `workspace.reading_tour.reading_sessions`.

| Column | Databricks type | Meaning |
| --- | --- | --- |
| session_id | BIGINT (INT also works) | Unique fictional session ID |
| session_date | DATE | Session date in YYYY-MM-DD format |
| genre | STRING | Technology, Fiction or History |
| minutes | BIGINT (INT also works) | Reading duration in minutes |
| status | STRING | Completed or Planned |

The source contains 12 rows. IDs 11 and 12 are Planned. The notebook adds an `hours` column to the 10-row output table; it does not change the source CSV or source table.
