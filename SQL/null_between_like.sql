select DATABASE();
describe customers;

-- IS NULL でないと取り出せない
select*from customers where name is null;

select null = null;
select null is null;

-- IS NOT NULL
select*from customers where name is not null;

select*from prefectures;

select*from prefectures where name is null;
select*from prefectures where name ="";


-- BETWEEN (以上、以下),NOT BETWEEN
select*from users where age not between 5 and 10;

-- LIKE、NOT LIKE
select*from users where name like "村%"; -- 前方一致
select*from users where name like "%三郎"; -- 後方一致
select*from users where name like "%ed%"; -- 中間一致

select*from prefectures where name like "福_%" order by name; -- _は任意の ”一文字”