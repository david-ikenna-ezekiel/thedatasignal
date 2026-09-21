\set ON_ERROR_STOP on
SET search_path TO masterclass, public;

BEGIN;

-- P1-DE01
-- Create a table named product_tags with:
--   tag_id: integer primary key
--   product_id: required integer referencing products(product_id)
--   tag_name: required text
--   a uniqueness rule for the combination of product_id and tag_name


-- P1-DE02
-- Alter product_tags to add created_at as a required timestamptz column.
-- Give it a default of the current timestamp.


-- P1-DE03
-- Query information_schema.columns to inspect the finished table definition.


ROLLBACK;
