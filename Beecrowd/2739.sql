SELECT name
       , CAST(EXTRACT(DAY FROM payday) AS INT) AS dia
FROM loan;