WITH salario AS (
    SELECT emp.matr,
           emp.nome AS emp_nome,
           emp.lotacao_div,
           divisao.nome AS nome_div,
           emp.lotacao AS cod_dep,
           dep.nome AS nome_dep,
           SUM(COALESCE(venc.valor, 0)) AS salario_total
    FROM empregado emp
    LEFT JOIN emp_venc 
		ON emp.matr = emp_venc.matr
    LEFT JOIN vencimento venc 
		ON emp_venc.cod_venc = venc.cod_venc
    LEFT JOIN divisao 
		ON emp.lotacao_div = divisao.cod_divisao
		AND emp.lotacao = divisao.cod_dep
    LEFT JOIN departamento dep 
		ON emp.lotacao = dep.cod_dep
    GROUP BY emp.matr
		, emp.nome
		, emp.lotacao
		, emp.lotacao_div
		, dep.nome
		, divisao.nome
),
desconto_total AS (
    SELECT salario.matr,
           SUM(COALESCE(desconto.valor, 0)) AS valor_desconto
    FROM salario
    LEFT JOIN emp_desc 
		ON emp_desc.matr = salario.matr
    LEFT JOIN desconto 
		ON emp_desc.cod_desc = desconto.cod_desc
    GROUP BY salario.matr
)
SELECT a.nome_dep AS departamento,
       a.emp_nome AS empregado,
       CASE 
           WHEN a.salario_total = 0 THEN '0' -- Os valores que são 0, devem ser mantidos 0 (sem casas decimais)
           ELSE TO_CHAR(a.salario_total, 'FM999999999.00') -- É necessário formatar pois os valores que são maiores que 0 devem ter 2 casas decimais
       END AS salario_bruto,
       CASE 
           WHEN b.valor_desconto = 0 THEN '0'
           ELSE TO_CHAR(b.valor_desconto, 'FM999999999.00')
       END AS total_descontos,
       CASE 
           WHEN (a.salario_total - b.valor_desconto) = 0 THEN '0'
           ELSE TO_CHAR((a.salario_total - b.valor_desconto), 'FM999999999.00')
       END AS salario_liquido
FROM salario a
LEFT JOIN desconto_total b ON a.matr = b.matr
ORDER BY (a.salario_total - b.valor_desconto) DESC
	, a.emp_nome DESC
	, a.nome_div ASC;