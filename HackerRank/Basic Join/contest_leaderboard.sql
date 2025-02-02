WITH max_scores AS (
	SELECT h.hacker_id
			, h.name
			, s.challenge_id
			, max(s.score) max_score
	FROM Hackers h
	LEFT JOIN Submissions s
		ON h.hacker_id = s.hacker_id
	WHERE s.score != 0
	GROUP BY h.hacker_id, 
				h.name, s.challenge_id
)
SELECT hacker_id
	, name
	, sum(max_score) total_score
FROM max_scores
GROUP BY hacker_id, name
ORDER BY total_score DESC
		, hacker_id