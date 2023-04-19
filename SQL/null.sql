
-- IN + NULL
select *from customers where name is null;
select *from customers where name in ("河野 文典","稲田 季雄") OR name is null;


-- NOT IN
select *from customers where name not in ("河野 文典","稲田 季雄",NULL) ;
-- NOT IN ⇒ () 内の条件のいずれも満たさない場合
-- name != "河野 文典" name != "稲田 季雄" name != NULL
select *from customers where name not in ("河野 文典","稲田 季雄") and name is not NULL; 


-- ALL
select * from customers where id < 10;
-- customers テーブルから id <10 の誕生日よりも古い誕生日の人を users から取り出す SQL
select* from users where birth_day <=ALL (select birth_day  from customers where id < 10 and birth_day is not null); 

-- ALL,IN の場合は NULL に気を付ける
