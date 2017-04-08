/* 
 *  INFO2120/2820
 *  PostgreSQL schema for the student registration system (lab 6 and lab7)
 */

/* delete eventually already existing tables;
 * ignore the errors if you execute this script the first time */
BEGIN TRANSACTION;
   DROP TABLE IF EXISTS public.Transcript CASCADE;
   DROP TABLE IF EXISTS public.Lecture CASCADE;
   DROP TABLE IF EXISTS public.UoSOffering CASCADE;
   DROP TABLE IF EXISTS public.Requires CASCADE;
   DROP TABLE IF EXISTS public.Classroom CASCADE;
   DROP TABLE IF EXISTS public.WhenOffered CASCADE;
   DROP TABLE IF EXISTS public.Student CASCADE;
   DROP TABLE IF EXISTS public.Faculty CASCADE;
   DROP TABLE IF EXISTS public.AcademicStaff CASCADE;
   DROP TABLE IF EXISTS public.UnitOfStudy CASCADE;
	DROP TABLE IF EXISTS public.Assessment CASCADE;
   DROP SCHEMA IF EXISTS UniDB CASCADE;  
COMMIT;

/* create the schema */
BEGIN TRANSACTION;

CREATE SCHEMA UniDB;

/* this setting onbly applies to the current session */
/* if you want to make it persistent, please use ALTER USER SET search_path ...*/
SET search_Path = '$user', public, unidb;

CREATE TABLE UniDB.Student (
  studId        INTEGER,
  name          VARCHAR(20) NOT NULL,
  password      VARCHAR(10) NOT NULL,
  address       VARCHAR(50),
  PRIMARY KEY (studid)
);
CREATE TABLE UniDB.AcademicStaff (
  id            CHAR(9),
  name          VARCHAR(20) NOT NULL,
  deptId        CHAR(3)     NOT NULL,
  password      VARCHAR(10) NOT NULL,
  address       VARCHAR(50),
  salary        INTEGER,
  PRIMARY KEY (id)
);
CREATE TABLE UniDB.UnitOfStudy (
  uosCode       CHAR(8),
  deptId        CHAR(3)     NOT NULL,
  uosName       VARCHAR(40) NOT NULL,
  credits       INTEGER     NOT NULL,
  PRIMARY KEY (uosCode),
  UNIQUE (deptId, uosName)
);
CREATE TABLE UniDB.WhenOffered (
  uosCode       CHAR(8),
  semester      CHAR(2),
  PRIMARY KEY (uosCode, semester)
);
CREATE TABLE UniDB.ClassRoom (
  classroomId   VARCHAR(8),
  seats         INTEGER NOT NULL,
  Type          VARCHAR(7) ,
  PRIMARY KEY (classroomId)
);
CREATE TABLE UniDB.Requires (
  uosCode       CHAR(8),
  PrereqUosCode CHAR(8),
  enforcedSince DATE NOT NULL,
  PRIMARY KEY (uosCode, prereqUosCode),
  FOREIGN KEY (uosCode) REFERENCES UnitOfStudy(uosCode),
  FOREIGN KEY (prereqUosCode) REFERENCES UnitOfStudy(uosCode)
);
CREATE TABLE UniDB.UoSOffering (
  uosCode       CHAR(8), 
  semester      CHAR(2),
  year          INTEGER,
  textbook      VARCHAR(50),
  enrollment    INTEGER,
  maxEnrollment INTEGER,
  instructorId  CHAR(9),
  PRIMARY KEY (uosCode, semester, year),
  FOREIGN KEY (uosCode)          REFERENCES UnitOfStudy(uosCode),
  FOREIGN KEY (uosCode,semester) REFERENCES WhenOffered(uosCode,semester),
  FOREIGN KEY (instructorId)     REFERENCES AcademicStaff(id)
);
CREATE TABLE UniDB.Lecture (
  UoSCode       CHAR(8), 
  Semester      CHAR(2),
  Year          INTEGER,
  ClassTime     CHAR(5),
  ClassroomId   VARCHAR(8),
  PRIMARY KEY (UoSCode, Semester, Year, ClassroomId),
  FOREIGN KEY (UoSCode, Semester, Year) REFERENCES UoSOffering,
  FOREIGN KEY (ClassroomId)             REFERENCES Classroom
);
CREATE TABLE UniDB.Transcript (
  studId        INTEGER,
  uosCode       CHAR(8),
  semester      CHAR(2),
  year          INTEGER,
  grade         VARCHAR(2),
  CONSTRAINT Transcript_PK PRIMARY KEY (studId,uosCode,semester,year),
  CONSTRAINT Transcript_Stud_FK FOREIGN KEY (studId) REFERENCES Student(studId) DEFERRABLE INITIALLY IMMEDIATE,
  CONSTRAINT Transcript_UoS_FK  FOREIGN KEY (uosCode,semester,year) REFERENCES UoSOffering DEFERRABLE INITIALLY IMMEDIATE
);
/* Alternative to Transcript, with numerical scores */
CREATE TABLE UniDB.Assessment (
  studId        INTEGER,
  uosCode       CHAR(8),
  semester      CHAR(2),
  year          INTEGER,
  mark         INTEGER,
  CONSTRAINT Assessment_PK PRIMARY KEY (studId,uosCode,semester,year),
  CONSTRAINT Assessment_Stud_FK FOREIGN KEY (studId) REFERENCES Student(studId) DEFERRABLE INITIALLY IMMEDIATE,
  CONSTRAINT Assessment_UoS_FK  FOREIGN KEY (uosCode,semester,year) REFERENCES UoSOffering DEFERRABLE INITIALLY IMMEDIATE
);

