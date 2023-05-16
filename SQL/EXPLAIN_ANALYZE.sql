-- INDEX なし
SELECT * FROM customers WHERE UPPER(first_name)="JOSEPH";

-- INDEX追加
CREATE INDEX idx_customers_first_name ON customers(first_name);


EXPLAIN ANALYZE SELECT * FROM customers WHERE UPPER(first_name)="JOSEPH";
/*
-> Limit: 200 row(s)  (cost=50420.60 rows=200) (actual time=0.084..15.724 rows=200 loops=1)
    -> Filter: (upper(customers.first_name) = 'JOSEPH')  (cost=50420.60 rows=496756) (actual time=0.084..15.706 rows=200 loops=1)
        -> Table scan on customers  (cost=50420.60 rows=496756) (actual time=0.078..12.769 rows=20321 loops=1)
*/
CREATE INDEX idx_customers_lower_first_name ON customers((UPPER(first_name)));
/*
-> Limit: 200 row(s)  (cost=1649.20 rows=200) (actual time=0.282..1.032 rows=200 loops=1)
    -> Index lookup on customers using idx_customers_lower_first_name (upper(first_name)='JOSEPH')  (cost=1649.20 rows=4712) (actual time=0.281..1.022 rows=200 loops=1)
*/

EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name IN ("joseph","Joseph","JOSEPH");

DROP INDEX idx_customers_first_name ON customers;
DROP INDEX idx_customers_lower_first_name ON customers;

CREATE INDEX idx_customers_age ON customers(age);

EXPLAIN ANALYZE SELECT * FROM customers WHERE age = 25;
/*
-> Limit: 200 row(s)  (cost=3263.60 rows=200) (actual time=0.321..0.978 rows=200 loops=1)
    -> Index lookup on customers using idx_customers_age (age=25)  (cost=3263.60 rows=10286) (actual time=0.319..0.967 rows=200 loops=1)
*/

EXPLAIN ANALYZE SELECT * FROM customers WHERE age +2 = 27;
/*
-> Limit: 200 row(s)  (cost=50508.90 rows=200) (actual time=0.084..6.643 rows=200 loops=1)
    -> Filter: ((customers.age + 2) = 27)  (cost=50508.90 rows=497639) (actual time=0.084..6.632 rows=200 loops=1)
        -> Table scan on customers  (cost=50508.90 rows=497639) (actual time=0.068..5.952 rows=9365 loops=1)
*/

-- 文字列と数値の比較
CREATE INDEX idx_customers_prefecture_code ON customers(prefecture_code);
EXPLAIN ANALYZE SELECT * FROM customers WHERE prefecture_code =21;
/*
-> Limit: 200 row(s)  (cost=50508.90 rows=200) (actual time=0.098..5.502 rows=200 loops=1)
    -> Filter: (customers.prefecture_code = 21)  (cost=50508.90 rows=49764) (actual time=0.098..5.492 rows=200 loops=1)
        -> Table scan on customers  (cost=50508.90 rows=497639) (actual time=0.084..4.803 rows=7863 loops=1)
 */
DESCRIBE customers;
EXPLAIN ANALYZE SELECT * FROM customers WHERE prefecture_code ="21";
/*
 * -> Limit: 200 row(s)  (cost=4429.20 rows=200) (actual time=0.407..1.261 rows=200 loops=1)
    -> Index lookup on customers using idx_customers_prefecture_code (prefecture_code='21'), with index condition: (customers.prefecture_code = '21')  (cost=4429.20 rows=21942) (actual time=0.407..1.253 rows=200 loops=1)
 */

-- 前方一致、中間一致、後方一致
CREATE INDEX idx_customers_first_name ON customers(first_name);
EXPLAIN ANALYZE SELECT * FROM customers  WHERE first_name  LIKE "Jo%";
/*
-> Limit: 200 row(s)  (cost=23498.36 rows=200) (actual time=0.038..0.990 rows=200 loops=1)
    -> Index range scan on customers using idx_customers_first_name over ('Jo' <= first_name <= 'Jo􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿'), with index condition: (customers.first_name like 'Jo%')  (cost=23498.36 rows=52218) (actual time=0.038..0.981 rows=200 loops=1)
 */

-- 後方一致はフルスキャン
EXPLAIN ANALYZE SELECT * FROM customers  WHERE first_name  LIKE "%A";
/*
 -> Limit: 200 row(s)  (cost=50508.90 rows=200) (actual time=0.072..0.932 rows=200 loops=1)
    -> Filter: (customers.first_name like '%A')  (cost=50508.90 rows=55288) (actual time=0.072..0.923 rows=200 loops=1)
        -> Table scan on customers  (cost=50508.90 rows=497639) (actual time=0.069..0.767 rows=1058 loops=1)
*/

-- 中間一致はフルスキャン
-- first_Name に Jo を含む人の最初の 50000
EXPLAIN ANALYZE SELECT * FROM customers  WHERE first_name  LIKE "%Jo％" LIMIT 50000; 
/*
-> Limit: 50000 row(s)  (cost=50508.90 rows=50000) (actual time=383.712..383.712 rows=0 loops=1)
    -> Filter: (customers.first_name like '%Jo％')  (cost=50508.90 rows=55288) (actual time=383.711..383.711 rows=0 loops=1)
        -> Table scan on customers  (cost=50508.90 rows=497639) (actual time=0.076..313.845 rows=500000 loops=1)
 */

-- customers から 50000 件とってきたうち first_Name に Jo を含む人(副問い合わせ)
EXPLAIN ANALYZE SELECT * FROM (SELECT * FROM customers LIMIT 50000) AS tmp  WHERE first_name  LIKE "%Jo％"; 
/*
-> Limit: 200 row(s)  (cost=55499.92..53712.99 rows=200) (actual time=83.503..83.503 rows=0 loops=1)
    -> Filter: (tmp.first_name like '%Jo％')  (cost=55499.92..5627.50 rows=5555) (actual time=83.501..83.501 rows=0 loops=1)
        -> Table scan on tmp  (cost=55508.91..56136.40 rows=50000) (actual time=68.442..77.169 rows=50000 loops=1)
            -> Materialize  (cost=55508.90..55508.90 rows=50000) (actual time=68.439..68.439 rows=50000 loops=1)
                -> Limit: 50000 row(s)  (cost=50508.90 rows=50000) (actual time=0.092..34.875 rows=50000 loops=1)
                    -> Table scan on customers  (cost=50508.90 rows=497639) (actual time=0.091..32.614 rows=50000 loops=1)
*/

SHOW INDEX FROM customers;
DROP INDEX idx_customers_age ON customers;
DROP INDEX idx_customers_prefecture_code ON customers;
DROP INDEX idx_customers_first_name ON customers;