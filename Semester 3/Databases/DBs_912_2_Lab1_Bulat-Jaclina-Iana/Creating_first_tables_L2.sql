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
