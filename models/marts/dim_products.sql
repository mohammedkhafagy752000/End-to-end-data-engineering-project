SELECT 
product_key,
product_id,
category,
product_weight_g,
product_length_cm,
product_height_cm,
product_width_cm
FROM {{ ref('stg_products') }}