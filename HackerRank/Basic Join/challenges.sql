WITH count_students AS(
    SELECT H.hacker_id
            , H.name
            , count(CH.challenge_id) count_challenge
    FROM HACKERS H
    LEFT JOIN CHALLENGES CH
        ON H.HACKER_ID = CH.HACKER_ID
    GROUP BY H.hacker_id
            , H.name
)
, count_duplicated AS (
    SELECT count_challenge as count_duplicated
            , count(*) qt_duplicate
    FROM count_students
    WHERE count_challenge < (SELECT MAX(count_challenge) count_challenge_max
                                FROM count_students)
    GROUP BY count_challenge
    HAVING COUNT(*) > 1
)
SELECT c.*
FROM count_students c
LEFT JOIN count_duplicated cd
    ON c.count_challenge = cd.count_duplicated
WHERE count_duplicated IS NULL
ORDER BY c.count_challenge DESC
        , c.hacker_id ASC