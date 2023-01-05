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
insert into dbo.play(pid, tpid, aid, play_date) values (9,12,3,'2013-09-19') -- violation of referential integrity constraint

-- testing the play table
-- select * from play

--																		UPDATE DATA
print 'ACTOR: BEFORE UPDATING';

select * from dbo.actor -- seeing what was before

update dbo.actor
set actor_dob = '2003-03-26'
where aid<=3 -- quadruplets have come to be actors in the theater and who were before them left because of various reasons

print 'ACTOR: AFTER UPDATING';

select * from dbo.actor -- seeing after

select * from dbo.drink -- seeing what was before

print 'DRINK: BEFORE UPDATING';

update dbo.drink
set drink_amount = 1
where drink_amount = 0 or drink_price >= 3.69 and drink_price <30 and drink_price <> 5.6 -- we just refilled the stock with the drinks in that interval 

print 'DRINK: AFTER UPDATING';

select * from dbo.drink -- seeing what has changed

print 'ROOM: BEFORE UPDATING';

select * from dbo.room -- seeing what was before

update dbo.room
set room_state=0
where not RID>2 -- those room are being repaired at the moment so we re going to set them to 'closed'

print 'ROOM: AFTER UPDATING';

select * from dbo.room -- seeing what has changed

--																		DELETE DATA

print 'SEE: BEFORE DELETING';

select * from dbo.see


delete from dbo.see 
where see_date is null -- we don t want eronated data into the table

select * from dbo.see

print 'SEE: AFTER DELETING';

print 'TICKET: BEFORE DELETING';

select * from dbo.ticket

delete from dbo.ticket
where tid in(select tid from dbo.client where tid between 7 and 10 and tid is not null) -- deleting the last sold tickets because they were returned

print 'TICKET: AFTER DELETING';

select * from dbo.ticket

print 'CLIENT: BEFORE DELETING';

select * from dbo.client

delete from dbo.client
where cnp like '%128782' -- removing the client that is not a client anymore

print 'CLIENT: AFTER DELETING';

select * from dbo.client

--																			STORY
--           A crime has been done. We are a detective team. The murderer is in the theater. We are looking for clues that might help us find him.

-- You must use:

-- arithmetic expressions in the SELECT clause in at least 3 queries;
-- conditions with AND, OR, NOT, and parentheses in the WHERE clause in at least 3 queries;
-- DISTINCT in at least 3 queries, ORDER BY in at least 2 queries, and TOP in at least 2 queries.

-- UNION

-- Searching for a drink that has been bought either in Andromeda as a suspect sustained, either in the open ones.

print 'UNION';

select DID from drink where drink_amount!=0 or BID!=NULL and CID!=null
union all
select BID from bar where bar_status!=1 or bar_title='Andromeda'

-- Searching either for an ID that might be a match for him or for the drink he has bought, maybe someone remembers him
-- and that reunited with the events he might ve been at
select TID from ticket where CID=1 or ticket_price = 3.69
union all
select EVID from event_piece where event_piece_title = 'Romeo & Juliette' or event_piece_title = 'Sizwe Bansi is Dead'

-- INTERSECTION 

print 'INTERSECTION';

-- We re looking for all clients that have been in the room 3 and in the room 6 where events have actually been plannned into 3 and 9
select cid from ticket where evid in(3,9)
intersect
select evid from event_piece where evid in(3,9)

-- Now we have a principal suspect, or more that have been in one/follows to be one in the two rooms
-- We re searching for the actors who might give us some info that have been to the event
select seed from see where tpid in(0,3,6) 
intersect
select tpid from play where aid in(3,6,9) and tpid in(0,3,6)

-- DIFFERENCE

print 'DIFFERENCE';

-- A bird told us that we want to look to the prices because some numbers are common to our suspect
select difference(ticket.ticket_price,3.60) from ticket where evid not in(0,4,9)

-- Then we search the almost similar client ids where they bought a ticket
select client.cid from client
full join dbo.ticket 
on dbo.ticket.cid = client.cid
where (difference(client.cid,ticket.cid)>= 3) -- similarity
except 
select drink.cid from drink
where drink.cid is null

-- INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN

-- INNER JOIN
-- Looking for clients that have seen common theater pieces, tickets, and bought drinks, they are martors to the crime.

print 'INNER JOIN';

-- Looking again through all our suspects, something feels off...

select dbo.see.cid
from dbo.see
inner join dbo.ticket
on dbo.see.cid = dbo.ticket.cid
inner join dbo.drink
on dbo.drink.cid = dbo.see.cid
order by cid desc 

-- LEFT JOIN

print 'LEFT JOIN';

