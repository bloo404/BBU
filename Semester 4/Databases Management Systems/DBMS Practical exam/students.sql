DROP TABLE Supervision
DROP TABLE Student
DROP TABLE AcademicSupervisor
DROP TABLE Department
DROP TABLE Internship
DROP TABLE Company

CREATE TABLE Company(
	CompanyID INT PRIMARY KEY,
	CName VARCHAR(50),
	CPhone VARCHAR(15),
	CWeb VARCHAR(50)
)

CREATE TABLE Internship(
	InternshipID INT PRIMARY KEY,
	CompanyID INT REFERENCES Company,
	Title VARCHAR(50),
	InternshipDescription VARCHAR(50),
	NrOfCredits INT,
	NrOfHours INT
)

CREATE TABLE Department(
	DepartmentID INT PRIMARY KEY,
	DName VARCHAR(200)
)

CREATE TABLE AcademicSupervisor(
	ASID INT PRIMARY KEY,
	ASName VARCHAR(50),
	DepartmentID INT REFERENCES Department
)

CREATE TABLE Student(
	StudID INT PRIMARY KEY,
	StudName VARCHAR(200),
	InternshipID INT REFERENCES Internship
)

CREATE TABLE Supervision(
	StudID INT REFERENCES Student,
	ASID INT REFERENCES AcademicSupervisor,
	startingDate DATE,
	endingDate DATE
)

INSERT INTO Company VALUES(1, 'Robert Bosch', '0744521649', 'www.bosch.com')
INSERT INTO Company VALUES(2, 'Siemens', '0715645330', 'www.siemens.com')
INSERT INTO Company VALUES(3, 'Arobs', '0732530252', 'www.arobs.com')

INSERT INTO Internship VALUES(1,1, 'Programmer backend','Java', 5, 180)
INSERT INTO Internship VALUES(2,1, 'Programmer AI','Python', 5, 480)
INSERT INTO Internship VALUES(3,2, 'Programmer frontend','JavaScript', 5, 210)
INSERT INTO Internship VALUES(4,3, 'Programmer backend','Assembly', 5, 360)

SELECT * FROM Company
SELECT * FROM Internship
