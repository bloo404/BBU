-- Create two basic tables without data

-- CREATE TABLE T1(ID1 INT Primary Key,t1_name varchar(50) unique)
-- CREATE TABLE T2(ID2 INT Primary Key, ID1 int foreign key references T1(ID1) ,t2_name varchar(50) unique)

--		Remove the created tables in the right order

-- drop table T2
-- drop table T1

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

--										        A PLANETARY THEATER 
--											   		CREATION
-- Room
create table room(RID int primary key, room_name varchar(50) unique, room_number int, room_state int)

-- Event
create table event_piece(EVID int primary key, RID int foreign key references room(RID), event_piece_title varchar(100), 
event_piece_author_last_name varchar(50), event_piece_author_first_name varchar(50), event_piece_date date, event_piece_time time)

-- Bar
create table bar(BID int primary key, bar_title varchar(100), bar_status int)

-- Actor
create table actor(AID int primary key, actor_dob date)

-- Theatrical piece
create table theatrical_piece(TPID int primary key, theatrical_piece_title varchar(100), theatrical_piece_author_last_name varchar(50),
theatrical_piece_author_first_name varchar(50))

-- Play
create table play(PID int primary key, TPID int foreign key references theatrical_piece(TPID), AID int foreign key references actor(AID),
play_date date)

-- Client
create table client(CID int primary key, cnp varchar(14))


-- See in a lifetimes
create table see(seed int primary key, CID int foreign key references client(CID), TPID int foreign key references theatrical_piece(TPID),
see_date date)


-- Physical drink
create table drink(DID int primary key, CID int foreign key references client(CID),BID int foreign key references bar(BID), drink_type varchar(50), drink_price float, drink_amount float)

-- Ticket 
create table ticket(TID int primary key, CID int foreign key references client(CID), EVID int foreign key references event_piece(EVID),
ticket_price float)




--                                          INSERTING ELEMENTS INTO THE TABLES
--     BAR TABLE
-- BID         bar_title                                                                                            bar_status
----------- ---------------------------------------------------------------------------------------------------- -----------
-- 0           Andromeda                                                                                            1
-- 1           Pluto                                                                                                0
-- 2           Uranus                                                                                               1
-- 3           Earth                                                                                                1
-- 4           Ceres                                                                                                1
-- 5           Eris                                                                                                 0
-- 6           Ixion                                                                                                1
-- 7           Vesta                                                                                                0
-- 8           Hygiea                                                                                               0
-- 9           Varuna                                                                                               1
-- 10          Orcus                                                                                                0

insert into dbo.bar(BID,bar_title,bar_status)
values (0,'Andromeda',1)
insert into dbo.bar(BID,bar_title,bar_status)
values (1,'Pluto',0)
insert into dbo.bar(BID,bar_title,bar_status)
values (2,'Uranus',1)
insert into dbo.bar(BID,bar_title,bar_status)
values (3,'Earth',1)
insert into dbo.bar(BID,bar_title,bar_status)
values (4,'Ceres',1)
insert into dbo.bar(BID,bar_title,bar_status)
values (5,'Eris',0)
insert into dbo.bar(BID,bar_title,bar_status)
values (6,'Ixion',1)
insert into dbo.bar(BID,bar_title,bar_status)
values (7,'Vesta',0)
insert into dbo.bar(BID,bar_title,bar_status)
values (8,'Hygiea',0)
insert into dbo.bar(BID,bar_title,bar_status)
values (9,'Varuna',1)
insert into dbo.bar(BID,bar_title,bar_status)
values (10,'Orcus',0)

-- A small test
-- select * from bar

--     CLIENT TABLE
-- CID         cnp
----------- --------------
-- 0           6050423125784
-- 1           5180318376267
-- 2           6030318125467
-- 3           5220318126189
-- 4           1700318127832
-- 5           1221021125813
-- 6           2230214075793
-- 7           2901126035493
-- 8           5070830037197
-- 9           5091011035126
-- 10          6100501128782

insert into dbo.client(CID, cnp)
values (0,6050423125784)
insert into dbo.client(CID, cnp)
values (1,5180318376267)
insert into dbo.client(CID, cnp)
values (2, 6030318125467)
insert into dbo.client(CID, cnp)
values (3,5220318126189)
insert into dbo.client(CID, cnp)
values (4,1700318127832)
insert into dbo.client(CID, cnp)
values (5,1221021125813)
insert into dbo.client(CID, cnp)
values (6,2230214075793)
insert into dbo.client(CID, cnp)
values (7,2901126035493)
insert into dbo.client(CID, cnp)
values (8,5070830037197)
insert into dbo.client(CID, cnp)
values (9,5091011035126)
insert into dbo.client(CID, cnp)
values (10,6100501128782)

