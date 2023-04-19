-- ROUND,FLOOR,CEILING
use day_4_9_db;

SELECT ROUND (13.14,-1); #四捨五入


SELECT FLOOR (3.14) ; # 切り捨て
SELECT FLOOR (3.84) ;

SELECT CEILING (3.14); # 切り上げ

SELECT RAND(); # ０ ～ 1 
SELECT RAND() * 10; # 0～10

SELECT FLOOR (RAND() * 10); # 整数部分のみに切り捨て

-- POWER
SELECT POWER (3,4);

SELECT*FROM students;
SELECT weight / POWER (height / 100,2) AS BMI FROM students;


-- COALESCE
SELECT*FROM tests_score;

SELECT COALESCE (NULL,NULL,NULL,"A",NULL,"B");
SELECT COALESCE(test_score_1,test_score_2,test_score_3) from tests_score;
SELECT COALESCE(test_score_1,test_score_2,test_score_3),test_score_1,test_score_2,test_score_3  AS  score from tests_score;

