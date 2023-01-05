USE Asignment_3

-- modify a type of a column

-- FLOAT
GO

CREATE PROCEDURE setDrinkPriceToFloat
AS
		ALTER TABLE dbo.drink ALTER COLUMN drink_price FLOAT 
-- INT
GO


CREATE PROCEDURE setDrinkPriceToInt
AS
	BEGIN
		ALTER TABLE dbo.drink ALTER COLUMN drink_price INT
	END
GO
-- add/remove a column

-- ADD


CREATE PROCEDURE addEventPieceAuthor
AS
	ALTER TABLE dbo.event_piece ADD event_piece_author VARCHAR(100)

-- REMOVE
GO

CREATE PROCEDURE removeEventPieceAuthor
AS
	ALTER TABLE dbo.event_piece DROP COLUMN event_piece_author

-- add/remove a default constraint

-- ADD
GO

CREATE PROCEDURE addActorDefaultDOB
AS
	ALTER TABLE dbo.actor ADD CONSTRAINT default_DOB DEFAULT('1800-01-01') FOR actor_dob

-- REMOVE
GO

CREATE PROCEDURE removeActorDefaultDOB
AS
	ALTER TABLE dbo.actor DROP CONSTRAINT default_dob

-- create/drop table

-- CREATE
GO

CREATE PROCEDURE addCriminalTable
AS
	CREATE TABLE criminal(
		criminal_id INT,
		criminal_name VARCHAR(100) NOT NULL,
		criminal_age INT NOT NULL,
		CONSTRAINT CRIMINAL_PRIMARY_KEY PRIMARY KEY(criminal_id),
		criminal_evid INT NOT NULL
	)

-- DROP
GO

CREATE PROCEDURE dropCriminalTable
AS
	DROP TABLE dbo.criminal

-- add/remove a primary key

-- ADD
GO

CREATE PROCEDURE addCriminalNamePrimaryKey
AS
	ALTER TABLE dbo.criminal
		DROP CONSTRAINT CRIMINAL_PRIMARY_KEY
	ALTER TABLE dbo.criminal
		ADD CONSTRAINT CRIMINAL_PRIMARY_KEY PRIMARY KEY(criminal_name, criminal_age)

-- REMOVE
GO

CREATE PROCEDURE removeCriminalNamePrimaryKey
AS
	ALTER TABLE dbo.criminal
		DROP CONSTRAINT CRIMINAL_PRIMARY_KEY
	ALTER TABLE dbo.criminal
		ADD CONSTRAINT CRIMINAL_PRIMARY_KEY PRIMARY KEY(criminal_id)

-- add/remove a theatrical piece key

-- ADD
GO
CREATE PROCEDURE newTheatricalPieceKey
AS
	ALTER TABLE dbo.theatrical_piece
		ADD CONSTRAINT THEATRICAL_PIECE_KEY UNIQUE(theatrical_piece_title, theatrical_piece_author_last_name,  theatrical_piece_author_first_name)

-- REMOVE
GO 
CREATE PROCEDURE removeTheatricalPieceKey
AS
	ALTER TABLE dbo.theatrical_piece
		DROP CONSTRAINT THEATRICAL_PIECE_KEY

-- add/remove a foreign key

-- ADD
GO
CREATE PROCEDURE newForeignKeyCriminal
AS
	ALTER TABLE dbo.criminal
		ADD CONSTRAINT CRIMINAL_FOREIGN_KEY FOREIGN KEY(criminal_evid) REFERENCES dbo.event_piece(evid)

-- REMOVE
GO
create PROCEDURE removeForeignKeyCriminal
AS
	ALTER TABLE dbo.criminal
		DROP CONSTRAINT CRIMINAL_FOREIGN_KEY
GO
-- a table with the current version

CREATE TABLE versionTable(
	version INT
)

INSERT INTO versionTable
VALUES 
	(1) -- initial

-- initial version, version after execution & procedure that changes the table
CREATE TABLE procedureTable(
	initial_version INT,
	final_version INT,
	procedure_name VARCHAR(MAX),
	PRIMARY KEY (initial_version, final_version)
)

INSERT INTO procedureTable
VALUES
	(1, 2, 'setDrinkPriceToFloat'),
	(2, 1, 'setDrinkPriceToInt'),
	(2, 3, 'addEventPieceAuthor'), 
	(3, 2, 'removeEventPieceAuthor'),
	(3, 4, 'addActorDefaultDOB'),
	(4, 3, 'removeActorDefaultDOB'),
	(4, 5, 'addCriminalTable'),
	(5, 4, 'dropCriminalTable'),
	(5, 6, 'addCriminalNamePrimaryKey'),
	(6, 5, 'removeCriminalNamePrimaryKey'),
	(6, 7, 'newTheatricalPieceKey'),
	(7, 6, 'removeTheatricalPieceKey'),
	(7, 8, 'newForeignKeyCriminal'),
	(8, 7, 'removeForeignKeyCriminal')

-- procedure for changing versions
GO

CREATE PROCEDURE goToVersion(@newVersion INT)
AS
	DECLARE @current_version INT
	DECLARE @procedureName VARCHAR(MAX)
	SELECT @current_version = version FROM versionTable

	IF (@newVersion > (SELECT MAX(final_version) FROM procedureTable) OR @newVersion < 1)
		RAISERROR ('Bad version', 10, 1)
	ELSE
	BEGIN
		IF @newVersion = @current_version
			PRINT('You are already on this version!');
		ELSE
		BEGIN
			IF @current_version > @newVersion
			BEGIN
						WHILE @current_version > @newVersion 
					BEGIN
						SELECT @procedureName = procedure_name FROM procedureTable WHERE initial_version = @current_version AND final_version = @current_version-1
						PRINT('Executing ' + @procedureName);
						EXEC (@procedureName)
						SET @current_version = @current_version - 1
					END
			END

			IF @current_version < @newVersion
			BEGIN
				WHILE @current_version < @newVersion 
					BEGIN
						SELECT @procedureName = procedure_name FROM procedureTable WHERE initial_version = @current_version AND final_version = @current_version+1
						PRINT('Executing ' + @procedureName);
						EXEC (@procedureName)
						SET @current_version = @current_version + 1
					END
			END

			UPDATE versionTable SET version = @newVersion
		END
	END
go 

EXEC goToVersion 1

-- 1)
-- SELECT * FROM dbo.drink
-- 2)
-- SELECT * FROM dbo.drink
-- 3)
-- SELECT * FROM dbo.event_piece
-- 4)
-- SELECT * FROM dbo.event_piece
-- 5)
-- SELECT * FROM dbo.criminal 
-- 6)
-- SELECT * FROM dbo.criminal
-- 7)
-- SELECT * FROM dbo.criminal
-- 8)
-- SELECT * FROM dbo.criminal

SELECT *
FROM versionTable

SELECT *
FROM procedureTable
