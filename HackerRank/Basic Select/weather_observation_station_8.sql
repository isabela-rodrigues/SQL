SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(LOWER(CITY), 1) IN ('a', 'e', 'i', 'o', 'u')
AND RIGHT(LOWER(CITY), 1) IN ('a', 'e', 'i', 'o', 'u');