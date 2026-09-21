\set ON_ERROR_STOP on
SET search_path TO masterclass, public;

BEGIN;

-- P1-DE01 solution
CREATE TABLE product_tags (
    tag_id integer PRIMARY KEY,
    product_id integer NOT NULL REFERENCES products (product_id),
    tag_name text NOT NULL,
    UNIQUE (product_id, tag_name)
);

-- P1-DE02 solution
ALTER TABLE product_tags
ADD COLUMN created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- P1-DE03 solution
SELECT
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_schema = 'masterclass'
  AND table_name = 'product_tags'
ORDER BY ordinal_position;

ROLLBACK;
