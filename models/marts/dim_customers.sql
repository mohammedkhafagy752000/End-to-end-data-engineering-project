SELECT 
customer_key,
 customer_id,
ZIP_CODE ,
CITY ,
STATE 
FROM {{ ref('stg_customers') }}