-- A small test
-- select * from dbo.client

--     DRINK
-- DID         CID         BID         drink_type                                         drink_price            drink_amount
-- ----------- ----------- ----------- -------------------------------------------------- ---------------------- ----------------------
-- 0           1           2           soda                                               26.18                  2
-- 1           2           1           water                                              30.19                  1
-- 2           2           1           water                                              50.18                  1
-- 3           1           2           soda                                               20.16                  3
-- 4           1           2           soda                                               26.17                  5
-- 5           6           1           water                                              10.19                  0
-- 6           3           1           alcohol                                            30.18                  6
-- 7           8           2           soda                                               9                      8
-- 8           3           1           alcohol                                            80.18                  10
-- 9           3           2           alcohol                                            25                     9

insert into dbo.drink (DID, CID, BID, drink_type, drink_price, drink_amount)
values (0,1,2,'soda',26.18,2)
insert into dbo.drink (DID, CID, BID, drink_type, drink_price, drink_amount)
values (1,2,1,'water',30.19,1)
insert into dbo.drink (DID, CID, BID, drink_type, drink_price, drink_amount)
values (2,2,1,'water',50.18,1)
insert into dbo.drink (DID, CID, BID, drink_type, drink_price, drink_amount)
values (3,1,2,'soda',20.16,3)
insert into dbo.drink (DID, CID, BID, drink_type, drink_price, drink_amount)
values (4,1,2,'soda',26.17,5)
insert into dbo.drink (DID, CID, BID, drink_type, drink_price, drink_amount)
values (5,6,1,'water',10.19,0)
insert into dbo.drink (DID, CID, BID, drink_type, drink_price, drink_amount)
values (6,3,1,'alcohol',30.18,6)
insert into dbo.drink (DID, CID, BID, drink_type, drink_price, drink_amount)
values (7,8,2,'soda',9.00,8)
insert into dbo.drink (DID, CID, BID, drink_type, drink_price, drink_amount)
values (8,3,1,'alcohol',80.18,10)
insert into dbo.drink (DID, CID, BID, drink_type, drink_price, drink_amount)
values (9,3,2,'alcohol',25.00,9)


-- ROOM
-- RID         room_name                                          room_number room_state
----------- -------------------------------------------------- ----------- -----------
-- 0           Anastasia                                          101         1
-- 1           Markle                                             102         1
-- 2           Merkel                                             103         0
-- 3           Lorene                                             201         1
-- 4           Janette                                            202         1
-- 5           Jacqueline                                         203         0
-- 6           Afrodita                                           301         1
-- 7           Athena                                             302         1
-- 8           Caesar                                             303         0
-- 9           Pirothania                                         401         0

insert into dbo.room (RID, room_name, room_number, room_state) values (0, 'Anastasia', 101, 1)
insert into dbo.room (RID, room_name, room_number, room_state) values (1, 'Markle', 102, 1)
insert into dbo.room (RID, room_name, room_number, room_state) values (2, 'Merkel', 103, 0)
insert into dbo.room (RID, room_name, room_number, room_state) values (3, 'Lorene', 201, 1)
insert into dbo.room (RID, room_name, room_number, room_state) values (4, 'Janette', 202, 1)
insert into dbo.room (RID, room_name, room_number, room_state) values (5, 'Jacqueline', 203, 0)
insert into dbo.room (RID, room_name, room_number, room_state) values (6, 'Afrodita', 301, 1)
insert into dbo.room (RID, room_name, room_number, room_state) values (7, 'Athena', 302, 1)
insert into dbo.room (RID, room_name, room_number, room_state) values (8, 'Caesar', 303, 0)
insert into dbo.room (RID, room_name, room_number, room_state) values (9, 'Pirothania', 401, 0)

