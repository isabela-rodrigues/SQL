WITH AvailableSeats AS (
    SELECT 
        id, 
        queue, 
        available, 
        LEAD(id) OVER (PARTITION BY queue ORDER BY id) AS next_id,
        LEAD(available) OVER (PARTITION BY queue ORDER BY id) AS next_available
    FROM chairs
)
SELECT 
    queue AS row_identifier, 
    id AS left_seat, 
    next_id AS right_seat
FROM 
    AvailableSeats
WHERE 
    available = 'TRUE' 
    AND next_available = 'TRUE'
ORDER BY 
    left_seat;