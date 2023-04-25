# LENGTH,CHAR_LENGTH

SELECT LENGTH ("ABC");
SELECT LENGTH ("あいう"); -- 9バイト数

SELECT name,LENGTH (name) FROM users;

SELECT CHAR_LENGTH ("ABC");
SELECT CHAR_LENGTH ("あいう") AS Length ; -- 3文字数

SELECT name,CHAR_LENGTH (name) FROM users;

-- TRIM,LTRIM,RTRIM 空白を削除する

SELECT LTRIM ("  ABC  ");
SELECT RTRIM ("  ABC  ");
SELECT TRIM("  ABC  ") ; 

SELECT * FROM employees WHERE CHAR_LENGTH (name) <> CHAR_LENGTH (TRIM(name));

SELECT name,char_length(name) as name_length from  
employees 
WHERE CHAR_LENGTH (name) <> CHAR_LENGTH (TRIM(name));


-- update して空白を削除したものにする
UPDATE employees 
SET name = TRIM(name)
WHERE CHAR_LENGTH (name) <> CHAR_LENGTH (TRIM(name));

-- REPLACE : 置換
SELECT REPLACE ("I like an apple","apple","lemon");

SELECT REPLACE (name,"Mrs","Ms") FROM users WHERE name LIKE "Mrs%";

UPDATE users SET name =  REPLACE (name,"Mrs","Ms") WHERE name LIKE "Mrs%";

select *FROM users;


-- UPPER LOWER(大文字、小文字にする関数)
SELECT UPPER ("apple");
SELECT LOWER ("APPLE");

SELECT name,UPPER(name),LOWER(name) FROM users;

-- SUBSTRING ー部取り出し
SELECT SUBSTRING(name,2,3),name FROM employees ;

SELECT *FROM employees WHERE SUBSTR(name,2,1) = "田";

-- REVERSE : 逆順にする
SELECT REVERSE (name),name from employees;


