\set ON_ERROR_STOP on
SET search_path TO masterclass, public;

-- P1-E01 solution
SELECT
    order_id,
    order_date,
    order_total
FROM orders
WHERE order_status = 'completed'
  AND sales_channel = 'web'
  AND order_date >= DATE '2026-06-01'
ORDER BY order_total DESC, order_id;

-- P1-E02 solution
SELECT
    order_id,
    order_status,
    CASE
        WHEN order_status IN ('completed', 'refunded') THEN 'closed'
        WHEN order_status = 'pending' THEN 'open'
        ELSE 'stopped'
    END AS fulfilment_state
FROM orders
ORDER BY order_id;

-- P1-E03 solution
SELECT
    product_name,
    category,
    list_price
FROM products
ORDER BY list_price, product_id
LIMIT 3;
