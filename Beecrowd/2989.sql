WITH salario AS (
    SELECT emp.matr,
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
        , salario.salario_total
),
geral AS (
    SELECT a.matr,
           a.cod_dep,
           a.nome_dep,
           a.lotacao_div,
           divisao.cod_divisao,
           a.nome_div,
           (a.salario_total - b.valor_desconto) AS salario_com_desconto
    FROM salario a
    LEFT JOIN desconto_total b
        ON a.matr = b.matr
    LEFT JOIN divisao 
        ON a.cod_dep = divisao.cod_dep
        AND a.lotacao_div = divisao.cod_divisao
),
media_calculada AS (
    SELECT nome_dep,
           nome_div,
           CAST(MAX(salario_com_desconto) AS DECIMAL(18,2)) AS salario_com_desconto,
           CAST(AVG(salario_com_desconto) AS DECIMAL(18,2)) AS media
    FROM geral
    GROUP BY nome_dep
        , nome_div
)
SELECT nome_dep AS departamento,
       nome_div AS divisao,
       media,
       salario_com_desconto AS maior
FROM media_calculada
ORDER BY media DESC;