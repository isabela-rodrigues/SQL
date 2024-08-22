WITH ranked_cities AS (
SELECT city_name
        , population
        , ROW_NUMBER() OVER (ORDER BY population ASC) AS rank_asc
        , ROW_NUMBER() OVER (ORDER BY population DESC) AS rank_desc
FROM cities)
SELECT 
    city_name AS city_name,
    population AS population
FROM
    ranked_cities
WHERE
    rank_desc = 2

UNION ALL

SELECT 
    city_name AS city_name,
    population AS population
FROM
    ranked_cities
WHERE
    rank_asc = 2;