WITH Ordered AS (
    SELECT LAT_N, 
           ROW_NUMBER() OVER (ORDER BY LAT_N) AS rn,
           COUNT(*) OVER () AS total_count
    FROM STATION
)
SELECT CAST(
    CASE 
        WHEN total_count % 2 = 1 THEN 
            (SELECT LAT_N 
             FROM Ordered 
             WHERE rn = (total_count + 1) / 2)
        ELSE 
            (SELECT AVG(LAT_N * 1.0) 
             FROM Ordered 
             WHERE rn IN (total_count / 2, (total_count / 2) + 1))
    END 
AS DECIMAL(18,4))
FROM Ordered
WHERE rn = 1;