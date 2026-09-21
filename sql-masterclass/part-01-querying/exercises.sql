\set ON_ERROR_STOP on
SET search_path TO masterclass, public;

-- P1-E01
-- Return completed web orders placed on or after 1 June 2026.
-- Show order_id, order_date, and order_total.
-- Sort from the largest order to the smallest.


-- P1-E02
-- Return every order with a new column called fulfilment_state.
-- Map completed and refunded orders to 'closed'.
-- Map pending orders to 'open'.
-- Map everything else to 'stopped'.


-- P1-E03
-- Return the three cheapest products.
-- Show product_name, category, and list_price.
-- Make the result deterministic when prices tie.
