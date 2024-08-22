WITH doctor_salary AS(SELECT doctor.name
, sum(round(cast(((attendance.hours * 150) + ((attendance.hours * 150)*(shifts.bonus/100))) as decimal(18,2)), 1)) AS salary_bonus
FROM doctors doctor
LEFT JOIN attendances attendance
ON doctor.id = attendance.id_doctor
LEFT JOIN work_shifts shifts
ON attendance.id_work_shift = shifts.id
GROUP BY doctor.name
ORDER BY salary_bonus)
SELECT *
FROM doctor_salary
ORDER BY salary_bonus DESC