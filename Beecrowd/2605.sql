SELECT A.name
, B.name
FROM products A
LEFT JOIN providers B
ON A.id_providers = B.id
WHERE id_categories = 6 