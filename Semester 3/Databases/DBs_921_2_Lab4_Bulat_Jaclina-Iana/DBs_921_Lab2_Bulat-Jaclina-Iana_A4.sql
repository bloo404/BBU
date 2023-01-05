drop table drink
drop table bar
drop table ticket
drop table see
drop table client
drop table event_piece
drop table room
drop table play
drop table theatrical_piece
drop table actor

DROP VIEW viewSelect
DROP VIEW viewSelJoin
DROP VIEW viewSelGrJoin

DROP PROCEDURE UspAddRoom
DROP PROCEDURE UspAddBar

DROP PROCEDURE UspTestRunViews
DROP PROCEDURE UspTestRunTables

DROP PROCEDURE RemoveFromPlay
DROP PROCEDURE AddInPlay
DROP PROCEDURE RemoveFromTicket
DROP PROCEDURE AddInTicket
DROP PROCEDURE RemoveFromActor
DROP PROCEDURE AddInActor

-- Room
create table room(
	RID int primary key, 
	room_name varchar(50) unique, 
	room_number int, 
	room_state int
)


-- Event
create table event_piece(
	EVID int primary key, 
	RID int foreign key references room(RID), 
	event_piece_title varchar(100), 
	event_piece_author_last_name varchar(50), 
	event_piece_author_first_name varchar(50), 
	event_piece_date date, event_piece_time time
)

-- Bar
create table bar(
	BID int primary key, 
	bar_title varchar(100), 
	bar_status int
)

-- Actor
create table actor(
	AID int primary key, 
	actor_dob date)

-- Theatrical piece
create table theatrical_piece(
	TPID int primary key, 
	theatrical_piece_title varchar(100), 
	theatrical_piece_author_last_name varchar(50),
	theatrical_piece_author_first_name varchar(50))

-- Play
create table play(
	PID int not null, 
	TPID int foreign key references theatrical_piece(TPID), 
	AID int foreign key references actor(AID),
	play_date date,
	constraint multipal primary key (tpid, aid))

-- Client
create table client(
	CID int primary key, 
	cnp varchar(14))


-- See in a lifetimes
create table see(
	seed int primary key, 
	CID int foreign key references client(CID), 
	TPID int foreign key references theatrical_piece(TPID),
	see_date date)


-- Physical drink
create table drink(
	DID int primary key, 
	CID int foreign key references client(CID),
	BID int foreign key references bar(BID), 
	drink_type varchar(50), 
	drink_price float, 
	drink_amount float)

-- Ticket 
create table ticket(
	TID int primary key, 
	CID int foreign key references client(CID), 
	EVID int foreign key references event_piece(EVID),
	ticket_price float)

INSERT INTO dbo.client
Values
	(1, 'test_client_1')

INSERT INTO dbo.bar 
Values
	(1,'test_bar_1', 1)

INSERT INTO dbo.actor
Values
	(1, '2002-04-03') 

-- a table with a single column primary key and no foreign keys - Actor
-- a table with a single column primary key and at least one foreign key - Ticket
-- a table with a multicolumn primary key - Play

-- a view with a SELECT statement operation on one table
GO
CREATE VIEW viewSelect AS
SELECT *
FROM dbo.room

-- a view with a SELECT statement that operates on at least 2 different tables and contains at least one JOIN operator
GO
CREATE VIEW viewSelJoin AS
SELECT R.room_name
FROM dbo.room R
INNER JOIN dbo.event_piece E ON E.RID = R.RID
GO 
-- a view with a SELECT statement that has a GROUP BY clause, operates on at least 2 different tables and contains at least one JOIN operator

CREATE VIEW viewSelGrJoin AS
SELECT R.RID
FROM dbo.room R
INNER JOIN dbo.event_piece E ON E.RID = R.RID
GROUP BY R.RID
GO
-- Add and remove for Edition

CREATE PROCEDURE AddInActor -- Actor
AS
	DECLARE @i INT
	SET @i = 1
	WHILE @i < 100
		BEGIN
			INSERT INTO dbo.actor
			Values(@i, '2022-12-25')
			SET @i = @i + 1 
		END
