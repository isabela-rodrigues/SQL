SELECT customers.name
FROM customers
LEFT JOIN legal_person
ON customers.id = legal_person.id_customers
WHERE customers.id IN (SELECT DISTINCT id_customers FROM legal_person)