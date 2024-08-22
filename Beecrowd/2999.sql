WITH salario AS (
    SELECT emp.matr,
           emp.nome,
           emp.lotacao_div,
           emp.lotacao as cod_dep,
           SUM(COALESCE(venc.valor, 0)) as salario_total
    FROM empregado emp
    LEFT JOIN emp_venc 
		ON emp.matr = emp_venc.matr
    LEFT JOIN vencimento venc 
		ON emp_venc.cod_venc = venc.cod_venc
    GROUP BY emp.matr
		, emp.nome
		, emp.lotacao
		, emp.lotacao_div
),
desconto_total AS (
    SELECT salario.matr,
           salario.nome,
           salario.lotacao_div,
           SUM(COALESCE(desconto.valor, 0)) AS valor_desconto
    FROM salario
    LEFT JOIN emp_desc 
		ON emp_desc.matr = salario.matr
    LEFT JOIN desconto 
		ON emp_desc.cod_desc = desconto.cod_desc
    GROUP BY salario.matr
		, salario.nome
		, salario.lotacao_div
		, salario.salario_total
),
geral AS (
    SELECT a.*,
           ROUND(a.salario_total - b.valor_desconto, 2) AS salario_com_desconto
    FROM salario a
    LEFT JOIN desconto_total b 
		ON a.matr = b.matr
),
media AS (
    SELECT cod_dep,
           CAST(AVG(salario_com_desconto) AS DECIMAL(18,2)) AS media_salarial
    FROM geral
    GROUP BY cod_dep
)
SELECT geral.nome,
       CAST(geral.salario_com_desconto AS DECIMAL(18,2)) AS salario
FROM geral
LEFT JOIN media 
	ON geral.cod_dep = media.cod_dep
WHERE geral.salario_com_desconto >= 8000
  AND geral.salario_com_desconto > media.media_salarial
ORDER BY geral.lotacao_div, geral.nome;