SELECT name
, CAST((((math*2) + (specific*3) + (project_plan*5))/10) AS DECIMAL(18,2)) as score
FROM candidate
LEFT JOIN score
ON candidate.id = score.candidate_id
ORDER BY score DESC