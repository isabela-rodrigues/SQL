SELECT LEAST(u1.user_name, u2.user_name) AS user_with_less_posts
		, GREATEST(u1.user_name, u2.user_name) AS user_with_more_posts
FROM followers f1
INNER JOIN followers f2 
	ON f1.user_id_fk = f2.following_user_id_fk 
	AND f1.following_user_id_fk = f2.user_id_fk
INNER JOIN users u1
	ON f1.user_id_fk = u1.user_id
INNER JOIN users u2 
	ON f1.following_user_id_fk = u2.user_id
WHERE u1.posts < u2.posts
ORDER BY u1.user_id;