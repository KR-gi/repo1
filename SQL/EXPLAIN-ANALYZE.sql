SHOW DATABASES;

CREATE DATABASE day_19_21_db;

USE day_19_21_db;
SHOW taBLES;

-- 統計情報の確認
SELECT * FROM mysql.innodb_table_stats WHERE database_name = "day_19_21_db";

SELECT * FROM prefectures;

INSERT INTO prefectures VALUES("48","不明");

DELETE FROM prefectures WHERE prefecture_code ="48" AND name = "不明";

-- 統計情報の手動更新
ANALYZE TABLE prefectures;

-- 200件
SELECT * FROM customers ;

-- SQL を実行せずに実行計画だけ表示する
EXPLAIN SELECT * FROM customers ;

-- SQL を実行して実行計画を表示する
EXPLAIN ANALYZE SELECT * FROM customers ;

/*
-> Limit: 200 row(s)  (cost=52650.28 rows=200) (actual time=0.097..0.217 rows=200 loops=1)
    -> Table scan on customers  (cost=52650.28 rows=496756) (actual time=0.095..0.208 rows=200 loops=1)
*/

SELECT * FROM customers ;