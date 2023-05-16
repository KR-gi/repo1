-- 無駄な GROUP BY
EXPLAIN ANALYZE SELECT 
age,count(*)
FROM customers 
GROUP BY age;
/*
-> Limit: 200 row(s)  (actual time=396.712..396.718 rows=49 loops=1)
    -> Table scan on <temporary>  (actual time=396.710..396.714 rows=49 loops=1)
        -> Aggregate using temporary table  (actual time=396.709..396.709 rows=49 loops=1)
            -> Table scan on customers  (cost=50508.90 rows=497639) (actual time=0.550..276.051 rows=500000 loops=1)
*/

EXPLAIN ANALYZE SELECT 
age,count(*)
FROM customers 
GROUP BY age
HAVING age < 30;
/*
-> Limit: 200 row(s)  (actual time=246.785..246.791 rows=8 loops=1)
    -> Filter: (customers.age < 30)  (actual time=246.784..246.789 rows=8 loops=1)
        -> Table scan on <temporary>  (actual time=246.780..246.784 rows=49 loops=1)
            -> Aggregate using temporary table  (actual time=246.779..246.779 rows=49 loops=1)
                -> Table scan on customers  (cost=50508.90 rows=497639) (actual time=0.069..146.023 rows=500000 loops=1)
*/

EXPLAIN ANALYZE SELECT 
age,count(*)
FROM customers 
WHERE age <30
GROUP BY age;
/*
-> Limit: 200 row(s)  (actual time=193.138..193.140 rows=8 loops=1)
    -> Table scan on <temporary>  (actual time=193.136..193.137 rows=8 loops=1)
        -> Aggregate using temporary table  (actual time=193.135..193.135 rows=8 loops=1)
            -> Filter: (customers.age < 30)  (cost=50508.90 rows=165863) (actual time=0.057..174.565 rows=82096 loops=1)
                -> Table scan on customers  (cost=50508.90 rows=497639) (actual time=0.052..150.217 rows=500000 loops=1)
*/
CREATE INDEX idx_customers_age ON customers(age);
EXPLAIN ANALYZE SELECT 
age,count(*)
FROM customers 
WHERE age <30
GROUP BY age;

/*
 -> Limit: 200 row(s)  (cost=48687.22 rows=47) (actual time=4.445..199.222 rows=8 loops=1)
    -> Group aggregate: count(0)  (cost=48687.22 rows=47) (actual time=4.444..199.219 rows=8 loops=1)
        -> Filter: (customers.age < 30)  (cost=32491.42 rows=161958) (actual time=0.033..195.510 rows=82096 loops=1)
            -> Covering index range scan on customers using idx_customers_age over (NULL < age < 30)  (cost=32491.42 rows=161958) (actual time=0.032..190.233 rows=82096 loops=1)
*/

-- MAX,MIN はインデックスを利用する
EXPLAIN ANALYZE SELECT MAX(age),MIN(age),AVG(age),SUM(age) FROM customers;
/*
  -> Limit: 200 row(s)  (cost=100272.80 rows=1) (actual time=274.766..274.767 rows=1 loops=1)
    -> Aggregate: avg(customers.age)  (cost=100272.80 rows=1) (actual time=274.766..274.766 rows=1 loops=1)
        -> Covering index scan on customers using idx_customers_age  (cost=50508.90 rows=497639) (actual time=0.025..237.417 rows=500000 loops=1)
*/

-- DISTINCT の代わりに exists 
EXPLAIN ANALYZE SELECT DISTINCT pr.name FROM prefectures AS pr
INNER JOIN customers AS ct 
ON pr.prefecture_code  = ct.prefecture_code ;
/*
-> Limit: 200 row(s)  (cost=274446.46..274448.95 rows=200) (actual time=896.401..896.405 rows=41 loops=1)
    -> Table scan on <temporary>  (cost=274446.46..280669.44 rows=497639) (actual time=896.399..896.403 rows=41 loops=1)
        -> Temporary table with deduplication  (cost=274446.45..274446.45 rows=497639) (actual time=896.395..896.395 rows=41 loops=1)
            -> Limit table size: 200 unique row(s)
                -> Nested loop inner join  (cost=224682.55 rows=497639) (actual time=0.071..709.922 rows=500000 loops=1)
                    -> Filter: (ct.prefecture_code is not null)  (cost=50508.90 rows=497639) (actual time=0.049..198.069 rows=500000 loops=1)
                        -> Table scan on ct  (cost=50508.90 rows=497639) (actual time=0.048..169.216 rows=500000 loops=1)
                    -> Single-row index lookup on pr using PRIMARY (prefecture_code=ct.prefecture_code)  (cost=0.25 rows=1) (actual time=0.001..0.001 rows=1 loops=500000)
*/

