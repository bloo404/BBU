-- Transaction 1
BEGIN TRAN
WAITFOR DELAY '00:00:04'
INSERT INTO theatrical_piece (TPID, theatrical_piece_title, theatrical_piece_author_last_name, theatrical_piece_author_first_name)
VALUES (11, 'Title', 'Last', 'First')
COMMIT TRAN

BEGIN TRAN
WAITFOR DELAY '00:00:05'
INSERT INTO theatrical_piece (TPID, theatrical_piece_title, theatrical_piece_author_last_name, theatrical_piece_author_first_name)
VALUES (12, 'Title2', 'Last2', 'First2')        
COMMIT TRANSACTION