-- EVENT PIECE
-- EVID        RID         event_piece_title                                                                                    event_piece_author_last_name                       event_piece_author_first_name                      event_piece_date event_piece_time
-- ----------- ----------- ---------------------------------------------------------------------------------------------------- -------------------------------------------------- -------------------------------------------------- ---------------- ----------------
-- 0           2           Romeo & Juliette                                                                                     Shakespeare                                        William                                            2020-03-18       18:00:00.0000000
-- 1           1           Oedipus Rex                                                                                          Sophocles                                          -                                                  2021-03-18       15:00:00.0000000
-- 2           3            Twelfth Night                                                                                       Shakespeare                                        William                                            2020-03-30       18:00:00.0000000
-- 3           5           Hamlet                                                                                               Shakespeare                                        William                                            2025-03-18       19:00:00.0000000
-- 4           6           The humans                                                                                           Karam                                              Stephan                                            2020-03-18       12:00:00.0000000
-- 5           4           Cloud 9                                                                                              Churchill                                          Caryl                                              2022-11-09       08:30:00.0000000
-- 6           9           John                                                                                                 Baker                                              Annie                                              2022-12-25       23:00:00.0000000
-- 7           0           The Women                                                                                            Booth Luce                                         Claire                                             2019-11-09       18:00:00.0000000
-- 8           7           Dutchman                                                                                             Jones                                              LeRoi                                              2023-03-18       15:00:00.0000000
-- 9           8           Awake and Sing!                                                                                      Odets                                              Clifford                                           2023-03-26       17:45:00.0000000

insert into dbo.event_piece (EVID, RID, event_piece_title, event_piece_author_last_name, event_piece_author_first_name, event_piece_date, event_piece_time)
values (0, 2, 'Romeo & Juliette', 'Shakespeare', 'William', '2020-03-18' , '18:00')
insert into dbo.event_piece (EVID, RID, event_piece_title, event_piece_author_last_name, event_piece_author_first_name, event_piece_date, event_piece_time)
values (1, 1, 'Oedipus Rex', 'Sophocles', '-', '2021-03-18' , '15:00')
insert into dbo.event_piece (EVID, RID, event_piece_title, event_piece_author_last_name, event_piece_author_first_name, event_piece_date, event_piece_time)
values (2, 3, ' Twelfth Night', 'Shakespeare', 'William', '2020-03-30' , '18:00')
insert into dbo.event_piece (EVID, RID, event_piece_title, event_piece_author_last_name, event_piece_author_first_name, event_piece_date, event_piece_time)
values (3, 5, 'Hamlet', 'Shakespeare', 'William', '2025-03-18' , '19:00')
insert into dbo.event_piece (EVID, RID, event_piece_title, event_piece_author_last_name, event_piece_author_first_name, event_piece_date, event_piece_time)
values (4, 6, 'The humans', 'Karam', 'Stephan', '2020-03-18' , '12:00')
insert into dbo.event_piece (EVID, RID, event_piece_title, event_piece_author_last_name, event_piece_author_first_name, event_piece_date, event_piece_time)
values (5, 4, 'Cloud 9', 'Churchill', 'Caryl', '2022-11-09' , '08:30')
insert into dbo.event_piece (EVID, RID, event_piece_title, event_piece_author_last_name, event_piece_author_first_name, event_piece_date, event_piece_time)
values (6, 9, 'John', 'Baker', 'Annie', '2022-12-25' , '23:00')
insert into dbo.event_piece (EVID, RID, event_piece_title, event_piece_author_last_name, event_piece_author_first_name, event_piece_date, event_piece_time)
values (7, 0, 'The Women', 'Booth Luce', 'Claire', '2019-11-09' , '18:00')
insert into dbo.event_piece (EVID, RID, event_piece_title, event_piece_author_last_name, event_piece_author_first_name, event_piece_date, event_piece_time)
values (8, 7, 'Dutchman', 'Jones', 'LeRoi', '2023-03-18' , '15:00')
insert into dbo.event_piece (EVID, RID, event_piece_title, event_piece_author_last_name, event_piece_author_first_name, event_piece_date, event_piece_time)
values (9, 8, 'Awake and Sing!', 'Odets', 'Clifford', '2023-03-26' , '17:45')

--    TICKET
-- TID         CID         EVID        ticket_price
-- ----------- ----------- ----------- ----------------------
-- 0           3           4           3.69
-- 1           2           1           3.59
-- 2           1           2           3.7
-- 3           4           3           3.29
-- 4           6           4           3.69
-- 5           5           7           2.5
-- 6           8           6           8.9
-- 7           3           8           1.6
-- 8           9           9           9.63
-- 9           9           9           9.63

