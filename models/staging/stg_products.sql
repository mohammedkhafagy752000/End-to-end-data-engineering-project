SELECT DISTINCT
ROW_NUMBER() OVER (ORDER BY ID) AS product_key,
ID AS product_id,
CATEGORY AS category,
PRODUCT_WEIGHT_G AS product_weight_g,
PRODUCT_LENGTH_CM AS product_length_cm,
PRODUCT_HEIGHT_CM AS product_height_cm,
PRODUCT_WIDTH_CM AS product_width_cm
FROM {{ source('raw_data', 'PRODUCTS') }}