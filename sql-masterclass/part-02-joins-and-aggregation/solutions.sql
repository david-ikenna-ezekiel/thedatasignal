\set ON_ERROR_STOP on
SET search_path TO masterclass, public;

-- P2-E01 solution
SELECT
    c.country,
    COUNT(DISTINCT o.order_id) AS completed_orders,
    SUM(o.order_total) AS completed_revenue
FROM customers AS c
JOIN orders AS o
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'completed'
GROUP BY c.country
ORDER BY completed_revenue DESC, c.country;

-- P2-E02 solution
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS completed_revenue
FROM products AS p
JOIN order_items AS oi
    ON oi.product_id = p.product_id
JOIN orders AS o
    ON o.order_id = oi.order_id
WHERE o.order_status = 'completed'
GROUP BY
    p.product_id,
    p.product_name
HAVING SUM(oi.quantity) >= 10
ORDER BY completed_revenue DESC, p.product_id;

-- P2-E03 solution
SELECT
    c.customer_id,
    c.customer_name
FROM customers AS c
LEFT JOIN orders AS o
    ON o.customer_id = c.customer_id
   AND o.order_status = 'completed'
GROUP BY
    c.customer_id,
    c.customer_name
HAVING COUNT(o.order_id) = 0
ORDER BY c.customer_id;
