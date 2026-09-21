\set ON_ERROR_STOP on
SET search_path TO masterclass, public;

-- P2-Q01: Establish the source grain before joining.
SELECT 'orders' AS source, COUNT(*) AS row_count
FROM orders
UNION ALL
SELECT 'order_items' AS source, COUNT(*) AS row_count
FROM order_items;

-- P2-Q02: One customer can have many orders, but each order has one customer.
SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    c.country,
    o.order_total
FROM orders AS o
JOIN customers AS c
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'completed'
ORDER BY o.order_id;

-- P2-Q03: The result grain is now one row per order line item.
SELECT
    o.order_id,
    o.order_date,
    p.product_name,
    p.category,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS line_revenue
FROM orders AS o
JOIN order_items AS oi
    ON oi.order_id = o.order_id
JOIN products AS p
    ON p.product_id = oi.product_id
WHERE o.order_status = 'completed'
ORDER BY o.order_id, oi.order_item_id;

-- P2-Q04: Joined rows are not the same thing as distinct orders.
SELECT
    COUNT(*) AS joined_rows,
    COUNT(DISTINCT o.order_id) AS distinct_orders,
    COUNT(DISTINCT oi.order_item_id) AS distinct_line_items
FROM orders AS o
JOIN order_items AS oi
    ON oi.order_id = o.order_id
WHERE o.order_status = 'completed';

-- P2-Q05: Collapse line-item rows into one row per category.
SELECT
    p.category,
    COUNT(DISTINCT o.order_id) AS order_count,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS category_revenue
FROM orders AS o
JOIN order_items AS oi
    ON oi.order_id = o.order_id
JOIN products AS p
    ON p.product_id = oi.product_id
WHERE o.order_status = 'completed'
GROUP BY p.category
HAVING SUM(oi.quantity * oi.unit_price) >= 500
ORDER BY category_revenue DESC;

-- P2-Q06: Put the status condition in ON to preserve unmatched customers.
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS completed_orders,
    COALESCE(SUM(o.order_total), 0) AS completed_revenue
FROM customers AS c
LEFT JOIN orders AS o
    ON o.customer_id = c.customer_id
   AND o.order_status = 'completed'
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY completed_revenue DESC, c.customer_id;
