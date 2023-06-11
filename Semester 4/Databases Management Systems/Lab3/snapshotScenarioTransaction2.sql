-- Transaction 2
SET TRANSACTION ISOLATION LEVEL SNAPSHOT
BEGIN TRAN
WAITFOR DELAY '00:00:05'
-- T1 has updated and has a lock on the table
-- T2 will be blocked when trying to update the table
UPDATE actor SET actor_dob = '2002-11-26' WHERE AID = 11
COMMIT TRAN