insert into dbo.ticket (TID, CID, EVID, ticket_price) values (0, 3, 4, 3.69)
insert into dbo.ticket (TID, CID, EVID, ticket_price) values (1, 2, 1, 3.59)
insert into dbo.ticket (TID, CID, EVID, ticket_price) values (2, 1, 2, 3.70)
insert into dbo.ticket (TID, CID, EVID, ticket_price) values (3, 4, 3, 3.29)
insert into dbo.ticket (TID, CID, EVID, ticket_price) values (4, 6, 4, 3.69)
insert into dbo.ticket (TID, CID, EVID, ticket_price) values (5, 5, 7, 2.5)
insert into dbo.ticket (TID, CID, EVID, ticket_price) values (6, 8, 6, 8.9)
insert into dbo.ticket (TID, CID, EVID, ticket_price) values (7, 3, 8, 1.6)
insert into dbo.ticket (TID, CID, EVID, ticket_price) values (8, 9, 9, 9.63)
insert into dbo.ticket (TID, CID, EVID, ticket_price) values (9, 9, 9, 9.63)

-- ACTOR
-- AID         actor_dob
-- ----------- ----------
-- 0           2000-06-30
-- 1           1999-06-30
-- 2           1998-06-30
-- 3           2000-05-29
-- 4           2000-03-16
-- 5           2001-06-30
-- 6           2002-06-30
-- 7           1997-11-09
-- 8           1989-12-25
-- 9           1986-11-25

insert into dbo.actor (AID, actor_dob) values (0, '2000-06-30')
insert into dbo.actor (AID, actor_dob) values (1, '1999-06-30')
insert into dbo.actor (AID, actor_dob) values (2, '1998-06-30')
insert into dbo.actor (AID, actor_dob) values (3, '2000-05-29')
insert into dbo.actor (AID, actor_dob) values (4, '2000-03-16')
insert into dbo.actor (AID, actor_dob) values (5, '2001-06-30')
insert into dbo.actor (AID, actor_dob) values (6, '2002-06-30')
insert into dbo.actor (AID, actor_dob) values (7, '1997-11-09')
insert into dbo.actor (AID, actor_dob) values (8, '1989-12-25')
insert into dbo.actor (AID, actor_dob) values (9, '1986-11-25')

-- THEATRICAL PIECE
-- TPID        theatrical_piece_title                                                                               theatrical_piece_author_last_name                  theatrical_piece_author_first_name
-- ----------- ---------------------------------------------------------------------------------------------------- -------------------------------------------------- --------------------------------------------------
-- 0           Romeo & Juliette                                                                                     Shakespeare                                        William
-- 1           The Government Inspectior                                                                            Gogol                                              Nikolai
-- 2           Old Times                                                                                            Pinter                                             Harold
-- 3           Purgatory in Ingolstadt                                                                              Fleisher                                           Marieluise
-- 4           The Changeling                                                                                       Middleton - Rowley                                 Thomas - William
-- 5           Henry IV                                                                                             Pirandello                                         Luigi
-- 6           A Raisin in the Sun                                                                                  Hansberry                                          Lorraine
-- 7           An Oak Tree                                                                                          Crouch                                             Tim
-- 8           Sizwe Bansi is Dead                                                                                  Fugard                                             Athol
-- 9           A streetcar Named Desire                                                                             Williams                                           Tennessee


insert into dbo.theatrical_piece (TPID, theatrical_piece_title, theatrical_piece_author_last_name, theatrical_piece_author_first_name)
values (0, 'Romeo & Juliette', 'Shakespeare', 'William')
insert into dbo.theatrical_piece (TPID, theatrical_piece_title, theatrical_piece_author_last_name, theatrical_piece_author_first_name)
values (1, 'The Government Inspectior', 'Gogol', 'Nikolai')
insert into dbo.theatrical_piece (TPID, theatrical_piece_title, theatrical_piece_author_last_name, theatrical_piece_author_first_name)
values (2, 'Old Times', 'Pinter', 'Harold')
insert into dbo.theatrical_piece (TPID, theatrical_piece_title, theatrical_piece_author_last_name, theatrical_piece_author_first_name)
values (3, 'Purgatory in Ingolstadt', 'Fleisher', 'Marieluise')
insert into dbo.theatrical_piece (TPID, theatrical_piece_title, theatrical_piece_author_last_name, theatrical_piece_author_first_name)
values (4, 'The Changeling', 'Middleton - Rowley', 'Thomas - William')
insert into dbo.theatrical_piece (TPID, theatrical_piece_title, theatrical_piece_author_last_name, theatrical_piece_author_first_name)
values (5, 'Henry IV', 'Pirandello', 'Luigi')
insert into dbo.theatrical_piece (TPID, theatrical_piece_title, theatrical_piece_author_last_name, theatrical_piece_author_first_name)
values (6, 'A Raisin in the Sun', 'Hansberry', 'Lorraine')
insert into dbo.theatrical_piece (TPID, theatrical_piece_title, theatrical_piece_author_last_name, theatrical_piece_author_first_name)
values (7, 'An Oak Tree', 'Crouch', 'Tim')
insert into dbo.theatrical_piece (TPID, theatrical_piece_title, theatrical_piece_author_last_name, theatrical_piece_author_first_name)
values (8, 'Sizwe Bansi is Dead', 'Fugard', 'Athol')
insert into dbo.theatrical_piece (TPID, theatrical_piece_title, theatrical_piece_author_last_name, theatrical_piece_author_first_name)
values (9, 'A streetcar Named Desire', 'Williams', 'Tennessee')


