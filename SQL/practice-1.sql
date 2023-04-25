select database();
use day_4_9_db;
SHOW TABLES;

-- select*from customers where age > 28;

SELECT
name,age
from customers 
where age >=28 AND age <=40 AND name LIKE "%子" 
ORDER BY age DESC
LIMIT 5;

show tables;
select * from receipts;
-- テーブル定義の確認
describe receipts;

-- INSERT INTO receipts (customer_id,store_name,price) VALUES (100,"Store X",10000);
INSERT INTO receipts VALUES (301,100,"Store X",10000);

-- receipts テーブルの id を降順で 10 表示
SELECT*FROM receipts ORDER BY id DESC LIMIT 10;