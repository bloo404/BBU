 -- Transaction 2
 -- SET TRANSACTION ISOLATION LEVEL READ COMMITTED -- solution
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION
SELECT * FROM play WHERE pid = 10
WAITFOR DELAY '00:00:15'
SELECT * FROM play WHERE pid = 10
COMMIT TRANSACTION