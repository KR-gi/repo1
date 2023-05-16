USE day_19_21_db;

SELECT COUNT(*) FROM prefectures;

SELECT COUNT(*) FROM customers;

CREATE INDEX idx_customers_prefecture_code ON customers(prefecture_code);

-- prefectures < customers
-- EXISTS
EXPLAIN ANALYZE
SELECT * FROM prefectures AS pr 
WHERE EXISTS (SELECT 1 FROM customers AS ct WHERE pr.prefecture_code = ct.prefecture_code); 
/*
-> Limit: 200 row(s)  (cost=60901.83 rows=200) (actual time=0.075..767.053 rows=41 loops=1)
    -> Nested loop semijoin  (cost=60901.83 rows=599719) (actual time=0.075..767.048 rows=41 loops=1)
        -> Table scan on pr  (cost=4.95 rows=47) (actual time=0.027..0.043 rows=47 loops=1)
        -> Covering index lookup on ct using idx_customers_prefecture_code (prefecture_code=pr.prefecture_code)  (cost=597545.33 rows=12760) (actual time=16.319..16.319 rows=1 loops=47)
*/

-- IN 
EXPLAIN ANALYZE
SELECT * FROM prefectures AS pr 
WHERE prefecture_code IN (SELECT prefecture_code FROM customers); 
/*
-> Limit: 200 row(s)  (cost=60901.83 rows=200) (actual time=0.105..1.120 rows=41 loops=1)
    -> Nested loop semijoin  (cost=60901.83 rows=599719) (actual time=0.104..1.117 rows=41 loops=1)
        -> Table scan on pr  (cost=4.95 rows=47) (actual time=0.044..0.056 rows=47 loops=1)
        -> Covering index lookup on customers using idx_customers_prefecture_code (prefecture_code=pr.prefecture_code)  (cost=597545.33 rows=12760) (actual time=0.022..0.022 rows=1 loops=47)
*/