SHOW DATABASES;
USE day_15_18_db;

DROP TABLE students;

CREATE TABLE schools(
	id INT PRIMARY KEY,
	name VARCHAR(255)
	);
	
CREATE TABLE students(
	id INT PRIMARY KEY,
	name VARCHAR(255),
	age INT,
	school_id INT,
	FOREIGN KEY(school_id) REFERENCES schools(id)
);
# 以下を実行しても schools の ID に値が入っていないため(school_idに指し示す値がないため)、エラーになる
INSERT INTO students VALUES(1,"Taro",18,1);
# そのため、まず以下の構文によって 値を入れる必要がある
INSERT INTO schools VALUES (1,"北高校");

-- 参照整合性エラーが発生する
UPDATE schools SET id = 2;

-- 参照整合性エラーが発生する
DELETE FROM schools;

-- 参照整合性エラーが発生する
UPDATE students SET school_id = 3;

DESCRIBE employees;

-- 複数のカラムに外部キーを設定する
CREATE TABLE salaries(
	id INT PRIMARY KEY,
	company_id INT,
	employee_code CHAR(8),
	payment INT,
	paid_date DATE,
	FOREIGN KEY (company_id,employee_code) REFERENCES employees(company_id,employee_code)
);

SELECT * FROM employees;
-- 参照整合性エラーが発生する
INSERT INTO salaries VALUES (1,1,"00000003",1000,"2020-01-01");

INSERT INTO salaries VALUES (1,1,"00000001",1000,"2020-01-01");



DESCRIBE students;

DROP TABLE students;
-- ON  DELETE,ON update 
CREATE TABLE students(
	id INT PRIMARY KEY,
	name VARCHAR(255),
	age INT,
	school_id INT,
	FOREIGN KEY(school_id) REFERENCES schools(id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO students VALUES(1,"Taro",18,1);


SELECT * FROM students;

SELECT * FROM schools;
UPDATE schools SET id = 3 WHERE id=1;

DELETE FROM schools;
# 上記実行すると students テーブルの該当の行ごと削除される
SELECT * FROM students;

DROP TABLE students;

-- ON  DELETE,ON update (SET NULL)
CREATE TABLE students(
	id INT PRIMARY KEY,
	name VARCHAR(255),
	age INT,
	school_id INT,
	FOREIGN KEY(school_id) REFERENCES schools(id)
	ON DELETE SET NULL ON UPDATE SET NULL
);

INSERT INTO schools VALUES (1,"北高校");
INSERT INTO students VALUES(1,"Taro",16,1);

SELECT * FROM students;

UPDATE schools SET id=3 WHERE id=1;
SELECT * FROM students;

UPDATE students SET school_id=3 WHERE school_id IS NULL;

INSERT INTO schools VALUES (2,"南高校");
INSERT INTO students VALUES(2,"Taro",16,2);

SELECT * FROM schools;
DELETE FROM schools WHERE id = 3;
SELECT * FROM students;

DROP TABLE students;
-- ON  DELETE,ON update (SET DEFAULT)
CREATE TABLE students(
	id INT PRIMARY KEY,
	name VARCHAR(255),
	age INT,
	school_id INT DEFAULT -1,
	FOREIGN KEY(school_id) REFERENCES schools(id)
	ON DELETE SET DEFAULT ON UPDATE SET DEFAULT
);

SELECT * FROM schools;

INSERT INTO schools VALUES (1,"北高校");

INSERT INTO students VALUES(1,"Taro",17,1);
SELECT* FROM students;

UPDATE schools SET id=3 WHERE id=1;