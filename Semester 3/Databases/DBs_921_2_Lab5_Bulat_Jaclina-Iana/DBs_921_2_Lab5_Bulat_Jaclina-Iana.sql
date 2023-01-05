USE Assignment_5

set statistics time on

DROP TABLE Grogu -- Tc
DROP TABLE Mandalorian -- Tb
DROP TABLE Yoda -- Ta

CREATE TABLE Yoda(
    aid INT NOT NULL IDENTITY (1,1), 
    CONSTRAINT PK_Ta PRIMARY KEY (aid),
    a2 INT UNIQUE,
    additionalField VARCHAR(100)
);


CREATE TABLE Mandalorian(
    bid INT NOT NULL IDENTITY (1,1), 
    CONSTRAINT PK_Tb PRIMARY KEY (bid),
    b2 INT 
);


CREATE TABLE Grogu(
    cid INT NOT NULL IDENTITY (1,1),
    CONSTRAINT PK_Tc PRIMARY KEY (cid), 
    aid INT REFERENCES Yoda(aid), 
    bid INT REFERENCES Mandalorian(bid)
    );


INSERT INTO Yoda VALUES (2,'a'),(30,'b'), (-7,'c'), (178,'d'), (0,'e')
INSERT INTO Mandalorian VALUES (10), (2), (2), (120), (-123)
INSERT INTO Grogu VALUES (1,1),(2,2),(3,3),(4,4),(5,5), (5,1), (1,2), (2,3)


SELECT * FROM Grogu

--a)
--clustered index scan
SELECT *
FROM  Yoda 
WHERE a2 < 0 
ORDER BY aid DESC
--clustered index seek
SELECT * 
FROM Yoda 
WHERE aid>0

--nonclustered index scan + key lookup
SELECT *
FROM Yoda 
ORDER BY a2

--nonclustered index seek
SELECT aid 
FROM Yoda 
WHERE a2 = 2


--b)

GO 
DROP INDEX Idx_NC_b2 ON Mandalorian
GO
-- the execution plan is a clustered index scan
SELECT *
FROM Mandalorian 
WHERE b2 = 2


CREATE NONCLUSTERED INDEX Idx_NC_b2 ON Mandalorian(b2)
-- the execution plan will show a nonclustered index seek, which would be more efficient


--c)
--this will use the previously created index and split the cost...
GO
CREATE VIEW cView
AS 
    SELECT *
    FROM Yoda a
    INNER JOIN Mandalorian b  ON a.a2=b.b2
    --INNER JOIN Tc c ON a.aid = c.aid

GO
SELECT * FROM cView

DROP VIEW cView

set statistics time off