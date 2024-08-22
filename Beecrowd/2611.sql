SELECT a.id, a.name
FROM movies a
JOIN genres b
	ON a.id_genres = b.id
WHERE b.description = 'Action'