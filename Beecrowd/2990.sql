SELECT emp.cpf
, emp.enome as nome
, dep.dnome as departamento
FROM empregados emp
LEFT JOIN departamentos dep
ON emp.dnumero = dep.dnumero
LEFT JOIN trabalha
ON emp.cpf = trabalha.cpf_emp
WHERE trabalha.pnumero is null
ORDER BY emp.cpf