-- testing the rooms
-- select * from dbo.theatrical_piece

-- SEE (what somebody has seen in its lifetime)
-- seed        CID         TPID        see_date
----------- ----------- ----------- ----------
-- 0           1           0           2004-05-26
-- 1           2           1           2015-09-17
-- 2           3           1           2005-05-01
-- 3           3           3           2003-03-26
-- 4           4           2           2018-10-18
-- 5           1           1           2019-06-26
-- 6           6           9           2022-08-28
-- 8           5           8           2020-12-30
-- 9           4           6           2003-10-19

insert into dbo.see(seed,cid,tpid,see_date) values(0,1,0,'2004-05-26')
insert into dbo.see(seed,cid,tpid,see_date) values(1,2,1,'2015-09-17')
insert into dbo.see(seed,cid,tpid,see_date) values(2,3,1,'2005-05-01')
insert into dbo.see(seed,cid,tpid,see_date) values(3,3,3,'2003-03-26')
insert into dbo.see(seed,cid,tpid,see_date) values(4,4,2,'2018-10-18')
insert into dbo.see(seed,cid,tpid,see_date) values(5,1,1,'2019-06-26')
insert into dbo.see(seed,cid,tpid,see_date) values(6,6,9,'2022-08-28')
insert into dbo.see(seed,cid,tpid,see_date) values(7,5,1,'2021-11-26')
insert into dbo.see(seed,cid,tpid,see_date) values(8,5,8,'2020-12-30')
insert into dbo.see(seed,cid,tpid,see_date) values(9,4,6,'2003-10-19')

-- testing the see table
-- select * from dbo.see

-- PLAY
-- PID         TPID        AID         play_date
----------- ----------- ----------- ----------
-- 0           1           0           2016-10-18
-- 1           3           1           2003-03-18
-- 2           2           2           2003-03-26
-- 3           4           2           2003-07-19
-- 4           5           5           2018-08-24
-- 5           6           6           2020-01-23
-- 6           7           8           2015-06-27
-- 7           8           9           2014-05-30
-- 8           9           4           2022-04-05
-- 9           4           3           2013-09-19

insert into dbo.play(pid, tpid, aid, play_date) values (0,1,0,'2016-10-18')
insert into dbo.play(pid, tpid, aid, play_date) values (1,3,1,'2003-03-18')
insert into dbo.play(pid, tpid, aid, play_date) values (2,2,2,'2003-03-26')
insert into dbo.play(pid, tpid, aid, play_date) values (3,4,2,'2003-07-19')
insert into dbo.play(pid, tpid, aid, play_date) values (4,5,5,'2018-08-24')
insert into dbo.play(pid, tpid, aid, play_date) values (5,6,6,'2020-01-23')
insert into dbo.play(pid, tpid, aid, play_date) values (6,7,8,'2015-06-27')
insert into dbo.play(pid, tpid, aid, play_date) values (7,8,9,'2014-05-30')
insert into dbo.play(pid, tpid, aid, play_date) values (8,9,4,'2022-04-05')
GO
-- testing the play table
-- select * from play

--											SEMESTER 4
--											 YEAR 2
--											  2023

DROP TABLE log
CREATE TABLE log (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    log_date DATETIME NOT NULL DEFAULT(GETDATE()),
    procedure_name VARCHAR(100) NOT NULL,
    input_params VARCHAR(MAX),
    return_value VARCHAR(MAX),
    error_message VARCHAR(MAX)
)
GO


--										      LAB 3

