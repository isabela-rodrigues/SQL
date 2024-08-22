DROP TABLE IF EXISTS operations_calc;
DROP TABLE IF EXISTS return_total;
DROP TABLE IF EXISTS final;

CREATE TEMP TABLE operations_calc AS
SELECT
    client_id,
    month,
    SUM(profit) OVER (PARTITION BY client_id ORDER BY month) AS cumulative_profit
FROM operations
ORDER BY client_id, month;

CREATE TEMP TABLE return_total AS
SELECT 
    calc.client_id, 
    cli.name,
    cli.investment AS investment,
    calc.month,
    calc.cumulative_profit,
    (calc.cumulative_profit - cli.investment) AS investment_return
FROM operations_calc calc
LEFT JOIN clients cli 
	ON calc.client_id = cli.id;

CREATE TEMP TABLE final AS
SELECT 
    name,
    month AS month_payback,
    investment,
    investment_return,
    ROW_NUMBER() OVER (PARTITION BY name ORDER BY investment_return) AS id
FROM return_total
WHERE investment_return >= 0;

SELECT 
    name, 
    investment, 
    month_payback, 
    investment_return
FROM final
WHERE id = 1
ORDER BY investment_return DESC;