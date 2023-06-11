-- Transaction 1
BEGIN TRANSACTION;
UPDATE theatrical_piece 
SET theatrical_piece_title = 'New Title' 
WHERE TPID = 11;

WAITFOR DELAY '00:00:10';

UPDATE actor 
SET actor_dob = '2002-11-26' 
WHERE AID = 11;
        
COMMIT TRANSACTION