SELECT * FROM CUSTOMERS;
SELECT * FROM STG_CUSTOMERS;

SELECT * FROM ORDERS;
SELECT * FROM STG_ORDERS;

SELECT * FROM ORDER_ITEMS;
SELECT * FROM STG_ORDER_ITEMS;

SELECT * FROM PRODUCTS;
SELECT * FROM STG_PRODUCTS;

--dbt test detect the product_id not unique---> check the problems
SELECT
    product_id,
    COUNT(*) AS row_count
FROM RAW.stg_products
GROUP BY product_id
HAVING COUNT(*) > 1
ORDER BY row_count DESC; 
Drop view FINANCE_DB.RAW.stg_products;

