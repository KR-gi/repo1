SELECT DATABASE();

SELECT * FROM users;

SELECT 
	*,
	CASE birth_place
		WHEN "日本" THEN "日本人"
	-- 条件追加
		WHEN "Iraq" THEN "イラク人"
		ELSE "外国人"
	END AS "国籍"
FROM
	users
WHERE id >30;

SELECT * FROM prefectures;

SELECT 
	name,
	CASE 
		WHEN name IN ("香川県","愛媛県","徳島県","高知県") THEN "四国"
		WHEN name IN ("兵庫県","大阪府","京都府","滋賀県","奈良県","三重県","和歌山県") THEN "近畿"
		ELSE "その他"
	END AS "地域名"
FROM
	prefectures;


-- 計算(うるう年、4 の余りが 0 で 100のあまりが 0 ではない年)｛4 ％ = 0,100 の余り != 0｝
SELECT
	name,
	birth_day,
	case 
		WHEN DATE_FORMAT(birth_day,"%Y") % 4 =0 AND DATE_FORMAT (birth_day,"%Y") %100<>0  THEN "うるう年"
		ELSE "うるう年でない"
	END AS "うるう年か"
FROM users;

SELECT
 *,
	CASE 
		WHEN student_id % 3 = 0 THEN test_score_1
		WHEN student_id % 3 = 1 THEN test_score_2
		WHEN student_id % 3 = 2 THEN test_score_3
END aS score
FROM tests_score ;


-- ORDER BY に case 
SELECT * from  prefectures;

SELECT *,
CASE
	WHEN name IN ("香川県","愛媛県","徳島県","高知県") THEN "四国"
	WHEN name IN ("兵庫県","大阪府","京都府","滋賀県","奈良県","三重県","和歌山県") THEN "近畿"
	ELSE "その他" END AS "地域名"
FROM  prefectures
ORDER BY
CASE
	WHEN name IN ("香川県","愛媛県","徳島県","高知県") THEN "四国"
	WHEN name IN ("兵庫県","大阪府","京都府","滋賀県","奈良県","三重県","和歌山県") THEN "近畿"
	ELSE "その他"
END;

-- 上記構文の降順にしたい場合(DESC)

SELECT *,
CASE
	WHEN name IN ("香川県","愛媛県","徳島県","高知県") THEN "四国"
	WHEN name IN ("兵庫県","大阪府","京都府","滋賀県","奈良県","三重県","和歌山県") THEN "近畿"
	ELSE "その他" END AS "地域名"
FROM  prefectures
ORDER BY
CASE
	WHEN name IN ("香川県","愛媛県","徳島県","高知県") THEN "四国"
	WHEN name IN ("兵庫県","大阪府","京都府","滋賀県","奈良県","三重県","和歌山県") THEN "近畿"
	ELSE "その他"
END DESC;


SELECT *,
CASE
	WHEN name IN ("香川県","愛媛県","徳島県","高知県") THEN "四国"
	WHEN name IN ("兵庫県","大阪府","京都府","滋賀県","奈良県","三重県","和歌山県") THEN "近畿"
	ELSE "その他" END AS "地域名"
FROM  prefectures
ORDER BY
CASE
	WHEN name IN ("香川県","愛媛県","徳島県","高知県") THEN 0 -- 
	WHEN name IN ("兵庫県","大阪府","京都府","滋賀県","奈良県","三重県","和歌山県") THEN 1
	ELSE 2
END ;



-- UPDATE + CASE
SELECT*FROM users;

ALTER TABLE users ADD birth_era VARCHAR(2) AFTER birth_day;

SELECT*,
case 
	WHEN birth_day < "1989-01-07" THEN "昭和"
	WHEN birth_day < "1919-05-01" THEN "平成"
	WHEN birth_day <= "2019-05-01" THEN "令和"
	ELSE "不明"
	END AS "元号"
FROM users;

UPDATE users
SET birth_era = case 
	WHEN birth_day < "1989-01-07" THEN "昭和"
	WHEN birth_day < "1919-05-01" THEN "平成"
	WHEN birth_day <= "2019-05-01" THEN "令和"
	ELSE "不明"
	END 

SELECT * FROM users;


-- NULL を使う場合
-- 以下がダメな例
SELECT* FROM customers;
SELECT* FROM customers WHERE name is NULL;

SELECT*,
	CASE name
		WHEN NULL THEN "不明"
		ELSE ""
		END AS "NULL CHAEK"
FROM customers WHERE name IS NULL;


SELECT* FROM customers;
SELECT* FROM customers WHERE name is NULL;

-- 以下が正しい例
SELECT*,
	CASE 
		WHEN name IS NULL THEN "不明"
		WHEN name IS NOT NULL THEN "	NULL以外"
		ELSE ""
		END AS "NULL CHAEK"
FROM customers; -- WHERE name IS NULL;
