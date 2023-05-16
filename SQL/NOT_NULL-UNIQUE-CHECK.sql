SHOW DATABASES;

CREATE DATABASE day_15_18_db;

USE day_15_18_db;
SHOW tables;

CREATE TABLE users(
	id INT PRIMARY KEY,
	first_name VARCHAR(255),
	last_name VARCHAR(255) DEFAULT "" NOT NULL
);
INSERT INTO users (id) VALUES(1);
SELECT * FROM users;

CREATE TABLE users_2(
	id INT PRIMARY KEY,
	first_name VARCHAR(255),
	last_name VARCHAR(255)  NOT NULL,
	age INT DEFAULT 0
);
-- NOT NULL だけの場合は、INSERT の際に値を指定しないとエラーとなる
INSERT INTO users_2(id,first_name,last_name ) VALUES (1,"Taro","Yamada");

SELECT * FROM users_2;

INSERT INTO users_2 VALUES(2,"Jiro","Suzuki",NULL);
-- UNIQUE 制約
CREATE TABLE login_users(
	id INT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL UNIQUE
);

INSERT INTO login_users VALUES(1,"Shingo","abc@mail.com");
INSERT INTO login_users VALUES(2,"Shingo","abc@mail.com");

CREATE TABLE tmp_names(
	name VARCHAR(255) UNIQUE);

INSERT INTO tmp_names VALUES(NULL);
	
SELECT * FROM  tmp_names ;

-- CHECK 制約
CREATE TABLE customers(
	id INT PRIMARY KEY,
	name VARCHAR(255),
	age INT CHECK(age > 20)
);

INSERT INTO customers VALUES(1,"Taro",21);
INSERT INTO customers VALUES(1,"Jiro",19); # エラーになる

-- 複数のカラムに対する CHECK 制約
CREATE TABLE students (
	id INT PRIMARY KEY,
	name VARCHAR(255),
	age INT,
	gender CHAR(1),
	CONSTRAINT chk_students CHECK ((age >= 15 AND age <= 20) AND (gender = "F" OR gender = "M"))
	);

INSERT INTO students VALUES (1,"Taro",18,"M");
INSERT INTO students VALUES (2,"Taro",18,"U"); # U は入れれないのでエラーになる
INSERT INTO students VALUES (1,"Sachiko",14,"F"); # 14 はいれれないないのでエラーになる

INSERT INTO students VALUES (NULL,"Jiro",16,"M");

CREATE TABLE employees(
	company_id INT,
	employee_code CHAR(8),
	name VARCHAR(255),
	age INT,
	PRIMARY KEY(company_id,employee_code)
);

INSERT INTO employees VALUES
(1,"00000001","Taro",19);

INSERT INTO employees VALUES
(NULL,"00000001","Taro",19); # 主キーに設定されているとこに NULL はいれれない


INSERT INTO employees VALUES
(1,"00000002","Taro",19);

CREATE TABLE tmp_employees(
	company_id INT,
	employee_code CHAR(8),
	name VARCHAR(255),
	UNIQUE (company_id,employee_code)
);






