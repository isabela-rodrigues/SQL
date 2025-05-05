WITH ordered_days AS (
    SELECT submission_date,
           DENSE_RANK() OVER (ORDER BY submission_date) AS day_number
    FROM (SELECT DISTINCT submission_date FROM submissions) d
),
hacker_activity AS (
    SELECT s.hacker_id,
           o.submission_date,
           o.day_number,
           COUNT(DISTINCT s2.submission_date) AS days_active
    FROM submissions s
    INNER JOIN ordered_days o 
		ON s.submission_date = o.submission_date
    INNER JOIN submissions s2 
		ON s2.hacker_id = s.hacker_id 
		AND s2.submission_date <= o.submission_date
    GROUP BY s.hacker_id, o.submission_date, o.day_number
),
fully_active_hackers AS (
    SELECT submission_date,
           COUNT(DISTINCT hacker_id) AS total_hackers
    FROM hacker_activity
    WHERE days_active = day_number
    GROUP BY submission_date
),
daily_submissions AS (
    SELECT submission_date,
           hacker_id,
           COUNT(*) AS total
    FROM submissions
    GROUP BY submission_date, hacker_id
),
ranked_daily_submissions AS (
    SELECT ds.*,
           RANK() OVER (PARTITION BY submission_date ORDER BY total DESC, hacker_id) AS rnk
    FROM daily_submissions ds
)
SELECT f.submission_date,
       f.total_hackers,
       r.hacker_id,
       h.name
FROM fully_active_hackers f
INNER JOIN ranked_daily_submissions r 
	ON f.submission_date = r.submission_date 
	AND r.rnk = 1
INNER JOIN Hackers h 
	ON r.hacker_id = h.hacker_id
ORDER BY f.submission_date;