/* add some students - the following data is completely arbitrary */
/* any similarities to actual students is purely accidential.     */
INSERT INTO Student VALUES (307088592, 'John Smith', 'Green', 'Newtown');
INSERT INTO Student VALUES (305422153, 'Sally Waters', 'Purple', 'Coogee');
INSERT INTO Student VALUES (305678453, 'Pauline Winters', 'Turkey', 'Bondi');
INSERT INTO Student VALUES (316424328, 'Matthew Long', 'Space', 'Camperdown');
INSERT INTO Student VALUES (309145324, 'Victoria Tan', 'Grapes', 'Maroubra');
INSERT INTO Student VALUES (309187546, 'Niang Jin Phan', 'Robot', 'Kingsford');

/* add some example data */
INSERT INTO AcademicStaff VALUES ('6339103', 'Uwe Roehm',    'SIT', 'sailing', 'Cremorne', 90000);
INSERT INTO AcademicStaff VALUES ('1234567', 'Jon Patrick',  'SIT', 'english', 'Glebe',  135000);
INSERT INTO AcademicStaff VALUES ('7891234', 'Sanjay Chawla','SIT', 'cricket', 'Neutral Bay', 140000);
INSERT INTO AcademicStaff VALUES ('1237890', 'Joseph Davis', 'SIT', 'abcd',    NULL, 120000);
INSERT INTO AcademicStaff VALUES ('4657890', 'Alan Fekete',  'SIT', 'opera',   'Cameray', 120000);
INSERT INTO AcademicStaff VALUES ('0987654', 'Simon Poon',   'SIT', 'pony',    'Sydney', 75000);
INSERT INTO AcademicStaff VALUES ('1122334', 'Irena Koprinska','SIT','volleyball', 'Glebe', 90000);

/* some of our class rooms */
INSERT INTO Classroom VALUES ('BoschLT1',270, 'tiered');
INSERT INTO Classroom VALUES ('BoschLT2',267, 'tiered');
INSERT INTO Classroom VALUES ('BoschLT3',300, 'tiered');
INSERT INTO Classroom VALUES ('BoschLT4',300, 'tiered');
INSERT INTO Classroom VALUES ('CheLT1',  300, 'tiered');
INSERT INTO Classroom VALUES ('CheLT2',  145, 'tiered');
INSERT INTO Classroom VALUES ('CheLT3',  300, 'tiered');
INSERT INTO Classroom VALUES ('CheLT4',  145, 'tiered');
INSERT INTO Classroom VALUES ('CAR157',  290, 'tiered');
INSERT INTO Classroom VALUES ('CAR159',  290, 'tiered');
INSERT INTO Classroom VALUES ('CAR173',  127, 'tiered');
INSERT INTO Classroom VALUES ('CAR175',  160, 'tiered');
INSERT INTO Classroom VALUES ('CAR273',  160, 'tiered');
INSERT INTO Classroom VALUES ('CAR275',  160, 'tiered');
INSERT INTO Classroom VALUES ('CAR373',  160, 'tiered');
INSERT INTO Classroom VALUES ('CAR375',  160, 'tiered');
INSERT INTO Classroom VALUES ('EAA',     500, 'sloping');
INSERT INTO Classroom VALUES ('EALT',    200, 'sloping');
INSERT INTO Classroom VALUES ('EA403',    40, 'flat');
INSERT INTO Classroom VALUES ('EA404',    40, 'flat');
INSERT INTO Classroom VALUES ('EA405',    40, 'flat');
INSERT INTO Classroom VALUES ('EA406',    40, 'flat');
INSERT INTO Classroom VALUES ('FarrelLT',190, 'tiered');
INSERT INTO Classroom VALUES ('MechLT',  100, 'tiered');
INSERT INTO Classroom VALUES ('QuadLT',  261, 'tiered');
INSERT INTO Classroom VALUES ('SITLT',    50, 'sloping');

