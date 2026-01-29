DROP TABLE IF EXISTS fact_orders;


CREATE TABLE fact_orders AS
SELECT
    o.order_id,
    c.customer_id,
    c.customer_state,
    o.order_purchase_timestamp AS date,
    o.order_delivered_customer_date,
    SUM(oi.price + oi.freight_value) AS order_revenue,
    SUM(p.payment_value) AS total_paid,
    GROUP_CONCAT(DISTINCT p.payment_type) AS payment_types
FROM olist_orders_dataset AS o
INNER JOIN olist_customers_dataset AS c
    ON o.customer_id = c.customer_id
INNER JOIN olist_order_items_dataset AS oi
    ON o.order_id = oi.order_id
LEFT JOIN olist_order_payments_dataset AS p
    ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY
    o.order_id,
    c.customer_id,
    c.customer_state,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date;