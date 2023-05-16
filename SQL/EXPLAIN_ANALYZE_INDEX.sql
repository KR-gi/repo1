EXPLAIN ANALYZE SELECT * FROM customers;
/*
-> Limit: 200 row(s)  (cost=52650.28 rows=200) (actual time=0.814..1.267 rows=200 loops=1)
    -> Table scan on customers  (cost=52650.28 rows=496756) (actual time=0.812..1.256 rows=200 loops=1)
*/

EXPLAIN ANALYZE SELECT * FROM customers WHERE id=1;
/*
-> Limit: 200 row(s)  (cost=0.00..0.00 rows=1) (actual time=0.001..0.001 rows=1 loops=1)
    -> Rows fetched before execution  (cost=0.00..0.00 rows=1) (actual time=0.000..0.000 rows=1 loops=1)
*/

EXPLAIN SELECT * FROM customers WHERE id=1;
EXPLAIN ANALYZE  SELECT * FROM customers WHERE id<10;

/*
-> Limit: 200 row(s)  (cost=2.82 rows=9) (actual time=0.035..0.076 rows=9 loops=1)
    -> Filter: (customers.id < 10)  (cost=2.82 rows=9) (actual time=0.034..0.074 rows=9 loops=1)
        -> Index range scan on customers using PRIMARY over (id < 10)  (cost=2.82 rows=9) (actual time=0.032..0.071 rows=9 loops=1)
*/

SELECT * FROM customers;

SELECT * FROM customers WHERE first_name ="Olivia";
EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name ="Olivia";
/*
 * -> Limit: 200 row(s)  (cost=50420.60 rows=200) (actual time=0.069..132.817 rows=200 loops=1)
    -> Filter: (customers.first_name = 'Olivia')  (cost=50420.60 rows=49676) (actual time=0.068..132.789 rows=200 loops=1)
        -> Table scan on customers  (cost=50420.60 rows=496756) (actual time=0.066..117.170 rows=192550 loops=1)
*/

CREATE INDEX idx_customers_first_name ON customers(first_name);
EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name ="Olivia";
/*
-> Limit: 200 row(s)  (cost=176.05 rows=200) (actual time=0.459..1.435 rows=200 loops=1)
    -> Index lookup on customers using idx_customers_first_name (first_name='Olivia')  (cost=176.05 rows=503) (actual time=0.458..1.423 rows=200 loops=1)
*/

SELECT * FROM customers;
SELECT * FROM customers WHERE gender = "F";
EXPLAIN ANALYZE SELECT * FROM customers WHERE gender = "F";
/*
-> Limit: 200 row(s)  (cost=50420.60 rows=200) (actual time=0.110..0.651 rows=200 loops=1)
    -> Filter: (customers.gender = 'F')  (cost=50420.60 rows=49676) (actual time=0.109..0.630 rows=200 loops=1)
        -> Table scan on customers  (cost=50420.60 rows=496756) (actual time=0.106..0.542 rows=381 loops=1)
*/

CREATE INDEX idx_customers_gender ON customers(gender);
-- 遅くなる(インデックスを付けると)
EXPLAIN ANALYZE SELECT * FROM customers WHERE gender = "F";
/*
-> Limit: 200 row(s)  (cost=27072.80 rows=200) (actual time=0.473..1.026 rows=200 loops=1)
    -> Index lookup on customers using idx_customers_gender (gender='F'), with index condition: (customers.gender = 'F')  (cost=27072.80 rows=248378) (actual time=0.472..1.016 rows=200 loops=1)
*/
-- ヒント句
EXPLAIN ANALYZE SELECT /*+NO INDEX(ct)*/ * FROM customers AS ct WHERE gender = "F";
/*
-> Limit: 200 row(s)  (cost=27072.80 rows=200) (actual time=0.190..0.512 rows=200 loops=1)
    -> Index lookup on ct using idx_customers_gender (gender='F'), with index condition: (ct.gender = 'F')  (cost=27072.80 rows=248378) (actual time=0.189..0.503 rows=200 loops=1)
*/

DROP INDEX idx_customers_gender ON customers;
DROP INDEX idx_customers_first_name ON customers;










EXPLAIN ANALYZE select 
 * 
 FROM customers AS ct
 INNER JOIN prefectures AS pr 
 ON ct.prefecture_code = pr.prefecture_code;
 /*
-> Limit: 200 row(s)  (cost=224285.20 rows=200) (actual time=0.089..0.462 rows=200 loops=1)
    -> Nested loop inner join  (cost=224285.20 rows=496756) (actual time=0.089..0.453 rows=200 loops=1)
        -> Filter: (ct.prefecture_code is not null)  (cost=50420.60 rows=496756) (actual time=0.076..0.217 rows=200 loops=1)
            -> Table scan on ct  (cost=50420.60 rows=496756) (actual time=0.075..0.204 rows=200 loops=1)
        -> Single-row index lookup on pr using PRIMARY (prefecture_code=ct.prefecture_code)  (cost=0.25 rows=1) (actual time=0.001..0.001 rows=1 loops=200)
*/

EXPLAIN ANALYZE select /*+NO_INDEX(pr)*/
 * 
 FROM customers AS ct
 INNER JOIN prefectures AS pr 
 ON ct.prefecture_code = pr.prefecture_code;
 /*
-> Limit: 200 row(s)  (cost=2335509.83 rows=200) (actual time=13.023..13.188 rows=200 loops=1)
    -> Inner hash join (ct.prefecture_code = pr.prefecture_code)  (cost=2335509.83 rows=2334753) (actual time=13.022..13.178 rows=200 loops=1)
        -> Table scan on ct  (cost=121.69 rows=496756) (actual time=0.087..0.194 rows=200 loops=1)
        -> Hash
            -> Table scan on pr  (cost=4.95 rows=47) (actual time=0.050..0.070 rows=47 loops=1)
*/