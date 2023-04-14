SHOW DATABASES;

CREATE DATABASE by_db;

SHOW DATABASES;/*DB 一覧を表示します*/

#DBの削除
DROP DATABASE by_db;

# performance_schema を利用
USE performance_schema;

# 利用中の DB の表示
SELECT DATABASE();

CREATE DATABASE my_db;

USE  my_db;