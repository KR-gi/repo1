-- 算術演算子

# +,-,*,%

select 1+1;

select  name,age, age +3 as age_3 from users limit 10;

select  10-5;

select age -1 as age_1 from users;

select  birth_day,birth_day+3 from users;

select 3 *5; -- 15

select *from employees;
select department,name,salary,salary*1.1 as salary_next_year from employees;

select department,name,salary,salary*0.9 as salary_next_year from employees;

select 10/3;

select  salary /10 from employees;

select 10%3; -- 1

select age % 12 from users;

-- CONCAT(文字の連結) ||
select  concat(department ,":", name )as "部署：名前" from employees;
select  concat( name,"(",age,")") as "名前(年齢)" from users; 


-- NOW,CURDATE,DATE_FORMAT

select now(); -- 現在時刻
select now( ),3+2,name,age from users;  

select curdate(); -- 日付のみ
select  date_format(now(),"%Y%m%d%h"); -- %Y 年,%m 月,%d 日
 