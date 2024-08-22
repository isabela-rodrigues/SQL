SELECT a.name, CAST(omega * 1.618 AS DECIMAL(18, 3)) AS the_n_factor
FROM life_registry a
LEFT JOIN dimensions b
ON a.dimensions_id = b.id
WHERE b.name IN ('C875', 'C774')
AND UPPER(a.name) LIKE 'RICHARD%'
ORDER BY omega ASC;