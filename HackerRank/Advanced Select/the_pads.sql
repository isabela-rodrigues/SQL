WITH occupation_total AS(
SELECT Occupation, count(*) as qt
FROM OCCUPATIONS
GROUP BY Occupation
)
SELECT name+'('+left(occupation, 1)+')' as name
FROM Occupations
UNION ALL
SELECT 'There are a total of ' + cast(qt as varchar) + ' ' + lower(occupation + 's.') as name
FROM occupation_total
ORDER BY name