-- delete procedure is going to be useful when we will present our homeworks 
-- remarks: req 1 || 2 + validate with errors + generalization and use id from the table (not hardcoded/parameter)
-- remarks: 2 files for every special case (dirty read...)

CREATE OR ALTER PROCEDURE deleteInsertedData
AS
	DELETE FROM dbo.play WHERE pid = 10 AND tpid = 10 AND aid = 10;
	DELETE FROM dbo.actor WHERE AID = 10;
	DELETE FROM dbo.theatrical_piece WHERE TPID = 10;
GO

--									       REQUIREMENT 1
CREATE OR ALTER PROCEDURE insertDataRequirement1
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN

        INSERT INTO theatrical_piece values (10, 'New piece', 'Willy', 'Wonka')

        IF @@ROWCOUNT < 1
        BEGIN
            PRINT 'Problem with inserting values'
            ROLLBACK TRAN
            INSERT INTO log (procedure_name, error_message)
            VALUES ('insertDataRequirement1', 'Problem with inserting values');
            RETURN;
        END

        INSERT INTO actor values(10, '1999-03-18')
        IF @@ROWCOUNT < 1
        BEGIN
            PRINT 'Problem with inserting values'
            ROLLBACK TRAN
            INSERT INTO log (procedure_name, error_message)
            VALUES ('insertDataRequirement1', 'Problem with inserting values');
            RETURN;
        END

        INSERT INTO play values(10, 10, 10,'2023-03-18')
        IF @@ROWCOUNT < 1
        BEGIN
            PRINT 'Problem with inserting values'
            ROLLBACK TRAN
            INSERT INTO log (procedure_name, error_message)
            VALUES ('insertDataRequirement1', 'Problem with inserting values');
            RETURN;
        END

        PRINT 'Transaction successful'
        COMMIT TRAN
        INSERT INTO log (procedure_name)
        VALUES ('insertDataRequirement1');
    END TRY
    BEGIN CATCH
        PRINT 'Something went wrong with the insert.'
        ROLLBACK TRAN
        INSERT INTO log (procedure_name, error_message)
        VALUES ('insertDataRequirement1', ERROR_MESSAGE());
    END CATCH
END
GO

--									       REQUIREMENT 2
CREATE OR ALTER PROCEDURE insertDataRequirement2
AS
BEGIN TRAN
    BEGIN TRY
        DECLARE @log_id INT

        INSERT INTO dbo.theatrical_piece (TPID, theatrical_piece_title, theatrical_piece_author_last_name, theatrical_piece_author_first_name)
        VALUES (10, 'Some new theatrical piece', 'Donald', 'Dux')
        IF @@ROWCOUNT < 1
        BEGIN
            PRINT 'Something went wrong with the insert.'
            ROLLBACK TRAN
            RETURN
        END

        INSERT INTO dbo.actor (AID, actor_dob) VALUES (10, '1999-03-18')
        IF @@ROWCOUNT < 1
        BEGIN
            PRINT 'Something went wrong with the insert.'
            ROLLBACK TRAN
            RETURN
        END

        INSERT INTO dbo.play (pid, tpid, aid, play_date) VALUES (10, 10, 10, '2023-03-18')
        IF @@ROWCOUNT < 1
        BEGIN
            PRINT 'Something went wrong with the insert.'
            ROLLBACK TRAN
            RETURN
        END

        PRINT 'Insert successful.'

        -- log the successful execution of the procedure
        INSERT INTO log (procedure_name, input_params, return_value)
        VALUES ('insertDataRequirement2', '', 'Insert successful')
        SET @log_id = SCOPE_IDENTITY()

        COMMIT TRAN
    END TRY
    BEGIN CATCH
        -- log the error message
        INSERT INTO log (procedure_name, input_params, error_message)
        VALUES ('insertDataRequirement2', '', ERROR_MESSAGE())
        ROLLBACK TRAN
    END CATCH
GO

--									       EXECUTION
SELECT * FROM PLAY 
--										 REQUIREMENT 1
EXEC insertDataRequirement1;
SELECT * FROM PLAY 
EXEC deleteInsertedData;
--										 REQUIREMENT 2
EXEC insertDataRequirement2;
SELECT * FROM PLAY 
EXEC deleteInsertedData;
GO

select * from log
--									       REQUIREMENT 3
--									 a) Dirty read scenario

-- SET TRANSACTION ISOLATION LEVEL READ COMMITTED
-- that's the solution

-- Transaction 1
-- SET TRANSACTION ISOLATION LEVEL READ COMMITTED

