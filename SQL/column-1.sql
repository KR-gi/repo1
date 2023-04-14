use my_db;

SELECT DATABASE();

#テーブル一覧
show tables;

#テーブル名変更
alter table users rename to users_table;

# カラムの確認
describe users_table;
#カラムの削除(DROP COKUMN)
alter table users_table drop column message;

# カラムの追加 (ADD)
alter table users_table 
add post_code CHAR(8);

# カラム age と Phone_number の間にgenderを追加する
alter table users_table
add gender CHAR(1) after age;

# 一番最初のカラムに追加
alter table users_table
ADD new_id INT FIRST;

alter table  users_table drop column new_id;

#カラムの確認
describe users_table;

#カラムの定義変更 name の Type を VARCHAR(50)へ変更
alter table users_table MODIFY name VARCHAR(50);

# カラム名の変更
alter table users_table change column name 名前 varchar(50);

# カラムの場所の移動 gender を最後に持っていく
alter table users_table change column gender gender CHAR(1) after  post_code;

describe users_table;

# 主キーの削除
alter table users_table drop primary key;

describe users_table;
