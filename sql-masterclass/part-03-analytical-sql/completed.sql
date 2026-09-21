\set ON_ERROR_STOP on
SET search_path TO masterclass, public;

-- P3-Q01: Name a clean, reusable analytical base.
WITH base_sales AS (
    SELECT
        o.order_id,
        o.order_date,
        date_trunc('month', o.order_date)::date AS revenue_month,
        p.product_id,
        p.product_name,
        p.category,
        oi.quantity,
        oi.quantity * oi.unit_price AS line_revenue
    FROM orders AS o
    JOIN order_items AS oi
        ON oi.order_id = o.order_id
    JOIN products AS p
        ON p.product_id = oi.product_id
    WHERE o.order_status = 'completed'
)
SELECT *
FROM base_sales
ORDER BY order_id, product_id
LIMIT 12;

-- P3-Q02: Each result row now represents one month and category.
WITH base_sales AS (
    SELECT
        date_trunc('month', o.order_date)::date AS revenue_month,
        p.category,
        oi.quantity * oi.unit_price AS line_revenue
    FROM orders AS o
    JOIN order_items AS oi
        ON oi.order_id = o.order_id
    JOIN products AS p
        ON p.product_id = oi.product_id
    WHERE o.order_status = 'completed'
)
SELECT
    revenue_month,
    category,
    SUM(line_revenue) AS category_revenue
FROM base_sales
GROUP BY
    revenue_month,
    category
ORDER BY
    category,
    revenue_month;

-- P3-Q03: LAG keeps each month while exposing the previous month.
WITH base_sales AS (
    SELECT
        date_trunc('month', o.order_date)::date AS revenue_month,
        p.category,
        oi.quantity * oi.unit_price AS line_revenue
    FROM orders AS o
    JOIN order_items AS oi
        ON oi.order_id = o.order_id
    JOIN products AS p
        ON p.product_id = oi.product_id
    WHERE o.order_status = 'completed'
),
monthly_category_revenue AS (
    SELECT
        revenue_month,
        category,
        SUM(line_revenue) AS category_revenue
    FROM base_sales
    GROUP BY
        revenue_month,
        category
),
with_previous_month AS (
    SELECT
        revenue_month,
        category,
        category_revenue,
        LAG(category_revenue) OVER (
            PARTITION BY category
            ORDER BY revenue_month
        ) AS previous_month_revenue
    FROM monthly_category_revenue
)
SELECT
    revenue_month,
    category,
    category_revenue,
    previous_month_revenue,
    category_revenue - previous_month_revenue AS revenue_change,
    ROUND(
        100 * (category_revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0),
        1
    ) AS revenue_change_pct
FROM with_previous_month
ORDER BY
    category,
    revenue_month;

-- P3-Q04: State the frame explicitly for a predictable running total.
WITH monthly_revenue AS (
    SELECT
        date_trunc('month', order_date)::date AS revenue_month,
        SUM(order_total) AS monthly_revenue
    FROM orders
    WHERE order_status = 'completed'
    GROUP BY date_trunc('month', order_date)::date
)
SELECT
    revenue_month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (
        ORDER BY revenue_month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_revenue
FROM monthly_revenue
ORDER BY revenue_month;

-- P3-Q05: Rank products within their own categories.
WITH product_revenue AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(oi.quantity * oi.unit_price) AS completed_revenue
    FROM orders AS o
    JOIN order_items AS oi
        ON oi.order_id = o.order_id
    JOIN products AS p
        ON p.product_id = oi.product_id
    WHERE o.order_status = 'completed'
    GROUP BY
        p.product_id,
        p.product_name,
        p.category
)
SELECT
    product_name,
    category,
    completed_revenue,
    DENSE_RANK() OVER (
        PARTITION BY category
        ORDER BY completed_revenue DESC
    ) AS category_rank
FROM product_revenue
ORDER BY
    category,
    category_rank,
    product_name;

-- P3-Q06: A production query needs a proof query.
WITH item_total AS (
    SELECT
        SUM(oi.quantity * oi.unit_price) AS completed_revenue
    FROM orders AS o
    JOIN order_items AS oi
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'completed'
),
order_table_total AS (
    SELECT
        SUM(order_total) AS completed_revenue
    FROM orders
    WHERE order_status = 'completed'
)
SELECT
    item_total.completed_revenue AS item_revenue,
    order_table_total.completed_revenue AS order_revenue,
    item_total.completed_revenue = order_table_total.completed_revenue
        AS totals_match
FROM item_total
CROSS JOIN order_table_total;
