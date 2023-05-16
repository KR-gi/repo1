USE day_10_14_db;
SHOW TABLES;

-- バインド変数
SET @customer_id=6;
SELECT * FROM customers WHERE id = @customer_id;