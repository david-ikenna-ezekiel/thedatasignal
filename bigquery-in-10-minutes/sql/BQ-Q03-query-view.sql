-- Replace YOUR_PROJECT_ID. Create product_revenue through Save > Save view first.
SELECT product, order_count, units_sold, revenue_gbp
FROM `YOUR_PROJECT_ID.signal_shop_demo.product_revenue`
ORDER BY revenue_gbp DESC, product;
