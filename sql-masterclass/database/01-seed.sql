\set ON_ERROR_STOP on
SET search_path TO masterclass, public;

INSERT INTO customers (
    customer_id,
    customer_name,
    email,
    country,
    signup_date,
    customer_segment,
    marketing_channel
)
VALUES
    (1, 'Ada Mensah', 'ada@example.test', 'United Kingdom', '2025-09-12', 'individual', 'organic'),
    (2, 'Noah Williams', 'noah@example.test', 'United States', '2025-10-03', 'team', 'paid search'),
    (3, 'Maya Patel', 'maya@example.test', 'India', '2025-10-19', 'individual', 'referral'),
    (4, 'Leo Martin', 'leo@example.test', 'France', '2025-11-02', 'team', 'organic'),
    (5, 'Zuri Okafor', 'zuri@example.test', 'Nigeria', '2025-11-21', 'enterprise', 'event'),
    (6, 'Sofia Garcia', 'sofia@example.test', 'Spain', '2025-12-04', 'individual', NULL),
    (7, 'Ethan Brown', 'ethan@example.test', 'Canada', '2025-12-18', 'team', 'referral'),
    (8, 'Amina Diallo', 'amina@example.test', 'Senegal', '2026-01-05', 'individual', 'organic'),
    (9, 'Oliver Smith', 'oliver@example.test', 'United Kingdom', '2026-01-22', 'enterprise', 'paid social'),
    (10, 'Yuki Tanaka', 'yuki@example.test', 'Japan', '2026-02-10', 'team', 'event'),
    (11, 'Camila Silva', 'camila@example.test', 'Brazil', '2026-02-27', 'individual', NULL),
    (12, 'Samuel Kim', 'samuel@example.test', 'South Korea', '2026-03-14', 'team', 'organic'),
    (13, 'Nia Johnson', 'nia@example.test', 'United States', '2026-05-12', 'individual', 'referral'),
    (14, 'Hugo Laurent', 'hugo@example.test', 'France', '2026-06-02', 'individual', NULL);

INSERT INTO products (product_id, product_name, category, list_price)
VALUES
    (101, 'Analytics Starter Kit', 'Education', 49.00),
    (102, 'SQL Desk Mat', 'Workspace', 19.00),
    (103, 'Data Notebook', 'Workspace', 12.50),
    (104, 'Mechanical Keyboard', 'Hardware', 89.00),
    (105, 'USB-C Hub', 'Hardware', 59.00),
    (106, 'Monitor Light', 'Hardware', 39.00),
    (107, 'Query Mug', 'Merchandise', 14.00),
    (108, 'Laptop Stand', 'Hardware', 45.00),
    (109, 'Data Team Workshop', 'Education', 249.00),
    (110, 'Dashboard Template Pack', 'Education', 79.00);

INSERT INTO orders (
    order_id,
    customer_id,
    order_date,
    order_status,
    sales_channel
)
SELECT
    order_id,
    1 + ((order_id - 1001) % 12) AS customer_id,
    DATE '2026-01-04' + ((order_id - 1001) * 4) AS order_date,
    CASE
        WHEN order_id % 11 = 0 THEN 'refunded'
        WHEN order_id % 7 = 0 THEN 'cancelled'
        WHEN order_id % 5 = 0 THEN 'pending'
        ELSE 'completed'
    END AS order_status,
    CASE order_id % 3
        WHEN 0 THEN 'web'
        WHEN 1 THEN 'mobile'
        ELSE 'marketplace'
    END AS sales_channel
FROM generate_series(1001, 1045) AS series(order_id);

INSERT INTO order_items (
    order_item_id,
    order_id,
    product_id,
    quantity,
    unit_price
)
SELECT
    ((orders.order_id - 1000) * 10) + 1,
    orders.order_id,
    products.product_id,
    1 + ((orders.order_id - 1001) % 3),
    products.list_price
FROM orders
JOIN products
    ON products.product_id = 101 + ((orders.order_id - 1001) % 10)
UNION ALL
SELECT
    ((orders.order_id - 1000) * 10) + 2,
    orders.order_id,
    products.product_id,
    1 + ((orders.order_id - 999) % 2),
    products.list_price
FROM orders
JOIN products
    ON products.product_id = 101 + ((orders.order_id - 997) % 10)
UNION ALL
SELECT
    ((orders.order_id - 1000) * 10) + 3,
    orders.order_id,
    products.product_id,
    1,
    products.list_price
FROM orders
JOIN products
    ON products.product_id = 101 + ((orders.order_id - 994) % 10)
WHERE (orders.order_id - 1001) % 3 = 0;

UPDATE orders
SET order_total = totals.order_total
FROM (
    SELECT
        order_id,
        SUM(quantity * unit_price) AS order_total
    FROM order_items
    GROUP BY order_id
) AS totals
WHERE orders.order_id = totals.order_id;

ANALYZE;
