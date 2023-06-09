use day_10_14_db;
SHOW TABLES;

-- 1
SELECT *FROM employees WHERE id > 10;
SELECT * FROM customers WHERE id > 10;
first_name,last_name,age

SELECT first_name,last_name,age From employees wHERE id >10
UNION
SELECT first_name,last_name,age From employees wHERE id >10;

-- 2
SELECT * FROM departments;
SELECT * FROM employees; 
SELECT * FROM salaries;

SELECT MAX(payment),MIN(payment),AVG(payment),SUM(payment)
FROM salaries AS sa
INNER JOIN employees AS emp
ON sa.employee_id = emp.id 
INNER JOIN departments AS dt 
ON emp.department_id  = dt.id 
WHERE dt.name = "営業部";

-- 3
SELECT*FROM classes;
SELECT*FROM enrollments;
SELECT *FROM students;

SELECT id,name  FROM classes WHERE id >4;
SELECT id,name  FROM classes WHERE id <5;

INNER JOIN enrollments AS en
ON en.student.id = st.id
-- 
SELECT 
* 
FROM classes AS cls 
INNER JOIN enrollments AS  enr 
ON cls.id = enr.class_id ;

-- 次の手段
 SELECT 
* 
FROM classes AS cls 
INNER JOIN enrollments AS  enr 
ON cls.id = enr.class_id 
INNER JOIN students AS std 
ON enr.student_id = std.id;

-- 次の手段
 SELECT 
CASE 
		WHEN cls.id <5 THEN "クラス1"
		ELSE "クラス2"
END AS "クラス分類",
COUNT(std.id)
FROM classes AS cls 
INNER JOIN enrollments AS  enr 
ON cls.id = enr.class_id 
INNER JOIN students AS std 
ON enr.student_id = std.id
GROUP by 
CASE 
		WHEN cls.id <5 THEN "クラス1"
		ELSE "クラス2"
END;

-- 4 
SELECT*from  employees;
SELECT*from  salaries;
SELECT
*
from  employees AS emp
INNER JOIN salaries AS sa 
ON emp.id = sa.employee_id;

AVG(sa.payment)

SELECT
emp.id,SUM(sa.payment),AVG(sa.payment),age
from  employees AS emp
INNER JOIN salaries AS sa
	ON emp.id = sa.employee_id
WHERE emp.age < 40
GROUP BY emp.id
HAVING AVG(sa.payment) > 7000000;

/* 5. customer毎に、order_amountの合計値を計算してください。
customersテーブルとordersテーブルは、idカラムとcustomer_idカラムで紐づけができます
ordersテーブルのorder_amountの合計値を取得します。
SELECTの対象カラムに副問い合わせを用いて値を取得してください。*/

select * from customers;
SELECT  orders;

SELECT 
*,
(SELECT  SUM(order_amount) FROM orders AS od
WHERE od.customer_id = cst.id)AS sum_order_amount
FROM customers AS cst;

/*6. customersテーブルからlast_nameに田がつくレコード、
ordersテーブルからorder_dateが2020-12-01以上のレコード、
storesテーブルからnameが山田商店のレコード同士を連結します
customersとorders, ordersとitems, itemsとstoresが紐づきます。
first_nameとlast_nameの値を連結(CONCAT)して集計(GROUP BY)し、そのレコード数をCOUNTしてください。*/

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM items;
SELECT * FROM stores;

SELECT 
* 
FROM 
customers AS ct
INNER JOIN orders AS od 
ON ct.id = od.customer_id 
INNER JOIN items AS items
ON od.item_id = items.id
INNER JOIN stores AS st
ON items.store_id = st.id;

SELECT
CONCAT (customers.last_name ,customers.first_name ),COUNT(*)
FROM 
(SELECT* FROM customers  WHERE last_name LIKE "%田%"
) AS customers
INNER JOIN (SELECT*FROM orders WHERE order_date >= "2020-12-01") AS orders
ON customers.id = orders.customer_id
INNER JOIN items 
ON orders.item_id = items.id
INNER JOIN (SELECT * FROM stores WHERE name = "山田商店") AS stores
ON stores.id = items.store_id
GROUP BY CONCAT (customers.last_name ,customers.first_name );

