select database();


create table people(
    id int primary key,
    name varchar(50),
    birth_day date default "1990-01-01"
);
describe people;


show tables;
describe users_table;
describe students;

