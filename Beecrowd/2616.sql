SELECT c.id, c.name 
FROM customers c 
WHERE NOT EXISTS (SELECT id_customers FROM locations WHERE id_customers = c.id);