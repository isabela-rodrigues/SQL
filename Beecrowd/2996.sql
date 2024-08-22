WITH sender AS (
    SELECT packages.id_user_sender AS id
        , users.name, packages.id_package
        , packages.color
        , packages.year
        , users.address
    FROM users
    LEFT JOIN packages 
        ON users.id = packages.id_user_sender
),
receiver AS (
    SELECT packages.id_user_receiver AS id
        , users.name
        , packages.id_package
        , packages.color
        , packages.year
        , users.address
    FROM users
    LEFT JOIN packages 
        ON users.id = packages.id_user_receiver
),
general AS (
    SELECT sender.name AS sender_name,
           sender.id_package,
           receiver.name AS receiver_name,
           packages.color,
           packages.year,
           sender.address AS sender_address,
           receiver.address AS receiver_address
    FROM sender
    LEFT JOIN packages 
        ON sender.id = packages.id_user_sender 
        AND sender.id_package = packages.id_package
    LEFT JOIN receiver 
        ON packages.id_user_receiver = receiver.id 
        AND sender.id_package = packages.id_package
)
SELECT DISTINCT year
, sender_name AS sender
, receiver_name AS receiver
FROM general
WHERE (year = 2015 OR color = 'blue')
  AND UPPER(sender_address) != 'TAIWAN'
  AND UPPER(receiver_address) != 'TAIWAN'
ORDER BY year DESC, sender_name DESC;