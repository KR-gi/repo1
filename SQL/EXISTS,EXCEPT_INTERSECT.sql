-- EXCEPT を EXISTS でかく
SELECT*FROM customers;
SELECT*FROM customers_2;

SELECT*FROM customers
UNION
SELECT*FROM customers_2;

SELECT*FROM customers AS c1
WHERE NOT EXISTS (
	SELECT * FROM customers_2 AS c2
	WHERE
	c1.id = c2.id AND
	c1.first_name = c2.first_name AND
	c1.last_name = c2.last_name AND
	c1.phone_number = c2.phone_number AND
	c1.age = c2.age
	);
	
-- INTERSECT を EXISTS で実現
SELECT*FROM customers AS c1
WHERE EXISTS (
	SELECT * FROM customers_2 AS c2
	WHERE
	c1.id = c2.id AND
	c1.first_name = c2.first_name AND
	c1.last_name = c2.last_name AND
	(c1.phone_number = c2.phone_number OR (c1.phone_number IS NULL AND c2.phone_number IS NULL)) AND
	c1.age = c2.age
	);
