# BigQuery in 10 Minutes — Lesson Files

Follow along with The Data Signal's beginner BigQuery walkthrough: upload a CSV, create a table, run SQL and save a view. Every example in this lesson works in the **BigQuery sandbox without a billing account**.

## Download the resources

**[Download the lesson ZIP](bigquery-in-10-minutes.zip?raw=true)** and unzip it on your computer. It contains this guide, the CSV, schema definitions, five SQL examples and expected results. You can also browse the files below; on a GitHub file page, use **Download raw file** to save an individual file.

| File | What it is for |
| --- | --- |
| [orders.csv](data/orders.csv) | The 12 fictional orders shown in the video |
| [schema.txt](data/schema.txt) | Column definitions to paste into Create table |
| [schema.json](data/schema.json) | The same column definitions in JSON format |
| [All orders](sql/BQ-Q00a-all-orders.sql) | First SELECT: 12 rows |
| [Completed orders](sql/BQ-Q00b-completed-orders.sql) | Add WHERE: 10 rows |
| [Five completed orders](sql/BQ-Q01-first-query.sql) | Add LIMIT: 5 rows |
| [Product totals](sql/BQ-Q02-product-revenue.sql) | GROUP BY, COUNT and SUM: 3 rows |
| [Query the view](sql/BQ-Q03-query-view.sql) | Read the saved product_revenue view |
| [Expected results](expected-results.json) | Check your row counts and totals |

The data is synthetic. Each row is one single-product order for coffee, tea or cocoa; prices are in GBP. Two orders are cancelled. No customer data is included.

## Before you start

1. Open the [BigQuery console](https://console.cloud.google.com/bigquery) and sign in with your Google account.
2. Create or select your own sandbox project. Look for the **Sandbox** notice and leave billing unattached. You do not need trial credits for this lesson.
3. Note your **project ID**. It can differ from the project display name.

You need permission to create datasets, tables and views and to run queries. Use a separate learning project rather than changing billing on a work project. See [Google's sandbox guide](https://docs.cloud.google.com/bigquery/docs/sandbox) for current setup requirements and limitations.

## 1. Create the dataset

In Explorer, open **Datasets** under your project and choose **Create dataset**. Name it `signal_shop_demo`. The video uses the **EU multi-region**; choose an appropriate location for your own practice and keep queries in the same processing location. A dataset's location cannot be changed after creation.

## 2. Upload the CSV

Open your dataset and choose **Create table**:

- Source: **Upload**; select the downloaded `data/orders.csv`.
- File format: **CSV**.
- Destination: your project, `signal_shop_demo`, table name `orders`.
- Leave **Auto detect OFF**. Turn **Edit as text ON** and paste the contents of `data/schema.txt`.
- Under **Advanced options**, set **Header rows to skip** to `1`. Use comma-delimited input and match source columns by position.
- Keep the table unpartitioned and unclustered for this example, then create it.

Open **Preview** to see 12 rows, **Schema** to see the six columns, and **Details** to inspect metadata and expiration. The narration briefly says to turn Edit as text off; it needs to be **on** when pasting the schema, as shown by the on-screen correction.

## 3. Run the SQL examples

In every SQL file, replace `YOUR_PROJECT_ID` with your own project ID. Keep the backticks around the full table or view name. These examples use GoogleSQL.

Run the files in this order:

1. `BQ-Q00a-all-orders.sql`: select three columns from all 12 orders.
2. `BQ-Q00b-completed-orders.sql`: filter out cancelled orders, leaving 10.
3. `BQ-Q01-first-query.sql`: limit the output to five rows.
4. `BQ-Q02-product-revenue.sql`: group completed orders by product.

Before each run, check the processed-data estimate. `LIMIT 5` limits the returned rows; it does not guarantee that BigQuery scans only five rows. The `WHERE` clause goes **after FROM and before ORDER BY**. These SELECT queries do not change the underlying table.

The grouped result should be:

| Product | Completed orders | Units sold | Revenue (GBP) |
| --- | ---: | ---: | ---: |
| Coffee | 4 | 10 | 120.00 |
| Tea | 3 | 9 | 72.00 |
| Cocoa | 3 | 6 | 60.00 |

That is 10 completed orders, 25 units and £252 in total. BigQuery may display `120` instead of `120.00`; the numeric value is the same.

## 4. Save and query a view

With the product-totals query open, choose **Save > Save view**. Save it in your project and `signal_shop_demo` dataset as `product_revenue`.

Then open `BQ-Q03-query-view.sql`, replace `YOUR_PROJECT_ID`, and run it. You should see the same three product totals. A logical view stores the query definition; querying it can still use your query-processing allowance.

## 5. Find your query again

Open **Job history** in Explorer, then **Personal history**. Open the completed query's job ID and choose **View job in editor**. This recovers a query you have already run after closing its editor tab. Job information also helps you inspect duration, processed data and errors. Console labels can change over time.

## Try one change

In the product-totals query, replace `product` with `order_date` in SELECT, GROUP BY and the final ORDER BY tie-breaker. Keep the completed-order filter. You now have one row per day; the revenue should still add up to £252.

## Sandbox limits

As checked on 4 October 2026, the sandbox has a lifetime 10 GiB storage allowance and 1 TiB of processed query data per month. Deleting data does not restore the lifetime storage allowance. Tables and views automatically expire after 60 days, so keep your original files.

The sandbox excludes features such as streaming, DML statements (`INSERT`, `UPDATE`, `DELETE`) and BigQuery Data Transfer Service. Those features require moving beyond the sandbox and may incur charges. You do not need them for this lesson. Recheck [Google's current sandbox documentation](https://docs.cloud.google.com/bigquery/docs/sandbox) before starting.

## Troubleshooting

- **Table not found:** check the project ID, dataset, table name and processing location.
- **Upload error:** check the schema order, CSV format and the one skipped header row.
- **Access denied:** check that your account can create resources and run jobs in the selected project.
- **Missing practice table later:** check its expiration; rebuild it from the local CSV if needed.
- **Fresh practice run:** use a new dataset name and update the SQL references rather than overwriting existing work.

The upload, SQL queries and saved view were demonstrated in a real no-billing BigQuery sandbox for the video. The files retain `YOUR_PROJECT_ID` placeholders so viewers can use their own projects.
