\set ON_ERROR_STOP on
SET search_path TO masterclass, public;

CREATE INDEX orders_customer_id_idx ON orders (customer_id);
CREATE INDEX orders_status_date_idx ON orders (order_status, order_date);
CREATE INDEX order_items_order_id_idx ON order_items (order_id);
CREATE INDEX order_items_product_id_idx ON order_items (product_id);
