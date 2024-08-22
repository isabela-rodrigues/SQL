WITH podium AS (
    SELECT position, 'Podium: ' || team AS name
    FROM league
    ORDER BY position
    LIMIT 3
),
demoted AS (
    SELECT position, 'Demoted: ' || team AS name
    FROM league
    ORDER BY position DESC
    LIMIT 2
)
, demoted_ordered AS (
SELECT *
FROM demoted
ORDER BY position
)
SELECT name FROM podium
UNION ALL
SELECT name FROM demoted_ordered;