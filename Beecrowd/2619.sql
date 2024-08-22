SELECT products.name, providers.name, products.price
FROM products
LEFT JOIN providers
ON products.id_providers = providers.id
LEFT JOIN categories
ON products.id_categories = categories.id
WHERE products.price > 1000
AND categories.name = 'Super Luxury'