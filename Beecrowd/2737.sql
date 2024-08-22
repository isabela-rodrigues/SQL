WITH avg_clients AS(SELECT FLOOR(AVG(customers_number)) as average FROM lawyers)
, max_clients AS(SELECT name, customers_number as highest FROM lawyers ORDER BY customers_number DESC LIMIT 1)
, min_clients AS(SELECT name, customers_number as lowest FROM lawyers ORDER BY customers_number ASC LIMIT 1)
SELECT name, highest as customers_number
FROM max_clients
UNION ALL 
SELECT name, lowest as customers_numbers FROM min_clients
UNION ALL 
SELECT 'Average' as name, average FROM avg_clients