-- Wanting to see everything they saw until now

select * from dbo.see
left join dbo.client
on dbo.client.cid = dbo.see.cid
order by see.TPID asc

-- RIGHT JOIN

print 'RIGHT JOIN';

-- We want the top three cids + info on the drinks

select top 3 * from dbo.client
right join dbo.drink
on dbo.drink.cid = dbo.client.cid

-- FULL JOIN

print 'FULL JOIN';

-- Top 5 seen plays 

select top 5 * from dbo.see
full join dbo.play
on dbo.play.tpid = dbo.see.tpid 
order by dbo.see.cid -- the only 2 many to many in my diagram that also relate


-- IN WHERE WHERE


print 'IN WHERE';

-- Someone who saw the incident told us that a secret code from counting the client ids should match with another s one client id

select * from dbo.client
where (select count(ticket.cid) from dbo.ticket where (ticket.ticket_price < 15)) in(select see.cid from dbo.see)

print 'IN WHERE WHERE';

-- Looking again through all our suspects, looking at those who have a history of seen plays and soda drinks that were bought by them

select cid from dbo.client
where cid in (
		select see.CID 
		from dbo.see 
		where see.cid in (
			select drink.cid 
			from dbo.drink 
			where drink.drink_type = 'soda'			
		)
)

-- EXISTS

print 'EXISTS';

-- Looking through theatrical pieces, at titles more specifically where the titles appear in the events

select distinct theatrical_piece.theatrical_piece_title
from theatrical_piece
where exists
(select event_piece.event_piece_title from event_piece)

-- Looking through room ids where they are used and they do exist and are closed

select event_piece.rid 
from event_piece
where exists
(select room.rid from room where room_state=0)

-- FROM

print 'FROM';

select * from (select ticket_price from ticket where ticket_price < 5) as ticket_price
select * from (select event_piece.event_piece_author_last_name 
from event_piece where event_piece.event_piece_author_first_name = 'William') as last_name

-- GROUP BY

-- looking for all different authors from the tables
select event_piece_author_last_name from dbo.event_piece group by event_piece_author_last_name order by event_piece_author_last_name desc

-- counting all see ids where in a day have been less than 2 events
select count(seed), see.see_date
from dbo.see
group by see_date
having count(seed) < 2

-- counting all see ids where in a day have been more than 2 events

select count(event_piece.evid), event_piece_author_last_name
from dbo.event_piece
group by event_piece_author_last_name
having count(event_piece.evid) >= 2

-- average drink_price where the maximum amount is < 5 and < 4

select avg(drink.drink_price), drink_type
from dbo.drink
group by drink_type
having (select max(drink_amount) from dbo.drink where dbo.drink.BID < 5) < 4

-- sum of all ticket prices where the minimum is < thanthe sum of the prices

select sum(ticket.ticket_price)
from dbo.ticket
group by ticket.EVID
having (select min(ticket_price) as minimum from dbo.ticket) <= sum(ticket_price)

-- ANY ALL (4 + 4 queries)

-- printing ticket and client ids from ticket table where cid = any from client table

select ticket.tid, ticket.cid
from ticket
where cid = any (select cid from client)

-- printing every event id and title from events where events are found in tickets

select distinct event_piece.evid, event_piece.event_piece_title
from event_piece
where evid = any (select evid from ticket)

-- printing all distinct play dates where the plays dates are into all event pieces

select distinct play.play_date from play
where play.play_date = all (select event_piece_date from event_piece)

-- printing all bar ids from the bar that are into all the drinks

select bar.bid from bar
where bid = all (select bid from drink)

-- Aggregation operations (count,sum,avg,min,max,...)

-- counting how many play dates are in all the event piece dates

select count(play.play_date) from play
where play.play_date = all (select event_piece_date from event_piece)

-- counting all bar ids from the bar where they all appear into the drink table

select count(bar.bid) from bar
where bid = all (select bid from drink)

-- in / not in

-- ticket & client id from ticket where cid is into any of the client table and not in cid from the drink table

select ticket.tid, ticket.cid
from ticket
where cid = any (select cid from client) and cid not in(select cid from drink)

-- event id & title from events where the id can appear in any tickets and room id is found in room ids and is also open to use

select event_piece.evid, event_piece.event_piece_title
from event_piece
where evid = any (select evid from ticket) and event_piece.rid in(select rid from room where room_state = 1)


-- ARITHMETIC EXPRESSIONS

-- computing the price * amount for every drink

select drink_price * drink_amount from drink 

select ticket_price - tid from ticket -- reducere la bilet

-- counting how many days went from today to the event s date 

select getdate() - event_piece_date from event_piece