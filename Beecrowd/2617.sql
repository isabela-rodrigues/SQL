SELECT b.name, a.name
FROM providers a
LEFT JOIN products b
	ON a.id = b.id_providers
WHERE a.name = 'Ajax SA'