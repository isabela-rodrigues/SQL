WITH number_series AS (
    SELECT 2 AS num
    UNION ALL
    SELECT num + 1
    FROM number_series 
    WHERE num + 1 <= 1000
)
SELECT STRING_AGG(CAST(num AS VARCHAR), '&') AS prime
FROM (
    SELECT num
    FROM number_series n
    WHERE NOT EXISTS (
        SELECT 1
        FROM number_series d
        WHERE d.num > 1 AND d.num <= SQRT(n.num)
        AND n.num % d.num = 0
    )
) AS prime_numbers
OPTION (MAXRECURSION 1000);