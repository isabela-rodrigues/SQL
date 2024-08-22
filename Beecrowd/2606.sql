SELECT a.id, a.name
FROM products a
LEFT JOIN categories b
ON A.id_categories = b.id
WHERE b.name LIKE 'super%'