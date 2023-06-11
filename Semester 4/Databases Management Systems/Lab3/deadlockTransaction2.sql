-- Transaction 2
BEGIN TRANSACTION;
UPDATE actor 
SET actor_dob = '2003-03-26' 
WHERE AID = 11;

WAITFOR DELAY '00:00:10';

UPDATE theatrical_piece 
SET theatrical_piece_title = '2nd New Title' 
WHERE TPID = 11;

COMMIT TRANSACTION;
     
SELECT * FROM actor
SELECT * FROM theatrical_piece