EXPLAIN ANALYZE SELECT DISTINCT pr.name FROM prefectures AS pr
INNER JOIN customers AS ct 
ON pr.prefecture_code  = ct.prefecture_code ;

-- EXISTS
EXPLAIN ANALYZE SELECT name FROM prefectures AS pr 
WHERE EXISTS(
	SELECT 1 FROM customers AS ct WHERE ct.prefecture_code=pr.prefecture_code
	);
	/*
-> Limit: 200 row(s)  (cost=2338912.95 rows=200) (actual time=250.526..250.572 rows=41 loops=1)
    -> Nested loop inner join  (cost=2338912.95 rows=23389033) (actual time=250.525..250.569 rows=41 loops=1)
        -> Table scan on pr  (cost=4.95 rows=47) (actual time=0.044..0.064 rows=47 loops=1)
        -> Single-row index lookup on <subquery2> using <auto_distinct_key> (prefecture_code=pr.prefecture_code)  (cost=100272.80..100272.80 rows=1) (actual time=5.330..5.330 rows=1 loops=47)
            -> Materialize with deduplication  (cost=100272.80..100272.80 rows=497639) (actual time=250.443..250.443 rows=41 loops=1)
                -> Filter: (ct.prefecture_code is not null)  (cost=50508.90 rows=497639) (actual time=0.026..166.632 rows=500000 loops=1)
                    -> Table scan on ct  (cost=50508.90 rows=497639) (actual time=0.026..140.131 rows=500000 loops=1)
*/

-- UNION → UNION all 
EXPLAIN ANALYZE 
SELECT * FROM customers WHERE age <30
UNION 
SELECT * FROM customers WHERE age > 50;
/*
-> Limit: 200 row(s)  (cost=142095.51..142098.00 rows=200) (actual time=1.191..1.226 rows=200 loops=1)
    -> Table scan on <union temporary>  (cost=142095.51..147232.70 rows=410777) (actual time=1.190..1.217 rows=200 loops=1)
        -> Union materialize with deduplication  (cost=142095.50..142095.50 rows=410777) (actual time=1.189..1.189 rows=200 loops=1)
            -> Limit table size: 200 unique row(s)
                -> Filter: (customers.age < 30)  (cost=50508.90 rows=161958) (actual time=0.070..0.941 rows=200 loops=1)
                    -> Table scan on customers  (cost=50508.90 rows=497639) (actual time=0.067..0.873 rows=1282 loops=1)
            -> Limit table size: 200 unique row(s)
                -> Filter: (customers.age > 50)  (cost=50508.90 rows=248819) (never executed)
                    -> Table scan on customers  (cost=50508.90 rows=497639) (never executed)
*/
EXPLAIN ANALYZE 
SELECT * FROM customers WHERE age <30
UNION ALL 
SELECT * FROM customers WHERE age > 50;
/*
-> Limit: 200 row(s)  (actual time=0.070..1.090 rows=200 loops=1)
    -> Append  (actual time=0.069..1.079 rows=200 loops=1)
        -> Stream results  (cost=50508.90 rows=161958) (actual time=0.068..1.069 rows=200 loops=1)
            -> Filter: (customers.age < 30)  (cost=50508.90 rows=161958) (actual time=0.063..0.952 rows=200 loops=1)
                -> Table scan on customers  (cost=50508.90 rows=497639) (actual time=0.060..0.893 rows=1282 loops=1)
        -> Stream results  (cost=50508.90 rows=248819) (never executed)
            -> Filter: (customers.age > 50)  (cost=50508.90 rows=248819) (never executed)
                -> Table scan on customers  (cost=50508.90 rows=497639) (never executed)
*/