SHOW DATABASES;

USE day_15_18_db;

SHOW TABLES;
SELECT * FROM employees;

DESCRIBE employees;

ALTER TABLE employees ADD CONSTRAINT uniq_employees_name UNIQUE(name);
# 上記実行時に、Taro という name が重複しているためエラーとなる
# 下記で、値を変更し再度上記実行
UPDATE employees SET name = "Jiro" WHERE employee_code = "00000002";

-- UNIQUE の追加
ALTER TABLE employees ADD CONSTRAINT uniq_employees_name UNIQUE(name);

DESCRIBE employees;
# Key に UNI と記載されていれば、UNIQUE 制約

# 制約一覧の確認
SELECT * FROM 
information_schema.key_column_usage # 固定の構文
WHERE 
	table_name = "employees";
	
# UNIQUE 制約の削除
ALTER TABLE employees DROP CONSTRAINT uniq_employees_name;

-- UNIQUE の追加(name と age に対して設定)
ALTER TABLE employees ADD CONSTRAINT uniq_employees_name_age UNIQUE(name,age);

SELECT * FROM employees;
INSERT INTO employees VALUES (2,"00000003","Taro",19);

-- 対象のテーブルに対して、CREATE されたものを確認できる
SHOW CREATE TABLE employees;

-- DEFAULT 追加
SELECT * FROM customers;

SHOW CREATE TABLE customers;
-- CHECK 制約の削除
ALTER TABLE customers DROP CONSTRAINT customers_chk_1;

DESCRIBE customers;

-- Default の追加
ALTER TABLE customers
ALTER age SET DEFAULT 20;

INSERT INTO customers (id,name) VALUES(2,"Jiro");

SELECT * FROM customers;

-- NOT NULL の追加
ALTER TABLE customers MODIFY name VARCHAR(255) NOT NULL;

INSERT INTO customers (id,name) VALUES (3,NULL);

-- CHECK 制約を追加する
-- すでに age が 20 以下の値が入っているため以下の構文はエラーとなる
ALTER TABLE customers ADD CONSTRAINT check_age CHECK(age>20);

ALTER TABLE customers ADD CONSTRAINT check_age CHECK(age>=20);


DESCRIBE customers;
-- 主キーの削除
ALTER TABLE customers DROP PRIMARY KEY;

-- 主キーの追加
ALTER TABLE customers 
ADD CONSTRAINT pk_customers PRIMARY KEY (id);

DESCRIBE customers;

-- 外部キー
DESCRIBE students;

SHOW CREATE TABLE students;

ALTER TABLE students DROP CONSTRAINT students_ibfk_1;

ALTER TABLE students 
ADD CONSTRAINT fk_schools_students
FOREIGN KEY (school_id) REFERENCES schools(id);

SHOW CREATE TABLE students;

-- AUTO_INCREMENT
CREATE TABLE animals(
	id INT PRIMARY KEY AUTO_INCREMENT COMMENT "主キーのID(INT型)です",
	name VARCHAR(50) NOT NULL COMMENT "動物の名前です"
);
-- COMMENT の確認
SHOW FULL COLUMNS FROM animals;

INSERT INTO animals VALUES(NULL,"Dog");
SELECT * FROM animals;

INSERT INTO animals (name) VALUES("Cat");

-- 自動で付与される値の確認
SELECT AUTO_INCREMENT FROM information_schema.tables WHERE TABLE_NAME="animals";

-- 直接値を入れる
INSERT INTO animals VALUES(4,"Panda");

SELECT * FROM animals;

INSERT INTO animals VALUES (NULL,"Fish");

ALTER TABLE animals AUTO_INCREMENT = 100;

INSERT INTO animals VALUES (NULL,"Bird");

SELECT * FROM animals;

SELECT "Snake"
UNION ALL
SELECT "Dino"
UNION ALL
SELECT"GIbra";

INSERT INTO animals(name)
SELECT "Snake"
UNION ALL
SELECT "Dino"
UNION ALL
SELECT"GIbra";

SELECT * FROM animals;

SELECT name FROM animals;

INSERT INTO animals(name)
SELECT name FROM animals;

SELECT *FROM animals;