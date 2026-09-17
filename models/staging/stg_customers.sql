SELECT 
ROW_NUMBER() OVER ( ORDER BY ID DESC) AS customer_key,
ID AS customer_id,
ZIP_CODE ,
CITY ,
STATE 
FROM {{ source('raw_data', 'CUSTOMERS') }}