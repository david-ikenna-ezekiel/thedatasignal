\set ON_ERROR_STOP on
SET search_path TO masterclass, public;

BEGIN;

-- P1-D01: CREATE TABLE defines columns, data types, and constraints.
CREATE TABLE order_reviews (
    review_id integer PRIMARY KEY,
    order_id integer NOT NULL REFERENCES orders (order_id),
    rating integer NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_text text,
    created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- P1-D02: ALTER TABLE changes the definition of an existing table.
ALTER TABLE order_reviews
ADD COLUMN is_verified boolean NOT NULL DEFAULT false;

-- P1-D03: Inspect the structure created by the DDL statements.
SELECT
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_schema = 'masterclass'
  AND table_name = 'order_reviews'
ORDER BY ordinal_position;

ROLLBACK;
