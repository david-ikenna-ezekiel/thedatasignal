\set ON_ERROR_STOP on
SET search_path TO masterclass, public;

DO $$
BEGIN
    IF (SELECT COUNT(*) FROM customers) <> 14 THEN
        RAISE EXCEPTION 'Expected 14 customers';
    END IF;

    IF (SELECT COUNT(*) FROM products) <> 10 THEN
        RAISE EXCEPTION 'Expected 10 products';
    END IF;

    IF (SELECT COUNT(*) FROM orders) <> 45 THEN
        RAISE EXCEPTION 'Expected 45 orders';
    END IF;

    IF (SELECT COUNT(*) FROM order_items) <> 105 THEN
        RAISE EXCEPTION 'Expected 105 order items';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM orders AS o
        JOIN (
            SELECT
                order_id,
                SUM(quantity * unit_price) AS calculated_total
            FROM order_items
            GROUP BY order_id
        ) AS item_totals USING (order_id)
        WHERE o.order_total <> item_totals.calculated_total
    ) THEN
        RAISE EXCEPTION 'An order total does not match its line items';
    END IF;
END
$$;

SELECT
    'dataset_valid' AS validation_result,
    (SELECT COUNT(*) FROM customers) AS customers,
    (SELECT COUNT(*) FROM orders) AS orders,
    (SELECT COUNT(*) FROM order_items) AS order_items;
