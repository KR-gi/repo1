USE day_19_21_db;

SELECT * FROM customers;

EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name = "Olivia";
/*
-> Limit: 200 row(s)  (cost=50420.60 rows=200) (actual time=0.155..134.056 rows=200 loops=1)
    -> Filter: (customers.first_name = 'Olivia')  (cost=50420.60 rows=49676) (actual time=0.153..134.031 rows=200 loops=1)
        -> Table scan on customers  (cost=50420.60 rows=496756) (actual time=0.140..117.826 rows=192550 loops=1)
*/

-- first_name に INDEX追加
CREATE INDEX idx_customers_first_name ON customers(first_name);

EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name = "Olivia";
/*
-> Limit: 200 row(s)  (cost=176.05 rows=200) (actual time=0.500..1.199 rows=200 loops=1)
    -> Index lookup on customers using idx_customers_first_name (first_name='Olivia')  (cost=176.05 rows=503) (actual time=0.499..1.187 rows=200 loops=1)
*/

CREATE INDEX idx_customers_first_age ON customers(age);

EXPLAIN ANALYZE SELECT * FROM customers WHERE age = 41;
/*
 -> Limit: 200 row(s)  (cost=3245.00 rows=200) (actual time=36.898..37.490 rows=200 loops=1)
    -> Index lookup on customers using idx_customers_first_age (age=41)  (cost=3245.00 rows=10100) (actual time=36.897..37.480 rows=200 loops=1)
 */

EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name = "Olivia" AND age = 42;
/*
 -> Limit: 200 row(s)  (cost=35.56 rows=10) (actual time=10.992..14.969 rows=10 loops=1)
    -> Filter: ((customers.age = 42) and (customers.first_name = 'Olivia'))  (cost=35.56 rows=10) (actual time=10.991..14.967 rows=10 loops=1)
        -> Intersect rows sorted by row ID  (cost=35.56 rows=10) (actual time=10.986..14.959 rows=10 loops=1)
            -> Index range scan on customers using idx_customers_first_name over (first_name = 'Olivia')  (cost=24.90 rows=503) (actual time=10.624..10.861 rows=503 loops=1)
            -> Index range scan on customers using idx_customers_first_age over (age = 42)  (cost=7.15 rows=10086) (actual time=0.064..3.555 rows=10082 loops=1)
*/



EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name = "Olivia" OR age = 42;
/*
-> Limit: 200 row(s)  (cost=114301.72 rows=200) (actual time=0.058..7.783 rows=200 loops=1)
    -> Filter: ((customers.first_name = 'Olivia') or (customers.age = 42))  (cost=114301.72 rows=94384) (actual time=0.057..7.770 rows=200 loops=1)
        -> Table scan on customers  (cost=114301.72 rows=496756) (actual time=0.056..6.394 rows=10275 loops=1)

*/
 -- 複合インデックス
DROP INDEX idx_customers_first_name ON customers;
DROP INDEX idx_customers_first_age ON customers;

CREATE INDEX idx_customers_first_name_age ON customers(first_name,age);


EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name = "Olivia" AND age = 42;
/*
-> Limit: 200 row(s)  (cost=3.50 rows=10) (actual time=0.079..0.084 rows=10 loops=1)
    -> Index lookup on customers using idx_customers_first_name_age (first_name='Olivia', age=42)  (cost=3.50 rows=10) (actual time=0.079..0.083 rows=10 loops=1)
*/

-- age だけは FULL SCAN
EXPLAIN ANALYZE SELECT * FROM customers WHERE  age = 42;
/*
-> Limit: 200 row(s)  (cost=50420.60 rows=200) (actual time=0.200..7.562 rows=200 loops=1)
    -> Filter: (customers.age = 42)  (cost=50420.60 rows=49676) (actual time=0.200..7.551 rows=200 loops=1)
        -> Table scan on customers  (cost=50420.60 rows=496756) (actual time=0.069..7.032 rows=11508 loops=1)
*/

EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name = "Olivia" OR age = 42;
/*
-> Limit: 200 row(s)  (cost=50420.60 rows=200) (actual time=0.078..7.838 rows=200 loops=1)
    -> Filter: ((customers.first_name = 'Olivia') or (customers.age = 42))  (cost=50420.60 rows=50375) (actual time=0.077..7.826 rows=200 loops=1)
        -> Table scan on customers  (cost=50420.60 rows=496756) (actual time=0.075..6.481 rows=10275 loops=1)
*/

-- ORDER BY,GROUP BY : 処理時間がかかる、実行前に WHERE で絞り込む
DROP INDEX idx_customers_first_name_age ON customers;
EXPLAIN ANALYZE SELECT * FROM customers ORDER BY first_name;
/*
-> Limit: 200 row(s)  (cost=50420.60 rows=200) (actual time=1715.152..1715.183 rows=200 loops=1)
    -> Sort: customers.first_name, limit input to 200 row(s) per chunk  (cost=50420.60 rows=496756) (actual time=1715.151..1715.173 rows=200 loops=1)
        -> Table scan on customers  (cost=50420.60 rows=496756) (actual time=0.130..309.897 rows=500000 loops=1)
*/


CREATE INDEX idx_customers_first_name ON customers(first_name);

