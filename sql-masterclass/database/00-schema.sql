\set ON_ERROR_STOP on

DROP SCHEMA IF EXISTS masterclass CASCADE;
CREATE SCHEMA masterclass;
SET search_path TO masterclass, public;

CREATE TABLE customers (
    customer_id integer PRIMARY KEY,
    customer_name text NOT NULL,
    email text NOT NULL UNIQUE,
    country text NOT NULL,
    signup_date date NOT NULL,
    customer_segment text NOT NULL
        CHECK (customer_segment IN ('individual', 'team', 'enterprise')),
    marketing_channel text
);

CREATE TABLE products (
    product_id integer PRIMARY KEY,
    product_name text NOT NULL,
    category text NOT NULL,
    list_price numeric(10, 2) NOT NULL CHECK (list_price >= 0)
);

CREATE TABLE orders (
    order_id integer PRIMARY KEY,
    customer_id integer NOT NULL REFERENCES customers (customer_id),
    order_date date NOT NULL,
    order_status text NOT NULL
        CHECK (order_status IN ('completed', 'pending', 'cancelled', 'refunded')),
    sales_channel text NOT NULL
        CHECK (sales_channel IN ('web', 'mobile', 'marketplace')),
    order_total numeric(12, 2) NOT NULL DEFAULT 0 CHECK (order_total >= 0)
);

CREATE TABLE order_items (
    order_item_id integer PRIMARY KEY,
    order_id integer NOT NULL REFERENCES orders (order_id),
    product_id integer NOT NULL REFERENCES products (product_id),
    quantity integer NOT NULL CHECK (quantity > 0),
    unit_price numeric(10, 2) NOT NULL CHECK (unit_price >= 0),
    UNIQUE (order_id, product_id)
);

COMMENT ON SCHEMA masterclass IS
    'Synthetic Signal Store dataset for the SQL Masterclass in 30 Minutes';
