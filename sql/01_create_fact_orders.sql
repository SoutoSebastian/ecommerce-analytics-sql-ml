DROP TABLE IF EXISTS fact_orders;
DROP TABLE IF EXISTS fact_revenue;
DROP TABLE IF EXISTS fact_paid;
DROP TABLE IF EXISTS fact_orders2;


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

--- pruebo dividirlo en 3 tablas, porque algo anda mal arriba


CREATE TABLE fact_revenue AS
SELECT
    o.order_id,
    c.customer_id,
    c.customer_state,
    o.order_purchase_timestamp AS date,
    o.order_delivered_customer_date,
    SUM(oi.price + oi.freight_value) AS order_revenue
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
    GROUP_CONCAT(DISTINCT p.payment_type) AS payment_types
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


CREATE TABLE fact_orders2 AS
SELECT r.order_id, r.customer_id, r.customer_state, r.date, r.order_delivered_customer_date, r.order_revenue, p.total_paid, p.payment_types
FROM fact_revenue AS r
LEFT JOIN fact_paid AS p
    ON r.order_id = p.order_id;


DROP TABLE IF EXISTS fact_orders3;

CREATE TABLE fact_orders3 AS
WITH items_agg AS (
    SELECT
        order_id,
        SUM(price + freight_value) AS order_revenue
    FROM olist_order_items_dataset
    GROUP BY order_id
),
payments_agg AS (
    SELECT
        order_id,
        SUM(payment_value) AS total_paid,
        GROUP_CONCAT(DISTINCT payment_type) AS payment_types
    FROM olist_order_payments_dataset
    GROUP BY order_id
)
SELECT
    o.order_id,
    c.customer_id,
    c.customer_state,
    o.order_purchase_timestamp AS date,
    o.order_delivered_customer_date,
    i.order_revenue,
    p.total_paid,
    p.payment_types
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
    ON o.customer_id = c.customer_id
JOIN items_agg i
    ON o.order_id = i.order_id
LEFT JOIN payments_agg p
    ON o.order_id = p.order_id
WHERE o.order_status = 'delivered';
