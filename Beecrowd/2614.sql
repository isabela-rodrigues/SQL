SELECT a.name, b.rentals_date
FROM rentals b
JOIN customers a
	ON b.id_customers = a.id
WHERE EXTRACT(YEAR FROM rentals_date) = 2016
	AND EXTRACT(MONTH FROM rentals_date) = 9