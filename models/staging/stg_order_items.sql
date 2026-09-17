SELECT
ORDER_ID AS order_id,
PRODUCT_ID AS product_id,
SELLER_ID AS seller_id,
PRICE AS price,
SHIPPING_CHARGES AS shipping_charges
FROM {{ source('raw_data', 'ORDER_ITEMS') }}