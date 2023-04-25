-- GROUP BY

SELECT * FROM users;
SELECT * FROM users WHERE birth_place = "日本";
SELECT age,COUNT(*) FROM users WHERE birth_place = "日本"
GROUP BY age;

SELECT age,COUNT(*),MAX(birth_day),MIN(birth_day) FROM users WHERE birth_place = "日本"
GROUP BY age;

SELECT age,COUNT(*),MAX(birth_day),MIN(birth_day) FROM users WHERE birth_place = "日本"
GROUP BY age
ORDER BY COUNT(*);

SELECT * FROM employees;
SELECT department,SUM(salary),FLOOR(AVG(salary)),MIN(salary) FROM employees
GROUP BY department;

SELECT department,SUM(salary),FLOOR(AVG(salary)),MIN(salary) FROM employees
WHERE age > 40
GROUP BY department;

SELECT * FROM users;

SELECT 
CASE 
		WHEN birth_place ="日本" THEN "日本人"
		ELSE "その他"
	END,
	COUNT(*)
FROM users
GROUP BY 
	CASE 
		WHEN birth_place ="日本" THEN "日本人"
		ELSE "その他"
	END;
	

SELECT 
CASE 
		WHEN birth_place ="日本" THEN "日本人"
		ELSE "その他"
	END AS "国籍",
	COUNT(*),
	MAX(age)
FROM users
GROUP BY 
	CASE 
		WHEN birth_place ="日本" THEN "日本人"
		ELSE "その他"
	END;
	
SELECT
	case 
	WHEN name IN ("香川県","高知県","愛媛県","徳島県") THEN "四国"
	ELSE "その他"
END AS "地域名",
COUNT(*)
FROM 
	prefectures
GROUP BY
case 
	WHEN name IN ("香川県","高知県","愛媛県","徳島県") THEN "四国"
	ELSE "その他"
END;

-- CASE
SELECT
	age,
	CASE
		WHEN age < 20 THEN "未成年"
		ELSE "成人"
		END AS "分類",
		COUNT(*)
	FROM users
	GROUP BY age 
	;