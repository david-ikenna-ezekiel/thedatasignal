# Formulas from the walkthrough

Use the sheet names **Orders**, **Summary** and **Products**. The cleaned data is a table named **SalesData**. Its headings are OrderID, Date, Region, Product, Units, UnitPrice, Revenue and Category.

These examples use commas between arguments. Some spreadsheet locales use semicolons. Currency formatting changes how the value is displayed; it does not change the calculation.

## 1. Revenue per order

On Orders, put Revenue in G1. In G2 enter:

```text
=E2*F2
```

Fill down through G13. The first result is 30: three notebooks at £10 each. The next row becomes `=E3*F3` because these are relative references.

## 2. Total, average and order count

On Summary, use these labels and cells:

| Label cell | Label | Formula cell | Formula | Expected result |
|---|---|---|---|---:|
| A1 | Total revenue | B1 | `=SUM(SalesData[Revenue])` | 340 |
| A2 | Average revenue | B2 | `=AVERAGE(SalesData[Revenue])` | 28.33 when displayed to two decimal places |
| A3 | Orders | B3 | `=COUNTA(SalesData[OrderID])` | 12 |

For a workbook using ordinary ranges rather than a named table, the equivalents for this initial cleaned dataset are:

```text
=SUM(Orders!G2:G13)
=AVERAGE(Orders!G2:G13)
=COUNTA(Orders!A2:A13)
```

These fixed ranges cover the original 12 records. Check them when adding rows. The average is revenue per order, not average price per item. COUNTA counts non-empty IDs; the one-ID-per-order assumption is why that count represents orders in this sample.

## 3. Revenue for a chosen region with SUMIFS

On Summary, put Region in A5 and North in B5. Put Region revenue in A6. In B6 enter:

```text
=SUMIFS(SalesData[Revenue],SalesData[Region],B5)
```

The result is 120. Change B5 to South or West and it becomes 110. The formula stays the same.

Equivalent for the original cleaned cell ranges:

```text
=SUMIFS(Orders!G2:G13,Orders!C2:C13,B5)
```

SUM adds the whole referenced revenue column even when a filter hides rows. SUMIFS selects records meeting its explicit condition; the formula above uses the region entered in B5.

## 4. Match product categories with XLOOKUP

Create the Products sheet with this exact A1:B4 layout:

| Product | Category |
|---|---|
| Notebook | Paper |
| Folder | Paper |
| Pen | Writing |

On Orders, put Category in H1. In H2 enter:

```text
=XLOOKUP(D2,Products!$A$2:$A$4,Products!$B$2:$B$4,"Check product",0)
```

Fill down through H13.

- D2 is the product being looked up.
- Products!$A$2:$A$4 is the lookup list.
- Products!$B$2:$B$4 contains the categories to return.
- Dollar signs keep both reference ranges fixed while the order-row reference changes.
- "Check product" is returned when no match is found.
- 0 requests an exact match.

Keep each product unique in the reference list. Notebook and Folder should return Paper; Pen should return Writing.
