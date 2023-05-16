USE day_10_14_db;
SHOW TABLES ;

SELECT *  FROM stores;

SELECT *  FROM stores AS st
INNER JOIN items AS it
ON it.store_id = st.id;

-- View を作成
CREATE VIEW stores_items_view AS
SELECT st.name AS store_name,it.name AS item_name FROM stores AS st
INNER JOIN items AS it
ON it.store_id = st.id;

SELECT * FROM stores_itemes_view ;

UPDATE  items SET name ="new Item 山田1" WHERE name = "Item 山田 1";

-- TABLE と View の一覧を取得する
SHOW TABLES;
SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_SCHEMA="day_10_14_db";

-- View の詳細を確認することができる
SHOW CREATE VIEW stores_itemes_view;

/*
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` 
SQL SECURITY DEFINER VIEW `stores_itemes_view` AS 
select `st`.`name` AS `store_name`,`it`.`name` AS `item_name` 
from (`stores` `st` join `items` `it` on((`it`.`store_id` = `st`.`id`)))
*/

-- 絞り込み
SELECT * FROM stores_itemes_view where  store_name = "山田商店";

SELECT * FROM stores_itemes_view where  id = 10;

SELECT * FROM stores_itemes_view ORDER BY store_name;


SELECT store_name,COUNT(*) FROM stores_itemes_view GROUP BY store_name ORDER BY store_name;

-- View の削除
DROP VIEW stores_itemes_view;

-- View の定義変更
ALTER VIEW stores_items_view AS
SELECT st.id AS store_id,it.id AS item_id,st.name AS store_name,it.name AS item_name FROM stores AS st
INNER JOIN items AS it
ON it.store_id = st.id;

SELECT * FROM stores_items_view;

-- View の名前変更
RENAME TABLE stores_items_view TO new_stores_items_view;

SHOW Tables;




CREATE VIEW AS
SELECT 
* 
FROM new_sotres_items_view
INNER