GO

CREATE PROCEDURE RemoveFromActor
AS
	DECLARE @i INT
	SET @i = 1
	WHILE @i < 100 
		BEGIN 
			DELETE FROM dbo.actor WHERE AID = @i
			SET @i = @i + 1 
		END
GO

-- Add and remove for Ticket
CREATE PROCEDURE AddInTicket
AS
	DECLARE @i INT
	SET @i = 1
	WHILE @i < 100
		BEGIN
			INSERT INTO dbo.ticket
			Values(@i, @i + 69, @i + 3, 1)
			SET @i = @i + 1 
		END
GO

CREATE PROCEDURE RemoveFromTicket
AS
	DECLARE @i INT
	SET @i = 1
	WHILE @i < 100
		BEGIN
			DELETE FROM dbo.ticket WHERE TID = @i
			SET @i = @i + 1 
		END
GO 

-- Add and remove for Makes
CREATE PROCEDURE AddInPlay
AS
	DECLARE @i INT
	SET @i = 1
	WHILE @i < 100
		BEGIN
			INSERT INTO dbo.play
			Values(@i, 1, 1, getdate()) 
			SET @i = @i + 1 
		END
GO

CREATE PROCEDURE RemoveFromPlay
AS
	DECLARE @i INT
	SET @i = 1
	WHILE @i < 100
		BEGIN
			DELETE FROM dbo.play WHERE PID = @i
			SET @i = @i + 1 
		END

