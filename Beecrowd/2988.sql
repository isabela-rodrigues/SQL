WITH GERAL AS (
    SELECT 
        teams.name,
        COUNT(matches.id) AS matches,
        SUM(CASE 
                WHEN (matches.team_1_goals > matches.team_2_goals AND matches.team_1 = teams.id) 
                  OR (matches.team_2_goals > matches.team_1_goals AND matches.team_2 = teams.id) 
                THEN 1 ELSE 0 
            END) AS victories,
        SUM(CASE 
                WHEN (matches.team_1_goals < matches.team_2_goals AND matches.team_1 = teams.id) 
                  OR (matches.team_2_goals < matches.team_1_goals AND matches.team_2 = teams.id) 
                THEN 1 ELSE 0 
            END) AS defeats,
        SUM(CASE 
                WHEN matches.team_1_goals = matches.team_2_goals 
                  AND (matches.team_1 = teams.id OR matches.team_2 = teams.id) 
                THEN 1 ELSE 0 
            END) AS draws
    FROM matches
    LEFT JOIN teams ON matches.team_1 = teams.id OR matches.team_2 = teams.id
    GROUP BY teams.name
)
SELECT 
    name, 
    matches, 
    victories, 
    defeats, 
    draws, 
    (victories * 3) + draws AS score
FROM GERAL
ORDER BY score DESC