EXEC insertDataRequirement1;
GO

CREATE OR ALTER PROCEDURE dirtyReadScenario
AS
BEGIN
    BEGIN TRY
        -- Transaction 1
        BEGIN TRANSACTION
        UPDATE play SET play_date = '2023-03-15' WHERE pid = 10
        WAITFOR DELAY '00:00:10'
        ROLLBACK TRANSACTION

        -- Log transaction 1
        INSERT INTO log (procedure_name, input_params, return_value, error_message)
        VALUES ('dirtyReadScenario', 'Transaction 1', NULL, NULL)

        -- Transaction 2
        SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
        BEGIN TRANSACTION
        SELECT * FROM play WHERE pid = 10
        WAITFOR DELAY '00:00:15'
        SELECT * FROM play WHERE pid = 10
        COMMIT TRANSACTION

        -- Log transaction 2
        INSERT INTO log (procedure_name, input_params, return_value, error_message)
        VALUES ('dirtyReadScenario', 'Transaction 2', NULL, NULL)

    END TRY
    BEGIN CATCH
        -- Log error message
        INSERT INTO log (procedure_name, input_params, return_value, error_message)
        VALUES ('dirtyReadScenario', 'pid = 10', NULL, ERROR_MESSAGE())
    END CATCH
END
GO

EXEC dirtyReadScenario;
GO


--									 b) Non-repeatable read scenario

-- Transaction 1
CREATE OR ALTER PROCEDURE nonRepeatableReadScenario
AS
BEGIN
    BEGIN TRANSACTION

    -- Transaction 1
    INSERT INTO dbo.theatrical_piece (TPID, theatrical_piece_title, theatrical_piece_author_last_name, theatrical_piece_author_first_name)
    VALUES (11, 'Title', 'Last', 'First')
    WAITFOR DELAY '00:00:05'
    UPDATE theatrical_piece SET theatrical_piece_title='New Title'
    WHERE tpid = 11

    INSERT INTO dbo.theatrical_piece (TPID, theatrical_piece_title, theatrical_piece_author_last_name, theatrical_piece_author_first_name)
    VALUES (12, 'Title2', 'Last2', 'First2')
    WAITFOR DELAY '00:00:05'
    UPDATE dbo.theatrical_piece SET theatrical_piece_title = 'New Title 2'
    WHERE tpid = 12

    COMMIT TRANSACTION

	DECLARE @error_message VARCHAR(MAX) = ERROR_MESSAGE()
    INSERT INTO log (procedure_name, input_params, return_value, error_message)
    VALUES ('phantomReadScenario', 'Transaction 1', '', @error_message)

    -- Transaction 2
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED
    -- SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
    -- solution
    BEGIN TRANSACTION
    SELECT * FROM theatrical_piece
    WAITFOR DELAY '00:00:05'
    SELECT * FROM theatrical_piece 
    COMMIT TRANSACTION

	DECLARE @error_message2 VARCHAR(MAX) = ERROR_MESSAGE()
    INSERT INTO log (procedure_name, input_params, return_value, error_message)
    VALUES ('phantomReadScenario', 'Transaction 2', '', @error_message2)

    -- Log the execution
    INSERT INTO log (procedure_name, input_params, return_value)
    VALUES ('nonRepeatableReadScenario', '', 'Executed successfully')
END
GO

EXEC nonRepeatableReadScenario;
GO

DELETE FROM theatrical_piece where tpid=11;
DELETE FROM theatrical_piece where tpid=12;
GO

--									 c) Phantom read scenario
-- Transaction 1
CREATE OR ALTER PROCEDURE phantomReadScenario AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRANSACTION
    
    BEGIN TRY
        -- Transaction 1
        INSERT INTO theatrical_piece (TPID, theatrical_piece_title, theatrical_piece_author_last_name, theatrical_piece_author_first_name)
        VALUES (11, 'Title', 'Last', 'First')
        
        WAITFOR DELAY '00:00:05'
        
        INSERT INTO theatrical_piece (TPID, theatrical_piece_title, theatrical_piece_author_last_name, theatrical_piece_author_first_name)
        VALUES (12, 'Title2', 'Last2', 'First2')
        
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        
        DECLARE @error_message VARCHAR(MAX) = ERROR_MESSAGE()
        INSERT INTO log (procedure_name, input_params, return_value, error_message)
        VALUES ('phantomReadScenario', 'Transaction 1', '', @error_message)
        
        RETURN
    END CATCH
    
    -- Transaction 2
    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
    
    BEGIN TRY
        BEGIN TRANSACTION
        
        SELECT * FROM theatrical_piece
        
        WAITFOR DELAY '00:00:07'
        
        SELECT * FROM theatrical_piece
        
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        
        DECLARE @error_message2 VARCHAR(MAX) = ERROR_MESSAGE()
        INSERT INTO log (procedure_name, input_params, return_value, error_message)
        VALUES ('phantomReadScenario', 'Transaction 2', '', @error_message2)
        
        RETURN
    END CATCH
    
    INSERT INTO log (procedure_name, input_params, return_value)
    VALUES ('phantomReadScenario', '', 'Success')
