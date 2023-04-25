show databases;
USE day_4_9_db;

SHOW TABLES;

SELECT * FROM users;

-- TRANSACTION
START TRANSACTION;

-- UPDATE処理
UPDATE users SET name="中山 成美" WHERE id = 1;

SELECT * FROM users;

-- ROLLBACK(トランザクション開始前に戻す)
ROLLBACK;

-- COMMIT(トランザクションを DB に反映)
COMMIT;	

-- ROLLBACK
ROLLBACK;

SELECT * FROM students;
-- id が 300 を削除
DELETE FROM students WHERE id =300;

-- AUTOCOMMIT の確認
SHOW VARIABLES WHERE variable_name = "autocommit";
-- AUTOCOMMIT を無効化
SET AUTOCOMMIT=0;

DELETE FROM students WHERE id = 299;

-- SQL の反映
COMMIT;

-- AUTO COMMIT をもとに戻す
SET AUTOCOMMIT= 1;
