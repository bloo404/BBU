SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
-- SET TRANSACTION ISOLATION LEVEL SERIALIZABLE --solution
BEGIN TRANSACTION
SELECT * FROM theatrical_piece
WAITFOR DELAY '00:00:07'        
SELECT * FROM theatrical_piece
COMMIT TRANSACTION

-- these to repeat what i just did
-- DELETE FROM theatrical_piece where tpid=11;
-- DELETE FROM theatrical_piece where tpid=12;
