\set ON_ERROR_STOP on
SET search_path TO masterclass, public;

-- P1-Q01: Inspect a few rows before deciding what to select.
SELECT *
FROM orders
ORDER BY order_id
LIMIT 5;

-- P1-Q02: Return only the columns the result needs.
SELECT
    order_id,
    order_date,
    order_status,
    order_total AS revenue_value
FROM orders
ORDER BY order_id
LIMIT 10;

-- P1-Q03: Filter rows before presenting the result.
SELECT
    order_id,
    order_date,
    sales_channel,
    order_total
FROM orders
WHERE order_status = 'completed'
  AND order_date >= DATE '2026-05-01'
ORDER BY order_date;

-- P1-Q04: Turn a business rule into a calculated column.
SELECT
    order_id,
    order_total,
    CASE
        WHEN order_total >= 300 THEN 'large'
        WHEN order_total >= 150 THEN 'medium'
        ELSE 'small'
    END AS order_size
FROM orders
WHERE order_status = 'completed'
ORDER BY order_total DESC;

-- P1-Q05: Ask a complete, deterministic question.
SELECT
    order_id,
    order_date,
    sales_channel,
    order_total
FROM orders
WHERE order_status = 'completed'
ORDER BY order_total DESC, order_id
LIMIT 5;

-- P1-Q06: NULL requires explicit handling.
SELECT
    customer_id,
    customer_name,
    COALESCE(marketing_channel, 'unknown') AS marketing_channel
FROM customers
ORDER BY customer_id;
