show tables;

describe people;

alter table people ADD age int after name;

insert into  people values(1,"John",18,"2001-01-01");
insert into  people values(2,"Alice",15,"2003-01-01");
insert into  people values(3,"Poul",19,"2000-01-01");
insert into  people values(4,"Chris",17,"2001-01-01");
insert into  people values(5,"Vette",20,"2001-01-01");
insert into  people values(6,"Tshyoshi",21,"2001-01-01");

select *from people;
# age で昇順
select*from people order by age ASC;

# age で降順
select*from people order by age DESC;

# name
select*from people order by name desc;

# 2 つカラム
select*from people order by birth_day desc ,name desc,age asc;

#ASC    :昇順
#DESC : 降順

#DISTINCT
select distinct birth_day from people order by birth_day ;

select distinct name,birth_day from	 people;

#LIMIT は最初の行だけ表示
select id,name,age from  people limit 3;

#飛ばして表示'(3 行飛ばして 2 行表示)
select*from people limit 3,2;
select *from people limit 4 OFFSET 2;