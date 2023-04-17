USE my_db;

select database();

#テーブル作成

create table users(
    id INT,#idカラムINT型
    name  varchar(10), #名前、可変長文文字列
    age INT,
    phone_number CHAR(13), #固定長
    message TEXT
)

#テーブル一覧を表示
show tables;

# テーブルの定義確認
describe users;

#テーブルの削除
drop table users;

show tables;

#テーブル作成(主キー付き)
create table users(
    id INT PRIMARY KEY,#idカラムINT型
    name  varchar(10), #名前、可変長文文字列
    age INT,
    phone_number CHAR(13), #固定長
    message TEXT
)

DESCRIBE users; 