SELECT 
ID AS order_id,
CUSTOMER_ID AS customer_id,
ORDER_STATUS AS order_status,
ORDER_DATE AS order_date,
ORDER_APPROVED AS order_approved,
ORDER_DELIVERED AS order_delivered,
ORDER_ESTIMATED AS order_estimated
FROM {{ source('raw_data', 'ORDERS') }}