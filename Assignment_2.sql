----- You need to create a report on whether customers who purchased the product named '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD' buy the products below or not.

---- 1. 'Polk Audio - 50 W Woofer - Black' -- (first_product)
---- 2. 'SB-2000 12 500W Subwoofer (Piano Gloss Black)' -- (second_product)
---- 3. 'Virtually Invisible 891 In-Wall Speakers (Pair)' -- (third_product)

USE SampleRetail

-- Customers who bought '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'
CREATE VIEW report_2
AS

SELECT A.customer_id, D.first_name, D.last_name, A.order_id, B.product_id, C.product_name
FROM sale.orders A, sale.order_item B, product.product C, sale.customer D
WHERE A.order_id = B.order_id
AND B.product_id = C.product_id
AND A.customer_id = D.customer_id
AND C.product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'


SELECT * from dbo.report_2

-- Customers who bought 'Polk Audio - 50 W Woofer - Black' -- (first_product)
CREATE VIEW report_3
AS

SELECT A.customer_id, D.first_name, D.last_name, A.order_id, B.product_id, C.product_name
FROM sale.orders A, sale.order_item B, product.product C, sale.customer D
WHERE A.order_id = B.order_id
AND B.product_id = C.product_id
AND A.customer_id = D.customer_id
AND C.product_name = 'Polk Audio - 50 W Woofer - Black'

SELECT * from dbo.report_3

-- Customers who bought 'SB-2000 12 500W Subwoofer (Piano Gloss Black)'
CREATE VIEW report_4
AS

SELECT A.customer_id, D.first_name, D.last_name, A.order_id, B.product_id, C.product_name
FROM sale.orders A, sale.order_item B, product.product C, sale.customer D
WHERE A.order_id = B.order_id
AND B.product_id = C.product_id
AND A.customer_id = D.customer_id
AND C.product_name = 'SB-2000 12 500W Subwoofer (Piano Gloss Black)'

SELECT * from dbo.report_4
DROP VIEW dbo.report_

-- Customers who bought 'Virtually Invisible 891 In-Wall Speakers (Pair)'
CREATE VIEW report_5
AS

SELECT A.customer_id, D.first_name, D.last_name, A.order_id, B.product_id, C.product_name
FROM sale.orders A, sale.order_item B, product.product C, sale.customer D
WHERE A.order_id = B.order_id
AND B.product_id = C.product_id
AND A.customer_id = D.customer_id
AND C.product_name = 'Virtually Invisible 891 In-Wall Speakers (Pair)'

SELECT * from dbo.report_5

----- COMBINED TABLES
-- Joining tables with LEFT JOIN and converting NULL values to 'No' with ISNULL function

CREATE VIEW comb
AS

SELECT Distinct A.customer_id, A.first_name, A.last_name, ISNULL(B.product_name, 'No') First_Product, ISNULL(C.product_name, 'No') Second_Product, ISNULL(D.product_name, 'No') Third_Product
FROM dbo.report_2 A
LEFT JOIN dbo.report_3 B ON A.customer_id = B.customer_id
LEFT JOIN dbo.report_4 C ON A.customer_id = C.customer_id
LEFT JOIN dbo.report_5 D ON A.customer_id = D.customer_id

SELECT * from dbo.comb

-- Converting Product Names to NULL with NULLIF function
CREATE VIEW comb_2
AS

SELECT A.customer_id, A.first_name, A.last_name, NULLIF(A.First_Product, 'Polk Audio - 50 W Woofer - Black') First_Product, NULLIF(A.Second_Product, 'SB-2000 12 500W Subwoofer (Piano Gloss Black)') Second_Product, NULLIF(A.Third_Product, 'Virtually Invisible 891 In-Wall Speakers (Pair)') Third_Product
FROM dbo.comb A

SELECT * from dbo.comb_2

-- Converting NULL values to 'Yes' with ISNULL Function
SELECT A.customer_id, A.first_name, A.last_name, ISNULL(A.First_Product, 'Yes') First_Product, ISNULL(A.Second_Product, 'Yes') Second_Product, ISNULL(A.Third_Product, 'Yes') Third_Product
FROM dbo.comb_2 A
ORDER BY A.customer_id