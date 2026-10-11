# Databricks Product Tour — Lesson Files

Follow along with The Data Signal's Databricks walkthrough: upload a CSV, explore it in a Python notebook, save a Delta table, write SQL, build a dashboard and run the notebook as a job.

**[Download the lesson ZIP](databricks-product-tour.zip?raw=true)** and unzip it. To save individual files on GitHub, open the file and choose **Download raw file**.

## Files

| File | Purpose |
| --- | --- |
| [Reading sessions CSV](data/reading_sessions.csv) | The 12 fictional sessions used in the video |
| [Column definitions](data/schema.md) | Types to check during upload |
| [Reading log notebook](notebooks/reading_log.py) | Importable Databricks source notebook: read, filter, calculate, save and check |
| [Create the schema](sql/setup.sql) | SQL alternative to creating the schema in Catalog |
| [Reading time by genre](sql/reading_time_by_genre.sql) | Query for SQL Editor |
| [Dashboard dataset query](sql/dashboard_genre_query.sql) | The same query without a trailing semicolon |
| [Check the totals](sql/verify_totals.sql) | Confirm 10 sessions, 300 minutes and 5 hours |
| [Reading time by date](sql/reading_time_by_date.sql) | Optional closing exercise |
| [Expected results](expected-results.json) | Counts and totals for comparison |

The dataset is synthetic. Each row is one reading session; no personal data is included.

## Before you start

The video uses **Databricks Free Edition**, its `workspace` catalog, serverless notebook compute and the available SQL warehouse. Use a workspace where you can create a schema, tables, notebooks, queries, dashboards and jobs.

The object names are:

- Catalog: `workspace`
- Schema: `reading_tour`
- Source table: `reading_sessions`
- Output table: `completed_reading`

If your catalog differs or `reading_tour` contains unrelated work, use your own demo schema. Update the notebook's Python configuration, its final `%sql` cell and **every SQL file**. Python variables do not update the separate SQL statements automatically.

Free Edition uses serverless compute and is subject to usage limits. Check [Databricks' current Free Edition limitations](https://docs.databricks.com/aws/en/getting-started/free-edition-limitations) for availability in your account.

## 1. Create a schema and upload the CSV

In **Catalog**, open `workspace` and create the schema `reading_tour`. Alternatively, run [setup.sql](sql/setup.sql) in SQL Editor on the available warehouse.

Follow the video's **New → Add or upload data → Create or modify a table** route. Upload `data/reading_sessions.csv`, use the first row as headers, and check the [column types](data/schema.md). Create the table as:

```text
workspace.reading_tour.reading_sessions
```

Inspect the table's sample data. It should contain **12 rows**, including two `Planned` sessions. Interface labels may vary by release.

## 2. Import and run the notebook

Create a workspace folder for the project. Use the folder's **Import** action to import `notebooks/reading_log.py` as a notebook, then select the available serverless notebook compute. This `.py` file uses Databricks source-notebook formatting; it is intended to run inside Databricks, where `spark` and `display` are available. See the [notebook import guide](https://docs.databricks.com/aws/en/notebooks/notebook-export-import).

Run the cells in order:

1. Read and display the source table: **12 rows**.
2. Keep `status == "Completed"`: **10 rows**. The source table remains unchanged.
3. Add `hours`, calculated as `ROUND(minutes / 60.0, 2)`. Session 1 shows **45 minutes → 0.75 hours**.
4. Save `workspace.reading_tour.completed_reading` as a Delta table.
5. Run the final SQL cell to check the totals.

**The write cell uses `mode("overwrite")`: rerunning the notebook replaces this demo output table.** It does not replace `reading_sessions`. This matches the final video and allows the notebook to run again as a job. The supplied comment describes overwrite correctly; an earlier comment visible in the recording was outdated.

Expected totals:

| Completed sessions | Total minutes | Total hours |
| ---: | ---: | ---: |
| 10 | 300 | 5.00 |

Calculate total hours from `SUM(minutes) / 60.0`; summing the individually rounded `hours` values can introduce rounding differences.

## 3. Query the saved table

Open **SQL Editor**, select the available SQL warehouse and run [reading_time_by_genre.sql](sql/reading_time_by_genre.sql). Save the query in your project folder.

| Genre | Completed sessions | Total minutes |
| --- | ---: | ---: |
| Technology | 4 | 150 |
| Fiction | 3 | 90 |
| History | 3 | 60 |

The Python notebook and SQL Editor are reading the same saved table. You can also run [verify_totals.sql](sql/verify_totals.sql) separately in SQL Editor.

## 4. Build the dashboard

Create a dashboard. On its **Data** tab, add a SQL dataset using [dashboard_genre_query.sql](sql/dashboard_genre_query.sql). Run it and confirm the three rows above.

Add a bar chart using that dataset:

- Horizontal axis: `genre`
- Vertical axis: **SUM(total_minutes)**
- Suggested title: **Completed reading minutes by genre**

Counting the three summary rows will not show reading time. The bars should represent **90 minutes for Fiction, 60 for History and 150 for Technology**. Technology accounts for half of the completed reading time. Keep the dashboard as a draft for this exercise.

## 5. Run the notebook as a job

Open **Jobs & Pipelines** and create a job with a **Notebook** task. Select the imported `reading_log` notebook and available serverless compute, save the task, then choose **Run now**.

Check the run's status and task output. After a successful run, the totals should still be **10 / 300 / 5.00**. The recorded run took about a minute; your duration can differ. A schedule is optional—the demonstration uses a manual run. The notebook's overwrite cell refreshes the demo output on each run.

## Try one change

Run [reading_time_by_date.sql](sql/reading_time_by_date.sql). It groups the completed sessions by date instead of genre. Expected daily minutes for 21–25 September 2026 are **75, 50, 40, 75 and 60**; they still add up to 300.

## Troubleshooting

| Symptom | Check |
| --- | --- |
| Table not found | Confirm the CSV upload finished and the catalog/schema/table names match in Python and SQL. |
| Variable not defined | Run earlier Python cells in order. |
| Schema already exists | Inspect it or use a fresh demo schema; update all references. |
| Permission error | Use a catalog/schema where you have creation access. |
| Totals show 12 sessions or 350 minutes | Query `completed_reading`, not the unfiltered `reading_sessions` source. |
| Equal-height chart bars | Use `SUM(total_minutes)` for the vertical axis. |
| Quota message | Keep your files and resume when your account's compute allowance resets. |

Genie, machine learning and Apps are explored in the tour; this package contains the reading-log project that is built and run. Review AI-generated answers before relying on them.

The CSV arithmetic and included SELECT queries were checked locally against the expected results. These files use the final recorded demo's logic; this resource package does not claim a fresh Databricks account execution.
