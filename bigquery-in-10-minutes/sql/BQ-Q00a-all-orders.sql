-- Read the uploaded table. Replace YOUR_PROJECT_ID with your project ID.
SELECT order_id, product, quantity
FROM `YOUR_PROJECT_ID.signal_shop_demo.orders`
ORDER BY order_id;
