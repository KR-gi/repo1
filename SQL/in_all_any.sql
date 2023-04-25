-- IN
show databases;
USE day_4_9_db;


select*from users where age in (12,24,36);

select*from users where birth_place  not in ("France","Germany","Italy");

-- SELECT 
SELECT * FROM receipts;
SELECT customer_id FROM receipts;

-- SELECT + IN
select*from customers where id in ( select customer_id from receipts);

select*from customers where id in ( select customer_id from receipts where id < 10);

-- ALL,ANY

select*from employees ;
select*from employees where salary > 5000000 ; 

select age from employees where salary > 5000000 ; 

select*from users where age > ALL (select age from employees where salary > 5000000) ; 

select*from users where age > ANY (select age from employees where salary > 5000000) ; 

-- AND,OR

SELECT*FROM employees;

SELECT*FROM employees WHERE department = " 営業部 " AND name LIKE "%田%" AND age < 35;

SELECT*FROM employees WHERE department = " 営業部 " AND (name LIKE "%田%" OR name LIKE "%西%") AND age < 35;

-- 下は同じ値が取得できる
SELECT*FROM employees WHERE department = " 営業部 " OR  department = " 開発部 ";
SELECT*FROM employees WHERE department  IN (" 営業部 " ," 開発部 "); -- こちらのほうがスマート

-- NOT
select *from  employees e  where NOT  department  = " 営業部 ";

