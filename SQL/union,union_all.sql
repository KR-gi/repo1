SHOW DATABASES;
USE day_4_9_db;

SELECT*FROM new_students;
SELECT*FROM students;

-- UNION は重複は削除される
SELECT*FROM new_students
UNION
SELECT*FROM students;
/*
341	堀川 迪子	177	77	5
4	黒沢 敬正	163	74	1
5	中谷 純典	159	62	2
7	吉川 一樹	169	68	4
8	齋藤 保行	181	81	3
 */

SELECT*FROM new_students
UNION
SELECT*FROM students
ORDER BY id;

-- UNION ALL は重複削除をしない
SELECT*FROM new_students ns 
UNION ALL
SELECT*FROM students;


SELECT*FROM new_students ns 
UNION ALL
SELECT*FROM students
ORDER BY id;

SELECT*FROM students WHERE id <10
UNION all 
SELECT*fROM new_students  WHERE id >250;

SELECT id,name FROM students WHERE id < 10
UNION
ORDER BY id;

-- カラムの数が合わないとエラーとなる
SELECT id,name,height FROM students
UNION ALL
SELECT age,name FROM users;

