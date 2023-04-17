-- IN


select*from users where age in (12,24,36);

select*from users where birth_place  not in ("France","Germany","Italy");

-- SELECT + IN
select*from customers where id in ( select customer_id from receipts);

select*from customers where id in ( select customer_id from receipts where id < 10);

-- ALL,ANY

select*from employees ;
select*from employees where salary > 5000000 ; 

select age from employees where salary > 5000000 ; 

select*from users where age > ALL (select age from employees where salary > 5000000) ; 

select*from users where age > ANY (select age from employees where salary > 5000000) ; 