SHOW DATABASES;
USE day_4_9_db;
SHOW tables;

SELECT*FROM customers WHERE name IS NULL;

-- COUNT
SELECT COUNT(*) FROM customers ; -- 何行データが入っているか
SELECT COUNT(name) FROM customers; -- 列指定(この列に何行入っているか(NULLはカウントしない))
SELECT COUNT(id) FROM customers ; -- 主キーでカウント※主キーを指定したほうが高速な場合がある

SELECT COUNT(name) FROM customers WHERE id > 80;

SELECT*FROM customers;

-- MAX: 最大、MIN:最小
SELECT MAX(age),MIN(age) FROM users WHERE birth_place = "日本";

SELECT MAX(birth_day),MIN(birth_day) FROM users;

-- SUM:合計値
SELECT SUM(salary) FROM employees;

SELECT*FROM employees;

-- AVG: NULLの場合が面倒
SELECT AVG(salary) FROM employees;

CREATE TABLE tmp_count(
 num int
);

SHOW TABLES;
INSERT into tmp_count  VALUES(1);
INSERT into tmp_count  VALUES(2);
INSERT into tmp_count  VALUES(3);
INSERT into tmp_count  VALUES(NULL);

SELECT*FROM tmp_count ;
SELECT AVG(num) FROM tmp_count ;

SELECT AVG(COALESCE(num,0)) FROM tmp_count ;
-- (1+2+3+0) / 4 = 1.5
