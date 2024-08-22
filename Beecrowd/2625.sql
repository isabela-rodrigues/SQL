SELECT CONCAT( SUBSTRING(n.cpf,1,3),'.', SUBSTRING(n.cpf,4,3),'.', SUBSTRING(n.cpf,7,3),'-', SUBSTRING(n.cpf,10,2))
FROM natural_person n ;