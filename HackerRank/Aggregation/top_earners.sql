WITH employee_earning AS(
    SELECT *, (salary*months) as earnings
    FROM EMPLOYEE
)
, max_earnings AS(
    SELECT MAX(earnings) max_earning
    FROM employee_earning
)
SELECT earnings, count(*)
FROM employee_earning
WHERE earnings = (SELECT max_earning from max_earnings)
GROUP BY earnings