--CREATE TABLE company (company_code VARCHAR(5), founder VARCHAR(100));
--INSERT INTO company (company_code, founder) VALUES ('C1', 'Monika');
--INSERT INTO company (company_code, founder) VALUES ('C2', 'Samantha');

--CREATE TABLE lead_manager (lead_manager_code varchar(5), company_code varchar (5));
--INSERT INTO lead_manager (lead_manager_code, company_code) VALUES('LM1', 'C1');
--INSERT INTO lead_manager (lead_manager_code, company_code) VALUES('LM2', 'C2');

--CREATE TABLE senior_manager (senior_manager_code varchar(5), lead_manager_code varchar(5), company_code varchar(5));
--INSERT INTO senior_manager (senior_manager_code, lead_manager_code, company_code) VALUES ('SM1', 'LM1', 'C1');
--INSERT INTO senior_manager (senior_manager_code, lead_manager_code, company_code) VALUES ('SM2', 'LM1', 'C1');
--INSERT INTO senior_manager (senior_manager_code, lead_manager_code, company_code) VALUES ('SM3', 'LM2', 'C2');

--CREATE TABLE manager (manager_code varchar(5), senior_manager_code varchar(5), lead_manager_code varchar(5), company_code varchar(5));
--INSERT INTO manager (manager_code, senior_manager_code, lead_manager_code, company_code) VALUES ('M1', 'SM1', 'LM1', 'C1');
--INSERT INTO manager (manager_code, senior_manager_code, lead_manager_code, company_code) VALUES ('M2', 'SM3', 'LM2', 'C2');
--INSERT INTO manager (manager_code, senior_manager_code, lead_manager_code, company_code) VALUES ('M3', 'SM3', 'LM2', 'C2');

--CREATE TABLE employee (employee_code varchar(5), manager_code varchar(5), senior_manager_code varchar(5), lead_manager_code varchar(5), company_code varchar(5));
--INSERT INTO employee (employee_code, manager_code, senior_manager_code, lead_manager_code, company_code) VALUES ('E1', 'M1', 'SM1', 'LM1', 'C1');
--INSERT INTO employee (employee_code, manager_code, senior_manager_code, lead_manager_code, company_code) VALUES ('E2', 'M1', 'SM1', 'LM1', 'C1');
--INSERT INTO employee (employee_code, manager_code, senior_manager_code, lead_manager_code, company_code) VALUES ('E3', 'M2', 'SM3', 'LM2', 'C2');
--INSERT INTO employee (employee_code, manager_code, senior_manager_code, lead_manager_code, company_code) VALUES ('E4', 'M3', 'SM3', 'LM2', 'C2');

SELECT co.company_code
, co.founder
, COUNT(DISTINCT le.lead_manager_code) as total_lead_manager
, COUNT(DISTINCT sm.senior_manager_code) as total_senior_manager
, COUNT(DISTINCT m.manager_code) as total_managers
, COUNT(DISTINCT emp.employee_code) as total_employees
FROM company co
LEFT JOIN lead_manager le
ON co.company_code = le.company_code
LEFT JOIN senior_manager sm
ON co.company_code = sm.company_code
LEFT JOIN manager m
ON co.company_code = m.company_code
LEFT JOIN employee emp
ON co.company_code = emp.company_code
GROUP BY co.company_code
        , co.founder
ORDER BY co.company_code ASC