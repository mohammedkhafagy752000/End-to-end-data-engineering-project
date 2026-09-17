SELECT
    o.order_id,
    c.customer_key,
    p.product_key,
    o.order_status,
    o.order_date,
    oi.price,
    oi.shipping_charges
FROM {{ ref('stg_orders') }} o

LEFT JOIN {{ ref('stg_order_items') }} oi
    ON o.order_id = oi.order_id

LEFT JOIN {{ ref('dim_customers') }} c
    ON o.customer_id = c.customer_id

LEFT JOIN {{ ref('dim_products') }} p
    ON oi.product_id = p.product_id