USE day_10_14_db;
SHOW TABLES;

SELECT * FROM employees;

-- WINDOW 関数
SELECT*,AVG(age) OVER()
FROM employees;

SELECT*,AVG(age) OVER(),COUNT(*) OVER()
FROM employees;

-- PARTITION : 分割してその中で集計する。
SELECT*,AVG(age) OVER(PARTITION BY department_id)AS avg_age,
COUNT(*) OVER (PARTITION BY department_id) AS count_department
FROM employees;

SELECT DISTINCT CONCAT (COUNT(*) OVER(PARTITION BY FLOOR(age/10)) ,"人")AS age_count,FLOOR(age/10)*10
FROM employees;

SELECT *,SUM(order_amount*order_price) OVER(PARTITION BY order_date)
FROM orders;

SELECT *,SUM(order_amount*order_price) OVER(PARTITION BY DATE_FORMAT (order_date,"%y/%m"))
FROM orders;

SELECT *,DATE_FORMAT (order_date,"%y/%m"),
SUM(order_amount*order_price) OVER(PARTITION BY DATE_FORMAT (order_date,"%y/%m"))
FROM orders;

-- ORDER BY
SELECT
*,
COUNT(*)OVER () AS tmp_count
FROM employees;

SELECT
*,
COUNT(*)OVER (ORDER BY age) AS tmp_count
FROM employees;

SELECT *,SUM(order_price) OVER(ORDER BY order_date ,customer_id ) FROM orders;

SELECT
FLOOR(age/10),
COUNT(*)OVER(ORDER BY FLOOR(age/10))
FROM employees;


-- PARTITION BY + ORDER BY
SELECT * FROM employees;

SELECT*,
COUNT(*)OVER(PARTITION BY department_id ORDER BY age) AS count_value
FROM employees;

SELECT*,
MAX(age)OVER(PARTITION BY department_id ORDER BY age) AS count_value
FROM employees;

SELECT*,
MIN(age)OVER(PARTITION BY department_id ORDER BY age) AS count_value
FROM employees;

-- 人ごとの、最大の収入
SELECT
*,
MAX(payment) OVER (PARTITION BY emp.id)
FROM employees AS emp
INNER JOIN salaries AS sa
ON emp.id = sa.employee_id;

-- 月ごとの、合計を employees の ID で昇順に並び替える
SELECT
*,
SUM(sa.payment) OVER (PARTITION BY sa.paid_date ORDER BY emp.id)
FROM employees AS emp
INNER JOIN salaries AS sa
ON emp.id = sa.employee_id;

-- sales テーブルの order_price * order_amount の合計値の 7 日間の平均を求める
SELECT *FROM orders ;
SELECT *,SUM(order_price*order_amount) OVER(ORDER BY order_date) FROM orders ;

SELECT *,
SUM(order_price*order_amount) 
OVER(ORDER BY order_date ROWS  BETWEEN 6 PRECEDING AND CURRENT ROW)
FROM orders ;

-- まずは日付ごとの合計値を求める
-- 7 日平均を求める

WITH dairy_summary AS(
SELECT 
	order_date,SUM(order_price*order_amount) AS sale
FROM
	orders
GROUP BY order_date
)
SELECT
	*,
	AVG(sale) OVER(ORDER BY order_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) -- 6 行前から現在の行まで
FROM
	dairy_summary;

SELECT
 	employee_id,
 	SUM(payment) AS payment
FROM salaries
 	GROUP BY employee_id;
 
SELECT
*
FROM employees AS emp
INNER JOIN 
(SELECT 
	employee_id,
	SUM(payment) AS payment
 FROM salaries
		GROUP BY employee_id ) AS summary_salary
ON emp.id = summary_salary.employee_id;



SELECT
*,
SUM(summary_salary.payment)
OVER(ORDER BY age RANGE BETWEEN 3 PRECEDING AND CURRENT ROW) AS p_summary
FROM employees AS emp
INNER JOIN 
(SELECT 
	employee_id,
	SUM(payment) AS payment
 FROM salaries
		GROUP BY employee_id ) AS summary_salary
ON emp.id = summary_salary.employee_id;

-- ROW NUMBER,RANK,DENSE_RANK

SELECT*FROM employees;

SELECT
*,
ROW_NUMBER()OVER(ORDER BY age) AS row_num,
RANK()OVER(ORDER BY age) AS row_rank,
DENSE_RANK()OVER(ORDER BY age) AS row_dense
FROM employees;

-- CUME_DIST,PERCENT_RANK
SELECT
age,
RANK()OVER(ORDER BY age) AS row_rank,
COUNT(*) OVER() AS cnt, -- 行数
PERCENT_RANK() OVER(ORDER BY age) AS p_age, -- (RANK-1) / (行数-1)
CUME_DIST() OVER(ORDER BY age) AS c_age -- 現在の行の値より小さい行の割合
FROM employees;

-- LAG,LEAD
SELECT 
age,
LAG(age)OVER(ORDER BY age), -- 直前の値
LAG(age,3,0) OVER(ORDER BY age), -- 3 つ前、ない場合は0
LEAD(age) OVER(ORDER BY age), -- 直後
LEAD(age,2,0)OVER(ORDER BY age) -- 2 つ後、ない場合は0
FROM customers;

-- FIRST_VALUE,LAST_VALUE
SELECT 
*,
FIRST_VALUE(first_name) OVER(PARTITION BY department_id ORDER BY age),
LAST_VALUE(first_name) OVER(PARTITION BY department_id ORDER BY age RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM employees;

-- NTILE
SELECT 
age,
NTILE(10)OVER(ORDER BY age) 
FROM
employees;

-- WHERE 句は使えない (エラーとなる)
SELECT 
age,
NTILE(10)OVER(ORDER BY age) 
FROM
employees
where 
NTILE(10)OVER(ORDER BY age) = 8
;

-- 副問い合わせにすることで可能
SELECT 
* FROM 
(SELECT
age,
NTILE(10)OVER(ORDER BY age)  AS ntile_value
FROM
employees) AS tmp
WHERE 
tmp.ntile_value = 8
;