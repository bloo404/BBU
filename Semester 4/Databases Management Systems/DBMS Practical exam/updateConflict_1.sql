-- Transaction 1
BEGIN TRANSACTION;
WAITFOR DELAY '00:00:02'
UPDATE Company SET CPhone = '555555555' WHERE CompanyID = 1;
-- COMMIT
SELECT * FROM Company

-- uncommitted transaction will result in a deadlock that will not let the program run further
-- one solution is to commit it when we want it to happen