GO
---- script
IF EXISTS(
	SELECT * 
	FROM dbo.sysobjects 
	WHERE id = object_id(N'[FK_TestRunTables_Tables]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1)
	ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_Tables

GO

IF EXISTS(
	SELECT *
	FROM dbo.sysobjects
	WHERE id = object_id(N'[FK_TestTables_Tables]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1)
	ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tables

GO

IF EXISTS(
	SELECT *
	FROM dbo.sysobjects
	WHERE id = object_id(N'[FK_TestRunTables_TestRuns]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1)
	ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_TestRuns

GO

IF EXISTS(
	SELECT *
	FROM dbo.sysobjects
	WHERE id = object_id(N'[FK_TestRunViews_TestRuns]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1)
	ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_TestRuns

GO

IF EXISTS(
	SELECT *
	FROM dbo.sysobjects
	WHERE id = object_id(N'[FK_TestTables_Tests]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1)
	ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tests

GO

IF EXISTS(
	SELECT *
	FROM dbo.sysobjects
	WHERE id = object_id(N'[FK_TestViews_Tests]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1)
	ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Tests

GO

IF EXISTS(
	SELECT *
	FROM dbo.sysobjects
	WHERE id = object_id(N'[FK_TestRunViews_Views]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1)
	ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_Views

GO

IF EXISTS(
	SELECT *
	FROM dbo.sysobjects
	WHERE id = object_id(N'[FK_TestViews_Views]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1)
	ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Views

GO

IF EXISTS(
	SELECT *
	FROM dbo.sysobjects	
	WHERE id = object_id(N'[Tables]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1 )
	DROP TABLE [Tables]

GO

IF EXISTS(
	SELECT *
	FROM dbo.sysobjects	
	WHERE id = object_id(N'[TestRunTables]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1 )
	DROP TABLE [TestRunTables]

GO

IF EXISTS(
	SELECT *
	FROM dbo.sysobjects	
	WHERE id = object_id(N'[TestRunViews]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1 )
	DROP TABLE [TestRunViews]

GO

IF EXISTS(
	SELECT *
	FROM dbo.sysobjects	
	WHERE id = object_id(N'[TestRuns]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1 )
	DROP TABLE [TestRuns]

GO

IF EXISTS(
	SELECT *
	FROM dbo.sysobjects	
	WHERE id = object_id(N'[TestTables]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1 )
	DROP TABLE [TestTables]

GO

IF EXISTS(
	SELECT *
	FROM dbo.sysobjects	
	WHERE id = object_id(N'[TestViews]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1 )
	DROP TABLE [TestViews]

GO

IF EXISTS(
	SELECT *
	FROM dbo.sysobjects	
	WHERE id = object_id(N'[Tests]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1 )
	DROP TABLE [Tests]

GO

IF EXISTS(
	SELECT *
	FROM dbo.sysobjects	
	WHERE id = object_id(N'[Views]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1 )
	DROP TABLE [Views]

GO

CREATE TABLE [Tables] (
	[TableID] [INT] IDENTITY (1, 1) NOT NULL,
	[Name] [NVARCHAR](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [TestRunTables] (
	[TestRunID] [int] NOT NULL ,
	[TableID] [int] NOT NULL ,
	[StartAt] [datetime] NOT NULL ,
	[EndAt] [datetime] NOT NULL 
) ON [PRIMARY]

GO


CREATE TABLE [TestRunViews] (
	[TestRunID] [int] NOT NULL ,
	[ViewID] [int] NOT NULL ,
	[StartAt] [datetime] NOT NULL ,
	[EndAt] [datetime] NOT NULL 
) ON [PRIMARY]

GO

CREATE TABLE [TestRuns] (
	[TestRunID] [int] IDENTITY (1, 1) NOT NULL ,
	[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StartAt] [datetime] NULL ,
	[EndAt] [datetime] NULL 
) ON [PRIMARY]

GO

CREATE TABLE [TestTables] (
	[TestID] [int] NOT NULL ,
	[TableID] [int] NOT NULL ,
	[NoOfRows] [int] NOT NULL ,
	[Position] [int] NOT NULL 
) ON [PRIMARY]

GO

CREATE TABLE [TestViews] (
	[TestID] [int] NOT NULL ,
	[ViewID] [int] NOT NULL 
) ON [PRIMARY]

GO

CREATE TABLE [Tests] (
	[TestID] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]

GO

CREATE TABLE [Views] (
	[ViewID] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]

GO

ALTER TABLE [Tables] WITH NOCHECK ADD 
	CONSTRAINT [PK_Tables] PRIMARY KEY  CLUSTERED 
	(
		[TableID]
	)  ON [PRIMARY] 

GO

ALTER TABLE [TestRunTables] WITH NOCHECK ADD 
	CONSTRAINT [PK_TestRunTables] PRIMARY KEY  CLUSTERED 
	(
		[TestRunID],
		[TableID]
	)  ON [PRIMARY] 

GO

ALTER TABLE [TestRunViews] WITH NOCHECK ADD 
	CONSTRAINT [PK_TestRunViews] PRIMARY KEY  CLUSTERED 
	(
		[TestRunID],
		[ViewID]
	)  ON [PRIMARY] 

GO

ALTER TABLE [TestRuns] WITH NOCHECK ADD 
	CONSTRAINT [PK_TestRuns] PRIMARY KEY  CLUSTERED 
	(
		[TestRunID]
	)  ON [PRIMARY] 

GO

ALTER TABLE [TestTables] WITH NOCHECK ADD 
	CONSTRAINT [PK_TestTables] PRIMARY KEY  CLUSTERED 
	(
		[TestID],
		[TableID]
	)  ON [PRIMARY] 

GO

ALTER TABLE [TestViews] WITH NOCHECK ADD 
	CONSTRAINT [PK_TestViews] PRIMARY KEY  CLUSTERED 
	(
		[TestID],
		[ViewID]
	)  ON [PRIMARY] 

GO

ALTER TABLE [Tests] WITH NOCHECK ADD 
	CONSTRAINT [PK_Tests] PRIMARY KEY  CLUSTERED 
	(
		[TestID]
	)  ON [PRIMARY] 

GO

ALTER TABLE [Views] WITH NOCHECK ADD 
	CONSTRAINT [PK_Views] PRIMARY KEY  CLUSTERED 
	(
		[ViewID]
	)  ON [PRIMARY] 

GO

ALTER TABLE [TestRunTables] ADD 
	CONSTRAINT [FK_TestRunTables_Tables] FOREIGN KEY 
	(
		[TableID]
	) REFERENCES [Tables] (
		[TableID]
	) ON DELETE CASCADE  ON UPDATE CASCADE ,
	CONSTRAINT [FK_TestRunTables_TestRuns] FOREIGN KEY 
	(
		[TestRunID]
	) REFERENCES [TestRuns] (
		[TestRunID]
	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO

ALTER TABLE [TestRunViews] ADD 
	CONSTRAINT [FK_TestRunViews_TestRuns] FOREIGN KEY 
	(
		[TestRunID]
	) REFERENCES [TestRuns] (
		[TestRunID]
	) ON DELETE CASCADE  ON UPDATE CASCADE ,
	CONSTRAINT [FK_TestRunViews_Views] FOREIGN KEY 
	(
		[ViewID]
	) REFERENCES [Views] (
		[ViewID]
	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO

ALTER TABLE [TestTables] ADD 
	CONSTRAINT [FK_TestTables_Tables] FOREIGN KEY 
	(
		[TableID]
	) REFERENCES [Tables] (
		[TableID]
	) ON DELETE CASCADE  ON UPDATE CASCADE ,
	CONSTRAINT [FK_TestTables_Tests] FOREIGN KEY 
	(
		[TestID]
	) REFERENCES [Tests] (
		[TestID]
	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO

ALTER TABLE [TestViews] ADD 
	CONSTRAINT [FK_TestViews_Tests] FOREIGN KEY 
	(
		[TestID]
	) REFERENCES [Tests] (
		[TestID]
	),
	CONSTRAINT [FK_TestViews_Views] FOREIGN KEY 
	(
		[ViewID]
	) REFERENCES [Views] (
		[ViewID]
	)

GO
---- script


DELETE FROM Tables
INSERT INTO Tables VALUES ('Actor'), ('Ticket'), ('Play')

DELETE FROM Views
INSERT INTO Views VALUES ('viewSelect'), ('viewSelJoin'), ('viewSelGrJoin')

DELETE FROM Tests
INSERT INTO Tests VALUES ('AddInActor'), ('RemoveFromActor'), ('AddInTicket'), ('RemoveFromTicket'), ('AddInPlay'), ('RemoveFromPlay')

SELECT * FROM Tests
SELECT * FROM Tables
SELECT * FROM Views

DELETE FROM TestViews
INSERT INTO TestViews VALUES (1,1)
INSERT INTO TestViews VALUES (1,2)
INSERT INTO TestViews VALUES (1,3)

SELECT * FROM TestViews

-- VALUES(test id,table id,no rows,position)
DELETE FROM TestTables
INSERT INTO TestTables VALUES (2, 1, 100, 1) 
INSERT INTO TestTables VALUES (4, 2, 100, 2) 
INSERT INTO TestTables VALUES (6, 3, 100, 3)

SELECT * FROM TestTables

GO

CREATE PROC UspTestRunViews
AS
	DECLARE @start1 DATETIME;
	DECLARE @start2 DATETIME;
	DECLARE @start3 DATETIME;
	DECLARE @end1 DATETIME;
	DECLARE @end2 DATETIME;
	DECLARE @end3 DATETIME;

	SET @start1 = GETDATE();
	EXEC ('SELECT * FROM viewSelect');
	SET @end1 = GETDATE();
	INSERT INTO TestRuns VALUES ('TestView1', @start1, @end1)
	INSERT INTO TestRunViews VALUES (@@IDENTITY, 1, @start1, @end1);

	SET @start2 = GETDATE();
	EXEC ('SELECT * FROM viewSelJoin');
	SET @end2 = GETDATE();
	INSERT INTO TestRuns VALUES ('TestView2', @start2, @end2)
	INSERT INTO TestRunViews VALUES (@@IDENTITY, 2, @start2, @end2);

	SET @start3 = GETDATE();
	EXEC ('SELECT * FROM viewSelGrJoin');
	SET @end3 = GETDATE();
	INSERT INTO TestRuns VALUES ('TestView3', @start3, @end3)
	INSERT INTO TestRunViews VALUES (@@IDENTITY, 3, @start3, @end3);

GO

CREATE PROC UspTestRunTables
AS
	DECLARE @start1 DATETIME;
	DECLARE @start2 DATETIME;
	DECLARE @start3 DATETIME;
	DECLARE @start4 DATETIME;
	DECLARE @start5 DATETIME;
	DECLARE @start6 DATETIME;
	DECLARE @end1 DATETIME;
	DECLARE @end2 DATETIME;
	DECLARE @end3 DATETIME;
	DECLARE @end4 DATETIME;
	DECLARE @end5 DATETIME;
	DECLARE @end6 DATETIME;

	SET @start2 = GETDATE();
	EXEC RemoveFromActor;
	SET @end2 = GETDATE();
	INSERT INTO TestRuns VALUES ('RemoveFromActor', @start2, @end2);
	INSERT INTO TestRunTables VALUES (@@IDENTITY, 1, @start2, @end2);

	SET @start1 = GETDATE();
	EXEC AddInActor;
	SET @end1 = GETDATE();
	INSERT INTO TestRuns VALUES ('AddInActor', @start2, @end2);
	INSERT INTO TestRunTables VALUES (@@IDENTITY, 1, @start2, @end2);

	SET @start4 = GETDATE();
	EXEC RemoveFromTicket;
	SET @end4 = GETDATE();
	INSERT INTO TestRuns VALUES ('RemoveFromTicket', @start4, @end4);
	INSERT INTO TestRunTables VALUES (@@IDENTITY, 2, @start4, @end4);

	SET @start3 = GETDATE();
	EXEC AddInTicket;
	SET @end3 = GETDATE();
	INSERT INTO TestRuns VALUES ('AddInTicket', @start3, @end3);
	INSERT INTO TestRunTables VALUES (@@IDENTITY, 2, @start3, @end3);

	SET @start6 = GETDATE();
	EXEC RemoveFromPlay;
	SET @end6 = GETDATE();
	INSERT INTO TestRuns VALUES ('RemoveFromPlay', @start6, @end6);
	INSERT INTO TestRunTables VALUES (@@IDENTITY, 3, @start6, @end6);

	SET @start5 = GETDATE();
	EXEC AddInPlay;
	SET @end5 = GETDATE();
	INSERT INTO TestRuns VALUES ('AddInPlay', @start5, @end5);
	INSERT INTO TestRunTables VALUES (@@IDENTITY, 3, @start5, @end5);

GO

EXEC UspTestRunTables;

GO

CREATE PROC UspAddRoom
AS
	DECLARE @i INT
	SET @i = 1
	WHILE @i < 100
		BEGIN
			INSERT INTO dbo.room
			Values(@i, 'room_name', @i, @i % 2)
			SET @i = @i + 1 
		END
GO

EXEC UspAddRoom

GO
CREATE PROC UspAddBar
AS
	DECLARE @i INT
	SET @i = 1
	WHILE @i < 100
		BEGIN
			INSERT INTO dbo.bar
			Values(@i, 'bar_title', @i % 2)
			SET @i = @i + 1 
		END

GO

EXEC UspAddBar

GO
EXEC UspTestRunViews;

SELECT * FROM TestRuns
SELECT * FROM TestRunViews
SELECT * FROM TestRunTables

DELETE FROM dbo.bar
DELETE FROM dbo.room
DELETE FROM dbo.actor
DELETE FROM dbo.ticket
DELETE FROM dbo.play

DELETE FROM TestTables
INSERT INTO TestTables VALUES (2, 1, 100, 1)
INSERT INTO TestTables VALUES (4, 2, 100, 2)
INSERT INTO TestTables VALUES (6, 3, 100, 3)

SELECT * FROM TestTables

DELETE FROM TestRunViews
DELETE FROM TestRunTables
DELETE FROM TestRuns

SELECT * FROM Tables
SELECT * FROM Tests
SELECT * FROM Views
