
---4 Show the list of first, last names and ages of the employees whose age is greater than 55. The result should be sorted by last name.
SELECT first_name, last_name, birth_date, extract(year from age( now() , birth_date )) FROM "Employee"
where extract(year from age( now() , birth_date ))  >= 55
group by birth_date, first_name, last_name;



---10 Show first, last names and ages of 3 eldest employees
SELECT  first_name, last_name, birth_date FROM "Employee"
ORDER BY birth_date LIMIT 3


---16 Show first and last names of the employees as well as the count of their orders shipped after required date during the year 1997 (use left join).
SELECT  e.first_name, e.last_name, extract(year from date) as required_date, count(date)
FROM "Employee" e
LEFT JOIN "Order" o ON e.id = o.id_employee AND o.date between '1997-01-01' AND '1997-12-31'
WHERE o.date IS NOT NULL
GROUP BY  e.first_name, e.last_name, required_date;


---22 *Show the list of french customers’ names who used to order non-french products (use left join).
SELECT  cus.id, cus.f_name_customer, cus.l_name_customer, co.name_country AS cust_country, p.name_product, pr.name_producer, c.name_country as product_country
FROM "Customer" cus 
JOIN "City" ct ON cus.id_city = ct.id
JOIN "Country" co ON co.id = ct.id_country AND co.name_country = 'USA' -- customer's country
JOIN "Order" o ON o.id_customer = cus.id 
JOIN "Order_product" op ON op.id_order = o.id
JOIN "Product" p ON p.id = op.id_product
JOIN "Producer" pr ON pr.id = p.id_producer
JOIN "Country" c ON c.id = pr.id_country AND c.name_country != 'USA'
WHERE cus.id not in (
SELECT  cus.id
FROM "Customer" cus 
JOIN "City" ct ON cus.id_city = ct.id
JOIN "Country" co ON co.id = ct.id_country AND co.name_country = 'USA' -- customer's country
JOIN "Order" o ON o.id_customer = cus.id 
JOIN "Order_product" op ON op.id_order = o.id
JOIN "Product" p ON p.id = op.id_product
JOIN "Producer" pr ON pr.id = p.id_producer
JOIN "Country" c ON c.id = pr.id_country AND c.name_country = 'USA')

---28 *Show the list of product names along with unit prices and the history of unit prices taken from the orders (show ‘Product name – Unit price – 
--Historical price’). The duplicate records should be eliminated. If no orders were made for a certain product, then the result for this product
--should look like ‘Product name – Unit price – NULL’. Sort the list by the product name.
UPDATE "Product" SET price = 62534 WHERE id = 61;


SELECT DISTINCT p.name_product, p.price AS unit_price, op.unit_price AS historical_price 
FROM "Product" p
LEFT JOIN "Order_product" op ON p.id = op.id_product 
ORDER BY p.name_product;


---34 *Change the HireDate field in all your records to current date (first run the SELECT statement to check whether you are updating the appropriate records!).

--SELECT * FROM "Employee"
--WHERE notes = 'Yuliya Lapchyk'

UPDATE  "Employee" SET hire_date = now()
WHERE notes = 'Yuliya Lapchyk';