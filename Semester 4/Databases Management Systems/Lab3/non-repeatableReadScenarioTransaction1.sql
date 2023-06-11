-- Transaction 1
INSERT INTO dbo.theatrical_piece (TPID, theatrical_piece_title, theatrical_piece_author_last_name, theatrical_piece_author_first_name)
VALUES (11, 'Title', 'Last', 'First')

BEGIN TRAN
WAITFOR DELAY '00:00:05'
UPDATE theatrical_piece SET theatrical_piece_title='New Title'
WHERE tpid = 11
COMMIT TRAN

INSERT INTO dbo.theatrical_piece (TPID, theatrical_piece_title, theatrical_piece_author_last_name, theatrical_piece_author_first_name)
VALUES (12, 'Title2', 'Last2', 'First2')
BEGIN TRAN
WAITFOR DELAY '00:00:05'
UPDATE dbo.theatrical_piece SET theatrical_piece_title = 'New Title 2'
WHERE tpid = 12
COMMIT TRANSACTION