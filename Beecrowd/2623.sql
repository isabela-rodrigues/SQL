SELECT product.name, category.name
FROM products product
LEFT JOIN categories category
ON product.id_categories = category.id
WHERE product.amount > 100
AND category.id IN (1,2,3,6,9)
ORDER BY category.id