END
GO

EXEC phantomReadScenario;

DELETE FROM theatrical_piece where tpid=11;
DELETE FROM theatrical_piece where tpid=12;

--									 d) Deadlock

-- Transaction 1
DELETE FROM dbo.actor WHERE AID=11
insert into dbo.theatrical_piece (TPID, theatrical_piece_title, theatrical_piece_author_last_name, theatrical_piece_author_first_name)
values (11, 'Title', 'Last', 'First')
insert into dbo.actor (AID, actor_dob) values (11, '1986-11-26')
GO

CREATE OR ALTER PROCEDURE deadLockScenario
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE theatrical_piece 
        SET theatrical_piece_title = 'New Title' 
        WHERE TPID = 11;

        WAITFOR DELAY '00:00:10';

        UPDATE actor 
        SET actor_dob = '2002-11-26' 
        WHERE AID = 11;
        
        COMMIT TRANSACTION;
        
        INSERT INTO log (procedure_name, input_params, return_value)
        VALUES ('deadLockScenario', 'Transaction 1', 'Committed');
        
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        
        INSERT INTO log (procedure_name, input_params, error_message)
        VALUES ('deadLockScenario', 'Transaction 1', ERROR_MESSAGE());
    END CATCH;
    
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE actor 
        SET actor_dob = '2003-03-26' 
        WHERE AID = 11;

        WAITFOR DELAY '00:00:10';

        UPDATE theatrical_piece 
        SET theatrical_piece_title = '2nd New Title' 
        WHERE TPID = 11;

        COMMIT TRANSACTION;
        
        INSERT INTO log (procedure_name, input_params, return_value)
        VALUES ('deadLockScenario', 'Transaction 2', 'Committed');
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        
        INSERT INTO log (procedure_name, input_params, error_message)
        VALUES ('deadLockScenario', 'Transaction 2', ERROR_MESSAGE());
    END CATCH;
    
END;
GO

EXEC deadLockScenario;

DELETE FROM theatrical_piece where tpid = 11;
DELETE FROM actor where aid = 11;
GO

--									       REQUIREMENT 4
-- reproduce the update conflict under an optimistic isolation level
-- permission for snapshot
CREATE OR ALTER PROCEDURE snapshotIsolationScenario
AS
BEGIN
	ALTER DATABASE theater
	SET ALLOW_SNAPSHOT_ISOLATION ON
    -- insert the actor
    INSERT INTO dbo.actor (AID, actor_dob) VALUES (11, '1986-11-26')

    -- Transaction 1
    WAITFOR DELAY '00:00:05'
    BEGIN TRAN
    UPDATE actor SET actor_dob = '2003-03-26' WHERE AID = 11
    WAITFOR DELAY '00:00:05'
    COMMIT TRAN

    -- Transaction 2
    SET TRANSACTION ISOLATION LEVEL SNAPSHOT
    BEGIN TRAN
    WAITFOR DELAY '00:00:05'
    -- T1 has updated and has a lock on the table
    -- T2 will be blocked when trying to update the table
    UPDATE actor SET actor_dob = '2002-11-26' WHERE AID = 11
    COMMIT TRAN

    -- Transaction 3
    BEGIN TRAN
    SELECT * FROM actor WHERE AID = 11
    COMMIT TRAN

    -- log the details
    INSERT INTO log (procedure_name, input_params, return_value, error_message)
    VALUES ('snapshotIsolationScenario', NULL, NULL, NULL)
END
GO

EXEC snapshotIsolationScenario;
GO

DELETE FROM actor where aid = 11;

ALTER DATABASE theater
SET ALLOW_SNAPSHOT_ISOLATION OFF

-- See everything in the log table
SELECT * FROM log

-- To see all transactions
SELECT * FROM sys.dm_tran_active_transactions

