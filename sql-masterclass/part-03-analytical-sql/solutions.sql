\set ON_ERROR_STOP on
SET search_path TO masterclass, public;

-- P3-E01 solution
WITH customer_revenue AS (
    SELECT
        c.customer_id,
        c.customer_name,
        c.customer_segment,
        COALESCE(SUM(o.order_total), 0) AS completed_revenue
    FROM customers AS c
    LEFT JOIN orders AS o
        ON o.customer_id = c.customer_id
       AND o.order_status = 'completed'
    GROUP BY
        c.customer_id,
        c.customer_name,
        c.customer_segment
)
SELECT
    customer_name,
    customer_segment,
    completed_revenue,
    DENSE_RANK() OVER (
        PARTITION BY customer_segment
        ORDER BY completed_revenue DESC
    ) AS segment_rank
FROM customer_revenue
ORDER BY
    customer_segment,
    segment_rank,
    customer_name;

-- P3-E02 solution
SELECT
    customer_id,
    order_id,
    order_date,
    order_total,
    ROUND(
        AVG(order_total) OVER (
            PARTITION BY customer_id
            ORDER BY order_date, order_id
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS three_order_moving_average
FROM orders
WHERE order_status = 'completed'
ORDER BY
    customer_id,
    order_date,
    order_id;

-- P3-E03 solution
WITH monthly_revenue AS (
    SELECT
        date_trunc('month', order_date)::date AS revenue_month,
        SUM(order_total) AS completed_revenue
    FROM orders
    WHERE order_status = 'completed'
    GROUP BY date_trunc('month', order_date)::date
),
with_previous_month AS (
    SELECT
        revenue_month,
        completed_revenue,
        LAG(completed_revenue) OVER (
            ORDER BY revenue_month
        ) AS previous_month_revenue
    FROM monthly_revenue
)
SELECT
    revenue_month,
    completed_revenue,
    previous_month_revenue,
    completed_revenue - previous_month_revenue AS revenue_change
FROM with_previous_month
ORDER BY revenue_month;