/* some units of study; note: older ones have only 3cp */
INSERT INTO UnitOfStudy  VALUES ('INFO1003', 'SIT', 'Introduction to IT', 6);
INSERT INTO UnitOfStudy  VALUES ('INFO2120', 'SIT', 'Database Systems I', 6);
INSERT INTO UnitOfStudy  VALUES ('INFO3404', 'SIT', 'Database Systems II', 6);
INSERT INTO UnitOfStudy  VALUES ('COMP5046', 'SIT', 'Statistical Natural Language Processing', 6);
INSERT INTO UnitOfStudy  VALUES ('COMP5138', 'SIT', 'Database Management Systems', 6);
INSERT INTO UnitOfStudy  VALUES ('COMP5338', 'SIT', 'Advanced Data Models', 6);
INSERT INTO UnitOfStudy  VALUES ('INFO2005', 'SIT', 'Database Management Introductory', 3);
INSERT INTO UnitOfStudy  VALUES ('INFO3005', 'SIT', 'Organisational Database Systems', 3);
INSERT INTO UnitOfStudy  VALUES ('MATH1002', 'MAT', 'Linear Algebra', 3);

INSERT INTO Requires VALUES('INFO2120', 'INFO1003', '01-Jan-2002');
INSERT INTO Requires VALUES('INFO3404', 'INFO2120', '01-Nov-2004');
INSERT INTO Requires VALUES('COMP5046', 'COMP5138', '01-Nov-2006');
INSERT INTO Requires VALUES('COMP5338', 'COMP5138', '01-Jan-2004');
INSERT INTO Requires VALUES('COMP5338', 'INFO2120', '01-Jan-2004');
INSERT INTO Requires VALUES('INFO2005', 'INFO1003', '01-Jan-2002');
INSERT INTO Requires VALUES('INFO3005', 'INFO2005', '01-Jan-2002');

INSERT INTO WhenOffered VALUES ('INFO1003', 'S1');
INSERT INTO WhenOffered VALUES ('INFO1003', 'S2');
INSERT INTO WhenOffered VALUES ('INFO2120', 'S1');
INSERT INTO WhenOffered VALUES ('INFO3404', 'S2');
INSERT INTO WhenOffered VALUES ('INFO2005', 'S2');
INSERT INTO WhenOffered VALUES ('INFO3005', 'S1');
INSERT INTO WhenOffered VALUES ('COMP5046', 'S1');
INSERT INTO WhenOffered VALUES ('COMP5138', 'S1');
INSERT INTO WhenOffered VALUES ('COMP5138', 'S2');
INSERT INTO WhenOffered VALUES ('COMP5338', 'S1');
INSERT INTO WhenOffered VALUES ('COMP5338', 'S2');
INSERT INTO WhenOffered VALUES ('MATH1002', 'S1');
INSERT INTO WhenOffered VALUES ('MATH1002', 'S2');

