USE day_19_21_db;
SHOW INDEX FROM customers;

DROP INDEX idx_customers_age ON customers;

SELECT 
* 
FROM customers 
where 
prefecture_code  IN (SELECT prefecture_code FROM prefectures WHERE name ="東京都")
OR 
prefecture_code  IN (SELECT prefecture_code FROM prefectures WHERE name ="大阪府")
;

-- 無駄な処理を一つに
SELECT 
* 
FROM customers 
where 
prefecture_code  IN (SELECT prefecture_code FROM prefectures WHERE name IN ("東京都","大阪府"))
;

-- SELECT ない副問い合わせをやめる
EXPLAIN ANALYZE
SELECT 
* ,(SELECT name FROM prefectures AS pr WHERE pr.prefecture_code = ct.prefecture_code)
FROM customers AS ct
;
/*
-> Limit: 200 row(s)  (cost=50508.90 rows=200) (actual time=0.077..0.249 rows=200 loops=1)
    -> Table scan on ct  (cost=50508.90 rows=497639) (actual time=0.076..0.236 rows=200 loops=1)
-> Select #2 (subquery in projection; dependent)
    -> Single-row index lookup on pr using PRIMARY (prefecture_code=ct.prefecture_code)  (cost=0.35 rows=1) (actual time=0.002..0.002 rows=1 loops=200)
*/

EXPLAIN ANALYZE
SELECT 
*,pr.name
FROM customers AS ct
LEFT JOIN 
prefectures AS pr 
ON pr.prefecture_code = ct.prefecture_code 
;
/*
-> Limit: 200 row(s)  (cost=224682.55 rows=200) (actual time=0.108..0.439 rows=200 loops=1)
    -> Nested loop left join  (cost=224682.55 rows=497639) (actual time=0.106..0.430 rows=200 loops=1)
        -> Table scan on ct  (cost=50508.90 rows=497639) (actual time=0.089..0.208 rows=200 loops=1)
        -> Single-row index lookup on pr using PRIMARY (prefecture_code=ct.prefecture_code)  (cost=0.25 rows=1) (actual time=0.001..0.001 rows=1 loops=200)
*/

SHOW TABLES;
SELECT * FROM sales_history;
-- 2016 年度、2016 年度の月ごとの集計カラムを追加
SELECT sales_day ,SUM(sales_amount)
FROM sales_history WHERE sales_day between "2016-01-01" AND "2016-12-31" 
GROUP BY  sales_day;

EXPLAIN ANALYZE 
SELECT 
sales_history.*,sales_summary.sales_daily_amount
from 
sales_history 
LEFT JOIN
(SELECT sales_day ,SUM(sales_amount) AS sales_daily_amount
FROM sales_history 
WHERE sales_day between "2016-01-01" AND "2016-12-31" 
GROUP BY  sales_day) AS sales_summary
ON sales_history.sales_day= sales_summary.sales_day
WHERE sales_history.sales_day between "2016-01-01" AND "2016-12-31" 
;
/*
  -> Limit: 200 row(s)  (cost=898104.06 rows=0) (actual time=4082.752..4084.102 rows=200 loops=1)
    -> Nested loop left join  (cost=898104.06 rows=0) (actual time=4082.751..4084.085 rows=200 loops=1)
        -> Filter: (sales_history.sales_day between '2016-01-01' and '2016-12-31')  (cost=239738.77 rows=263338) (actual time=0.060..1.232 rows=200 loops=1)
            -> Table scan on sales_history  (cost=239738.77 rows=2370280) (actual time=0.057..0.616 rows=1569 loops=1)
        -> Index lookup on sales_summary using <auto_key0> (sales_day=sales_history.sales_day)  (cost=0.25..2.50 rows=10) (actual time=20.414..20.414 rows=1 loops=200)
            -> Materialize  (cost=0.00..0.00 rows=0) (actual time=4082.686..4082.686 rows=336 loops=1)
                -> Table scan on <temporary>  (actual time=4082.465..4082.492 rows=336 loops=1)
                    -> Aggregate using temporary table  (actual time=4082.464..4082.464 rows=336 loops=1)
                        -> Filter: (sales_history.sales_day between '2016-01-01' and '2016-12-31')  (cost=239738.77 rows=263338) (actual time=0.021..3863.571 rows=312844 loops=1)
                            -> Table scan on sales_history  (cost=239738.77 rows=2370280) (actual time=0.021..2854.427 rows=2500000 loops=1)
*/

EXPLAIN ANALYZE 
SELECT 
sh.*,SUM(sh.sales_amount) OVER(PARTITION BY sh.sales_day)
from 
sales_history AS sh
WHERE sh.sales_day between "2016-01-01" AND "2016-12-31" ;
/*
 -> Limit: 200 row(s)  (actual time=3646.228..3646.279 rows=200 loops=1)
    -> Window aggregate with buffering: sum(sales_history.sales_amount) OVER (PARTITION BY sh.sales_day )   (actual time=3646.227..3646.270 rows=200 loops=1)
        -> Sort: sh.sales_day  (cost=239738.77 rows=2370280) (actual time=3643.902..3643.977 rows=982 loops=1)
            -> Filter: (sh.sales_day between '2016-01-01' and '2016-12-31')  (cost=239738.77 rows=2370280) (actual time=0.049..3465.651 rows=312844 loops=1)
                -> Table scan on sh  (cost=239738.77 rows=2370280) (actual time=0.047..2516.044 rows=2500000 loops=1)
 */



