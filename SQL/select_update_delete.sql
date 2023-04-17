show tables;

#全レコード、全カラムを表示
select*from people;

#カラムの一部を表示(, で区切り順番通り表示される)
select name,id,birth_day,name from people;

select id as "番号",name as "名前" from people;


# WHERE句
select*from  people where id <= 4;
select *from people where name = "Jiro";

# UPDATE 文
update people set birth_day = "1900-01-01",name="";

select*from people;

#UPDATE WHERE
update people set name ="Taro",birth_day ="2000-01-01"where id =3;

update people set name ="Jiro",birth_day ="2000-01-01"where id > 4;

#DERETE :レコード削除
delete from people where id>4;

delete from people;
