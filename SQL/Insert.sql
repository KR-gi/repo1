select database();

# テーブル作成
create table people (
	id int primary key,
	name varchar(50),
	birth_day date default "1990-01-01"
);

#INSERT 1
insert into people values(1,"Taro", "2001-01-01");

#SELECT
select*from people ;

# INSERT カラム指定 ※ 誕生日は default が入る
insert into people (id,name) VALUES(2,"Jiro");

#シングルクォート
insert into people (id,name) values (3,'Sabro');

insert into people values (4,'John''s son', '2021-01-01');

insert into people values (5,'John"s son', '2021-01-01');
# "の中に"
insert into people values (6,"John""s son", '2021-01-01');