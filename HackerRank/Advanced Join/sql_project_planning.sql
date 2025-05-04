WITH CTE AS (
    SELECT 
        task_id
        , start_date
        , end_date
        , CASE 
            WHEN LAG(end_date) OVER (ORDER BY end_date) >= DATEADD(DAY, -1, end_date) 
			THEN 0 ELSE 1 
			END AS new_group
    FROM PROJECTS
)
, CTE2 AS (
    SELECT *
           , SUM(new_group) OVER (ORDER BY end_date) AS group_id
    FROM CTE
)
, CTE3 AS(
SELECT *
, COUNT(group_id) OVER (PARTITION BY group_id) AS days_proj
FROM CTE2
)
SELECT MIN(start_date) as start_date, MAX(end_date) AS end_date
FROM CTE3
GROUP BY group_id, days_proj
ORDER BY days_proj, start_date;