# Google Sheets for Data Analysis

Follow along with The Data Signal's beginner walkthrough: import a small orders dataset, remove a duplicate, calculate revenue, match product categories, and build a pivot table and chart.

The example is fictional stationery-order data. Amounts are shown in pounds in the video. The walkthrough uses formulas directly in Google Sheets; the copyable formulas are in [formulas.md](formulas.md).

## Download the practice files

- [orders.csv](data/orders.csv) — the original starting file, including the intentional duplicate. On GitHub, open the file and use **Download raw file**, or save the linked raw file below.
- [Download orders.csv directly](https://raw.githubusercontent.com/david-ikenna-ezekiel/thedatasignal/main/google-sheets-data-analysis/data/orders.csv)
- [products.csv](data/products.csv) — the small product/category lookup list.
- [formulas.md](formulas.md) — formulas, destination cells and equivalent cell-range versions.
- [expected-results.json](expected-results.json) — totals to check against your workbook.
- [orders-cleaned-reference.csv](data/orders-cleaned-reference.csv) — a completed reference with calculated values. Start with orders.csv if you want to practise the cleaning and formulas yourself. CSV stores values; this reference does not preserve formulas, tables or charts.

## Follow the walkthrough

1. Open Google Sheets, create a blank spreadsheet and name it **Sheets Analysis Practice**.
2. Choose **File → Import → Upload** and select `orders.csv`. Replace the current empty sheet, use a comma separator and check that each heading has its own column.
3. Rename the imported tab **Raw Data**. Duplicate it, name the copy **Orders**, and keep Raw Data for comparison.
4. On Orders, select the full dataset and use **Data → Data cleanup → Remove duplicates**. Include the header row and compare all six columns. The repeated O001 record should be removed once.
5. Convert the cleaned range A1:F13 to a table named **SalesData**. Explore the column types, freeze the headings, and create a filter view for North. Return to all records before continuing.
6. Add **Revenue** in G1. Enter `=E2*F2` in G2 and fill it down through G13. Format revenue as currency if needed for your workbook.
7. Add **Summary** and use the SUM, AVERAGE, COUNTA and SUMIFS examples in [formulas.md](formulas.md).
8. Add **Products**. Enter the contents of `products.csv` in A1:B4, including its header. On Orders, add **Category** in H1, enter the XLOOKUP formula in H2 and fill it down through H13.
9. Create a pivot table from the Orders table on a new tab named **Analysis**. Add **Region** under Rows and **Revenue** under Values, summarised by SUM. Add Product under Columns to explore the mix; Category under Filters lets you inspect Writing supplies.
10. Restore all categories and remove Product from Columns for the simple regional comparison. Chart the three regional totals and headings, leaving Grand Total out. Use a column chart titled **Revenue by region (£)** with the vertical-axis minimum at zero.
11. On Orders, try conditional formatting on Revenue with **Greater than 35**. Inspect the Share permissions, version history, and File → Make a copy / Download options shown in the video.

## Check your results

| Check | Expected result |
|---|---:|
| Starting records, excluding the header | 13 |
| Starting revenue, including the duplicate | £370 |
| Duplicate | O001, worth £30 |
| Unique records after cleaning | 12 |
| Total revenue | £340 |
| Average revenue per order | £28.33 |
| North revenue | £120 |
| South revenue | £110 |
| West revenue | £110 |
| Revenue values greater than £35 | One at £50 and three at £40 |

Notebook revenue totals £140; Folder and Pen each total £100. North's £120 includes £70 from notebooks, £30 from folders and £20 from pens.

Changing the first order's Units from 3 to 4 adds £10: North becomes £130 and the overall total becomes £350. Undo that change to return to the original results.

The pivot in the demonstration uses **SalesData**, the named table. When adding new orders, check that the table and pivot source include them. If your own pivot uses a fixed cell range, inspect that range as well. Compare the pivot total with the formula total after changes.

## Try it yourself

- Add another order and make sure it belongs to the table.
- Fill Revenue and Category into the new row.
- Compare the updated pivot and formula totals; they should agree.
- Group the pivot by Product instead of Region.
- Write one sentence explaining a result, and name the numbers that support it.

For the original sample: **North earned the most revenue at £120, £10 ahead of both South and West; £70 of North's total came from notebooks.**