INSERT INTO UoSOffering VALUES ('INFO1003', 'S1', 2006, 'Snyder', 150,200, '0987654');
INSERT INTO UoSOffering VALUES ('INFO1003', 'S2', 2006, 'Snyder',  80,200, '0987654');
INSERT INTO UoSOffering VALUES ('INFO2120', 'S1', 2006, 'Kifer/Bernstein/Lewis', 140, 200, '6339103');
INSERT INTO UoSOffering VALUES ('INFO2120', 'S1', 2009, 'Kifer/Bernstein/Lewis', 178, 200, '6339103');
INSERT INTO UoSOffering VALUES ('INFO2120', 'S1', 2010, 'Kifer/Bernstein/Lewis', 181, 200, '6339103');
INSERT INTO UoSOffering VALUES ('INFO3404', 'S2', 2008, 'Ramakrishnan/Gehrke',    80, 150, '6339103');
INSERT INTO UoSOffering VALUES ('COMP5138', 'S2', 2006, 'Ramakrishnan/Gehrke',    60, 100, '1237890');
INSERT INTO UoSOffering VALUES ('COMP5138', 'S1', 2010, 'Ramakrishnan/Gehrke',    56, 100, '1234567');
INSERT INTO UoSOffering VALUES ('COMP5046', 'S1', 2010, NULL,                     15,  40, '1234567');
INSERT INTO UoSOffering VALUES ('COMP5338', 'S1', 2006, 'none',  32, 50,  '6339103');
INSERT INTO UoSOffering VALUES ('COMP5338', 'S2', 2006, 'none',  30, 50,  '7891234');
INSERT INTO UoSOffering VALUES ('INFO2005', 'S2', 2004, 'Hoffer', 370, 400,  '6339103');
INSERT INTO UoSOffering VALUES ('INFO3005', 'S1', 2005, 'Hoffer', 100, 150,  '1122334');

INSERT INTO Lecture     VALUES ('INFO1003', 'S1', 2006, 'Mon12', 'CheLT4' );
INSERT INTO Lecture     VALUES ('INFO1003', 'S2', 2006, 'Mon12', 'CheLT4' );
INSERT INTO Lecture     VALUES ('INFO2120', 'S1', 2006, 'Mon11', 'CAR175' );
INSERT INTO Lecture     VALUES ('INFO2120', 'S1', 2009, 'Mon09', 'EALT'   );
INSERT INTO Lecture     VALUES ('INFO2120', 'S1', 2009, 'Tue13', 'CAR159' );
INSERT INTO Lecture     VALUES ('INFO2120', 'S1', 2010, 'Mon09', 'QuadLT' );
INSERT INTO Lecture     VALUES ('INFO2120', 'S1', 2010, 'Tue13', 'BoschLT2' );
INSERT INTO Lecture     VALUES ('INFO3404', 'S2', 2008, 'Mon09', 'CheLT4' );
INSERT INTO Lecture     VALUES ('COMP5046', 'S1', 2010, 'Tue14', 'SITLT'  );
INSERT INTO Lecture     VALUES ('COMP5138', 'S2', 2006, 'Mon18', 'SITLT'  );
INSERT INTO Lecture     VALUES ('COMP5138', 'S1', 2010, 'Thu18', 'FarrelLT');
INSERT INTO Lecture     VALUES ('COMP5338', 'S1', 2006, 'Tue18', 'EA404'  );
INSERT INTO Lecture     VALUES ('INFO2005', 'S2', 2004, 'Mon09', 'CAR159' );
INSERT INTO Lecture     VALUES ('INFO3005', 'S1', 2005, 'Wed09', 'EALT'   );

/* add some dummy transcripts */
INSERT INTO Transcript VALUES (316424328,'INFO2120', 'S1', 2010,'D');
INSERT INTO Transcript VALUES (305678453,'INFO2120', 'S1', 2010,'HD');
INSERT INTO Transcript VALUES (316424328,'INFO3005', 'S1', 2005,'CR');
INSERT INTO Transcript VALUES (305422153,'INFO3404', 'S2', 2008,'P');
INSERT INTO Transcript VALUES (316424328,'COMP5338', 'S1', 2006,'D');
INSERT INTO Transcript VALUES (309145324,'INFO2120', 'S1', 2010,'F');
INSERT INTO Transcript VALUES (309187546,'INFO2005', 'S2', 2004,'D');

/* add some dummy assessments */
INSERT INTO Assessment VALUES (316424328,'INFO2120', 'S1', 2010,72);
INSERT INTO Assessment VALUES (305678453,'INFO2120', 'S1', 2010,92);
INSERT INTO Assessment VALUES (316424328,'INFO3005', 'S1', 2005,61);
INSERT INTO Assessment VALUES (305422153,'INFO3404', 'S2', 2008,56);
INSERT INTO Assessment VALUES (316424328,'COMP5338', 'S1', 2006,63);
INSERT INTO Assessment VALUES (309145324,'INFO2120', 'S1', 2010,28);
INSERT INTO Assessment VALUES (309187546,'INFO2005', 'S2', 2004,73);
COMMIT;

