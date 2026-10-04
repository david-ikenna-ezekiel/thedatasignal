-- Replace YOUR_PROJECT_ID, then save this SELECT as the product_revenue view.
SELECT
  product,
  COUNT(*) AS order_count,
  SUM(quantity) AS units_sold,
  SUM(quantity * unit_price) AS revenue_gbp
FROM `YOUR_PROJECT_ID.signal_shop_demo.orders`
WHERE status = 'completed'
GROUP BY product
ORDER BY revenue_gbp DESC, product;
