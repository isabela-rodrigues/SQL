DROP TABLE IF EXISTS visao_salario;
DROP TABLE IF EXISTS salario_ajustado;
DROP TABLE IF EXISTS visao_final;

CREATE TEMPORARY TABLE visao_salario AS
SELECT emp.matr as no_matricula,
       upper(emp.nome) as nm_funcionario,
       emp.lotacao as cd_departamento,
       dep.nome as nm_departamento,
       emp_venc.cod_venc as cd_salario,
       upper(venc.nome) as ds_salario,
       venc.valor as vl_salario
FROM empregado emp
LEFT JOIN departamento dep ON emp.lotacao = dep.cod_dep
LEFT JOIN emp_venc ON emp.matr = emp_venc.matr
LEFT JOIN vencimento venc ON emp_venc.cod_venc = venc.cod_venc
ORDER BY dep.nome DESC;

CREATE TEMPORARY TABLE salario_ajustado AS
SELECT no_matricula,
       nm_funcionario,
       cd_departamento,
       nm_departamento,
       SUM(COALESCE(vl_salario, 0)) as vl_salario_ajustado
FROM visao_salario
GROUP BY no_matricula,
         nm_funcionario,
         cd_departamento,
         nm_departamento
ORDER BY nm_departamento DESC, vl_salario_ajustado DESC;

CREATE TEMPORARY TABLE visao_final AS
SELECT s.*,
       SUM(COALESCE(desconto.valor, 0)) as vl_desconto_total,
       s.vl_salario_ajustado - SUM(COALESCE(desconto.valor, 0)) as vl_salario_com_desconto
FROM salario_ajustado s
LEFT JOIN emp_desc ON s.no_matricula = emp_desc.matr
LEFT JOIN desconto ON emp_desc.cod_desc = desconto.cod_desc
GROUP BY s.no_matricula,
         s.nm_funcionario,
         s.cd_departamento,
         s.nm_departamento,
         s.vl_salario_ajustado
ORDER BY nm_departamento DESC, vl_salario_ajustado DESC;

SELECT nm_departamento,
       COUNT(no_matricula) as numero_empregados,
       CAST(AVG(vl_salario_com_desconto) AS DECIMAL(18,2)) as media_salarial,
       MAX(vl_salario_com_desconto) as maior_salario,
       MIN(vl_salario_com_desconto) as menor_salario
FROM visao_final
GROUP BY nm_departamento
ORDER BY nm_departamento DESC;