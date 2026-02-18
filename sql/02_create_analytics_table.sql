DROP TABLE IF EXISTS analytics_orders;

CREATE TABLE analytics_orders AS
SELECT
    order_id,
    customer_id,
    customer_state,
    date,
    total_paid,
    payment_types,
    order_revenue,
    
    CAST(
        julianday(order_delivered_customer_date) -
        julianday(date)
    AS INTEGER) AS delivery_days,

    strftime('%Y-%m', date) AS year_month,
    strftime('%w', date) AS day_of_week,
    strftime('%H', date) AS purchase_hour,
    CAST(strftime('%m', date) AS INTEGER) AS month,

    payment_types_count,
    number_of_items

FROM fact_orders
WHERE total_paid IS NOT NULL;
