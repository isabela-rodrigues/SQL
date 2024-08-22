SELECT DISTINCT node_id
, CASE WHEN pointer is NULL
		THEN 'LEAF'
	WHEN node_id = 50
		THEN 'ROOT'
	WHEN node_id IN (30,75,15,35,60,90)
		THEN 'INNER'
	END AS type
FROM nodes
ORDER BY node_id