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

DELETE FROM receipts WHERE id = 301;

describe prefectures;
select * from prefectures;

SELECT*FROM prefectures WHERE name ="";
SELECT*FROM prefectures WHERE name IS NULL ;

DELETE FROM  prefectures WHERE name IS NULL OR name ="";
-- 5
SELECT*FROM customers WHERE id between 20 AND 50;
SELECT*,age +1 FROM customers WHERE id between 20 AND 50;
UPDATE customers SET age =age + 1 WHERE id between 20 AND 50;

-- 6 
SELECT*FROM students WHERE class_no = 6;
SELECT FLOOR (RAND() * 4)+1; -- 1 ～ 5 の整数

UPDATE students SET class_no = FLOOR (RAND() * 10) WHERE class_no = 6;

SELECT*FROM students;
