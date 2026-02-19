DROP TABLE IF EXISTS fact_orders;
DROP TABLE IF EXISTS fact_revenue;
DROP TABLE IF EXISTS fact_paid;
DROP TABLE IF EXISTS fact_orders2;
DROP TABLE IF EXISTS fact_orders3;

--- pruebo dividirlo en 3 tablas


CREATE TABLE fact_revenue AS
SELECT
    o.order_id,
    c.customer_id,
    c.customer_state,
    o.order_purchase_timestamp AS date,
    o.order_delivered_customer_date,
    SUM(oi.price + oi.freight_value) AS order_revenue,
    COUNT(DISTINCT oi.order_item_id) AS number_of_items
FROM olist_orders_dataset AS o
INNER JOIN olist_customers_dataset AS c
    ON o.customer_id = c.customer_id
INNER JOIN olist_order_items_dataset AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY
    o.order_id,
    c.customer_id,
    c.customer_state,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date;


CREATE TABLE fact_paid AS 
SELECT
    o.order_id,
    c.customer_id,
    c.customer_state,
    o.order_purchase_timestamp AS date,
    o.order_delivered_customer_date,
    SUM(p.payment_value) AS total_paid,
    GROUP_CONCAT(DISTINCT p.payment_type) AS payment_types,
    COUNT(DISTINCT p.payment_type) AS payment_types_count
FROM olist_orders_dataset AS o
INNER JOIN olist_customers_dataset AS c
    ON o.customer_id = c.customer_id
LEFT JOIN olist_order_payments_dataset AS p
    ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY
    o.order_id,
    c.customer_id,
    c.customer_state,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date;


CREATE TABLE fact_orders AS
SELECT r.order_id, r.customer_id, r.customer_state, r.date, r.order_delivered_customer_date, r.order_revenue, r.number_of_items, p.total_paid, p.payment_types, p.payment_types_count
FROM fact_revenue AS r
LEFT JOIN fact_paid AS p
    ON r.order_id = p.order_id;