-- INDEX あり
EXPLAIN ANALYZE SELECT * FROM customers ORDER BY first_name;
/*
-> Limit: 200 row(s)  (cost=0.31 rows=200) (actual time=0.461..1.187 rows=200 loops=1)
    -> Index scan on customers using idx_customers_first_name  (cost=0.31 rows=200) (actual time=0.458..1.175 rows=200 loops=1)
*/

-- 強制的に INDEX を利用する場合（上はすでに利用されている）
EXPLAIN ANALYZE SELECT /*+INDEX(customers)*/ * FROM customers ORDER BY first_name;
/*
-> Limit: 200 row(s)  (cost=50.01 rows=200) (actual time=1355.736..1356.353 rows=200 loops=1)
    -> Index scan on customers using idx_customers_first_name  (cost=50.01 rows=200) (actual time=1355.735..1356.344 rows=200 loops=1)
*/

EXPLAIN ANALYZE SELECT * FROM customers ORDER BY id;
/*
  -> Limit: 200 row(s)  (cost=0.31 rows=200) (actual time=0.076..0.200 rows=200 loops=1)
    -> Index scan on customers using PRIMARY  (cost=0.31 rows=200) (actual time=0.075..0.191 rows=200 loops=1)
*/

EXPLAIN ANALYZE SELECT first_name,COUNT(*) FROM customers GROUP BY first_name;
/*
-> Limit: 200 row(s)  (cost=20.31 rows=200) (actual time=0.702..132.398 rows=200 loops=1)
    -> Group aggregate: count(0)  (cost=20.31 rows=200) (actual time=0.701..132.376 rows=200 loops=1)
        -> Covering index scan on customers using idx_customers_first_name  (cost=0.31 rows=200) (actual time=0.092..113.064 rows=142959 loops=1)
*/

CREATE INDEX idx_customers_age ON customers(age);
EXPLAIN ANALYZE SELECT age,COUNT(*) FROM customers GROUP BY age;
/*
 * -> Limit: 200 row(s)  (cost=20.31 rows=47) (actual time=994.171..1651.565 rows=49 loops=1)
    -> Group aggregate: count(0)  (cost=20.31 rows=47) (actual time=994.170..1651.551 rows=49 loops=1)
        -> Covering index scan on customers using idx_customers_age  (cost=0.31 rows=200) (actual time=955.209..1629.902 rows=500000 loops=1)
*/


DROP INDEX idx_customers_first_name_age ON customers;
DROP INDEX idx_customers_age ON customers;


-- 複数の GROUP BY 
CREATE INDEX idx_customers_first_name_age ON customers(first_name,age);

EXPLAIN ANALYZE SELECT first_name ,age,COUNT(*) FROM customers GROUP BY first_name ,age;
/*
 -> Limit: 200 row(s)  (cost=20.31 rows=200) (actual time=16.112..28.486 rows=200 loops=1)
    -> Group aggregate: count(0)  (cost=20.31 rows=200) (actual time=16.111..28.471 rows=200 loops=1)
        -> Covering index scan on customers using idx_customers_first_name_age  (cost=0.31 rows=200) (actual time=16.085..27.643 rows=4331 loops=1)
 */

DROP INDEX  idx_customers_first_name_age ON customers;


-- 外部キーにインデックス
EXPLAIN ANALYZE  SELECT * FROM prefectures AS pr 
INNER JOIN customers  AS ct 
ON pr.prefecture_code = ct.prefecture_code AND pr.name ="北海道";

/*
-> Limit: 200 row(s)  (cost=224285.20 rows=200) (actual time=0.328..20.848 rows=200 loops=1)
    -> Nested loop inner join  (cost=224285.20 rows=49676) (actual time=0.327..20.825 rows=200 loops=1)
        -> Filter: (ct.prefecture_code is not null)  (cost=50420.60 rows=496756) (actual time=0.166..8.053 rows=8583 loops=1)
            -> Table scan on ct  (cost=50420.60 rows=496756) (actual time=0.159..7.433 rows=8583 loops=1)
        -> Filter: (pr.`name` = '北海道')  (cost=0.25 rows=0.1) (actual time=0.001..0.001 rows=0 loops=8583)
            -> Single-row index lookup on pr using PRIMARY (prefecture_code=ct.prefecture_code)  (cost=0.25 rows=1) (actual time=0.001..0.001 rows=1 loops=8583)
*/

CREATE INDEX idx_customers_prefecture_code ON customers(prefecture_code);

/*
-> Limit: 200 row(s)  (cost=16819.59 rows=200) (actual time=0.520..1.381 rows=200 loops=1)
    -> Nested loop inner join  (cost=16819.59 rows=63101) (actual time=0.519..1.371 rows=200 loops=1)
        -> Filter: (pr.`name` = '北海道')  (cost=4.95 rows=5) (actual time=0.031..0.031 rows=1 loops=1)
            -> Table scan on pr  (cost=4.95 rows=47) (actual time=0.029..0.029 rows=1 loops=1)
        -> Index lookup on ct using idx_customers_prefecture_code (prefecture_code=pr.prefecture_code)  (cost=2520.66 rows=13426) (actual time=0.487..1.329 rows=200 loops=1)
*/

DROP INDEX  idx_customers_prefecture_code ON customers;