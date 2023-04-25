SHOW DATABASES;
CREATE DATABASE day_10_14_db;

USE day_10_14_db;
SHOW TABLES;

-- テーブルに別名を付ける
SELECT
	cs_2.id,
	cs_2.name
FROM
	classes AS cs_2;