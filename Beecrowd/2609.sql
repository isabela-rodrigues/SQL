SELECT a.name, SUM(b.amount) AS sum_products
FROM categories a
JOIN products b
	ON a.id = b.id_categories
GROUP BY a.name