/*7. salariesのpaymentが9,000,000よりも大きいものが存在するレコードを、employeesテーブルから取り出してください。
employeesテーブルとsalariesテーブルを紐づけます。
EXISTSとINとINNER JOIN、それぞれの方法で記載してください*/
SELECT * from employees 
WHERE id IN (SELECT employee_id FROM salaries WHERE payment > 9000000);

SELECT DISTINCT emp.* FROM employees AS emp
INNER JOIN salaries AS sa 
ON emp.id = sa.employee_id
WHERE sa.payment > 9000000;

SELECT* FROM employees AS emp
WHERE 
	EXISTS (
		SELECT 
		1
		FROM
			salaries AS sa
			WHERE emp.id=sa.employee_id AND sa.payment > 9000000
);

/*8. employeesテーブルから、salariesテーブルと紐づけのできないレコードを取り出してください。
EXISTSとINとLEFT JOIN、それぞれの方法で記載してください*/
SELECT * 
FROM employees 
WHERE id NOT IN (SELECT employee_id FROM salaries);

SELECT * FROM employees AS emp
LEFT JOIN salaries AS sa
ON emp.id = sa.employee_id
WHERE sa.id IS NULL;

SELECT * FROM employees AS emp
WHERE 
	NOT EXISTS (
		select 
		1
		FROM 
			salaries AS sa 
			WHERE sa.employee_id = emp.id
	);


	

/*9. employeesテーブルとcustomersテーブルのage同士を比較します
customersテーブルの最小age, 平均age, 最大ageとemployeesテーブルのageを比較して、
employeesテーブルのageが、最小age未満のものは最小未満、最小age以上で平均age未満のものは平均未満、
平均age以上で最大age未満のものは最大未満、それ以外はその他と表示します
WITH句を用いて記述します*/

WITH customers_age AS(
	SELECT MAX(age) AS max_age,MIN(age) AS min_age,AVG(age) AS avg_age
	FROM customers 
	)
	SELECT
	*,
	CASE 
		WHEN emp.age < ca.min_age THEN "最小未満"
		WHEN emp.age < ca.avg_age THEN "平均未満"
		WHEN emp.age < ca.max_age THEN "最大未満"
		ELSE "その他"
	END AS "customers との比較"
	FROM 
		employees AS emp
		CROSS JOIN customers_age AS ca;
	
	
/*10. customersテーブルからageが50よりも大きいレコードを取り出して、ordersテーブルと連結します。
customersテーブルのidに対して、ordersテーブルのorder_amount*order_priceのorder_date毎の合計値。
合計値の7日間平均値、合計値の15日平均値、合計値の30日平均値を計算します。
7日間平均、15日平均値、30日平均値が計算できない区間(対象よりも前の日付のデータが十分にない区間)は、空白を表示してください。*/

WITH tmp_customers AS(
	SELECT 
		*	
	 FROM 
	 	customers 
	 	 WHERE 
	 	 age > 50 
),tmp_customers_orders AS(
	SELECT 
		tc.id,od.order_date,SUM(od.order_amount*od.order_price) AS payment,
		ROW_NUMBER()OVER(PARTITION BY tc.id ORDER BY od.order_date)AS row_num
	FROM tmp_customers AS tc
	INNER JOIN orders AS od
	ON tc.id = od.customer_id 
	GROUP BY tc.id,od.order_date 
)	
SELECT id,order_date,payment,
CASE
	WHEN row_num <7 THEN ""
	ELSE AVG(payment) OVER(PARTITION BY id ORDER BY order_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) 
END AS "7日間平均",
CASE 
	WHEN row_num < 15 THEN""
	ELSE AVG(payment) OVER(PARTITION BY id ORDER BY order_date ROWS BETWEEN 13 PRECEDING AND CURRENT ROW) 
END AS "15日間平均",
CASE 
	WHEN row_num < 30 THEN""
	ELSE AVG(payment) OVER(PARTITION BY id ORDER BY order_date ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) 
END AS "30日間平均"
FROM tmp_customers_orders;



	
	
	