WITH ranked_data AS (
    SELECT 
        Name, 
        Occupation, 
        ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS RowNum
    FROM Occupations
)
SELECT Doctor
, Professor
, Singer
, Actor
FROM ranked_data
PIVOT (
    MAX(Name) 
    FOR Occupation IN ([Actor], [Doctor], [Professor], [Singer])
) AS pivot_table;