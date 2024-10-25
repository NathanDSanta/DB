-- ============================================================
-- Taules per examen SQL (Oracle)
-- versió 1.0 (juny 2024) 
-- ============================================================

SET ECHO OFF

PROMPT Construint les taules per la BD examen...
-- si alguna cosa no va prou bé, podem posar el feedback a on en la linia anterior

-- Es fa un "reSET" de la Base de Dades esborrant i tornant a crear totes les taules
-- el "CASCADE CONSTRAINTS" del DROP TABLE elimina qualsevol restricció de la taula
-- La primera vegada donarà errors 'ORA-00942: table or view does not exist'
-- que podem ignorar (són els de les comandes DROP TABLE que hi ha abans de cada
-- CREATE TABLE i com que encara no existeix la taula el DROP TABLE dóna error)

SET termout on
SET feedback on

-- ============================================================
--  Table: ALUMNES                      
-- ============================================================
DROP TABLE Alumnes CASCADE CONSTRAINTS;
CREATE TABLE Alumnes(
 codi DECIMAL(8) PRIMARY KEY,
 DNI VARCHAR(9) not null,
 nom VARCHAR(15) null ,
 cognoms VARCHAR(40) null ,
 adreca VARCHAR(20) null ,
 CP VARCHAR(5) null ,
 poblacio VARCHAR(25) null ,
 comarca VARCHAR(25) null ,
 telefon VARCHAR(10) null ,
 naixement DATE null ,
 casat CHAR(1) null ,
 email VARCHAR(30) null 
);

-- ============================================================
-- Table: PROFESSORS 
-- ============================================================
DROP TABLE Professors CASCADE CONSTRAINTS;
CREATE TABLE professors(
 codi DECIMAL(6) PRIMARY KEY,
 DNI VARCHAR(9) not null,
 nom VARCHAR(15) null ,
 cognoms VARCHAR(40) null ,
 adreca VARCHAR(20) null ,
 CP VARCHAR(5) null ,
 poblacio VARCHAR(25) null ,
 comarca VARCHAR(25) null ,
 telefon VARCHAR(10) null ,
 naixement DATE null ,
 casat CHAR(1) not null,
 email VARCHAR(30) null ,
 categoria VARCHAR(10) null ,
 sou DECIMAL(12,2) null ,
 departament DECIMAL(8) null ,
 dataInici DATE null 
);

-- ============================================================
-- Table: CARRERES
-- ============================================================
DROP TABLE Carreres CASCADE CONSTRAINTS;
CREATE TABLE Carreres (
  codi VARCHAR(20) PRIMARY KEY,
  nom VARCHAR(50) NULL,
  places DECIMAL(4) NULL,
  anyPlaEstudis DECIMAL(4) NULL
);

-- ============================================================
-- Table: ASSIGNATURES 
-- ============================================================
DROP TABLE Assignatures CASCADE CONSTRAINTS;
CREATE TABLE Assignatures
(
 codi DECIMAL(5) PRIMARY KEY ,
 nom VARCHAR(40) null ,
 credits DECIMAL(4,2) null ,
 responsable DECIMAL(6) null ,
 semestre DECIMAL(1) null ,
 curs DECIMAL(2) null ,
 tipus VARCHAR(20) null ,
 carrera VARCHAR(20) null,
 CONSTRAINT cf_assignaturaResponsable FOREIGN KEY (responsable) REFERENCES Professors(codi),
 CONSTRAINT cf_carrera FOREIGN KEY (carrera) REFERENCES Carreres(codi)
);


-- ============================================================
-- Table: ASSIGNATURES/PROFESSOR 
-- ============================================================
DROP TABLE AssignaturesProfessors CASCADE CONSTRAINTS;
CREATE TABLE AssignaturesProfessors(
 assignatura DECIMAL(5) ,
 professor DECIMAL(6) ,
 PRIMARY KEY (assignatura,professor),
 CONSTRAINT cf_assig_profAssignatura FOREIGN KEY (assignatura) REFERENCES Assignatures(codi),
 CONSTRAINT cf_assig_profProfessor FOREIGN KEY (professor) REFERENCES Professors(codi)
);

-- ============================================================
-- Table: DEPARTAMENTS 
-- ============================================================
DROP TABLE Departaments CASCADE CONSTRAINTS;
CREATE TABLE Departaments(
 codi DECIMAL(8) PRIMARY KEY ,
 nom VARCHAR(50) null ,
 ubicacio VARCHAR(50) null ,
 telefon VARCHAR(50) null ,
 director decimal(6) null,
 CONSTRAINT cf_DepartamentDirector FOREIGN KEY(director) REFERENCES Professors(codi)
);

-- ============================================================
-- Table: MATRICULA 
-- ============================================================
DROP TABLE Matricula CASCADE CONSTRAINTS;
CREATE TABLE Matricula(
 alumne DECIMAL(8) not null ,
 assignatura DECIMAL(5) not null ,
 convocatoria DECIMAL(1) null ,
 nota DECIMAL(4,2) null,
 PRIMARY KEY (alumne, assignatura),
 CONSTRAINT cf_matriculaAlumne FOREIGN KEY(alumne) REFERENCES Alumnes(codi),
 CONSTRAINT cf_matriculaAssignatura FOREIGN KEY(assignatura) REFERENCES Assignatures(codi)
);

INSERT INTO Alumnes VALUES (11,'58330839X','MANEL','PI GROS','CR NOU 45','17003','GIRONA','GIRONES','972567898',to_date('01/05/2005','DD/MM/YYYY'),'N','MPi@correu.udg.edu');
INSERT INTO Alumnes VALUES(22,'09894277E','PERE','PRATS PIGEM','CR CLAR 34','17005','GIRONA','GIRONES','972233445',to_date('01/05/2005','DD/MM/YYYY'), 'N','FLopez@correu.udg.edu');
INSERT INTO Alumnes VALUES(33,'93725672M','ENRIQUE','LOPEZ AGUADO','CR/ DEL PI 6','17005','GIRONA','GIRONES','972222324',to_date('01/04/2005','DD/MM/YYYY'), NULL,'ELopez@correu.udg.edu');
INSERT INTO Alumnes VALUES(44,'26178523S','NARCIS','SEGA SEGA','CR DEL PONT','08060','BARCELONA','BARCELONES','934567890',to_date('12/12/2006','DD/MM/YYYY'), 'N','NSega@correu.udg.edu');
INSERT INTO Alumnes VALUES(55,'99864985C','MARIA','PI PI','CR ST.RAFEL 32','17800','OLOT','GARROTXA','972262626',to_date('05/04/2004','DD/MM/YYYY'), NULL,'PiPiMaria@gmail.com');
INSERT INTO Alumnes VALUES(66,'80234175D','EVA','PUIG PELAT','CR.ST RAFEL','17800','OLOT','GARROTXA','972262728',to_date('07/08/2006','DD/MM/YYYY'), 'N','EvaPP1996@hotmail.com');
INSERT INTO Alumnes VALUES(77,'07946167N','PILAR','MATA DEPERA','CR NOU 32','17003','GIRONA','GIRONES','972414870',to_date('06/07/2005','DD/MM/YYYY'), 'N','PMata@correu.udg.edu');
INSERT INTO Alumnes VALUES(88,'97719627X','MARTA','PERIS PUJOL','CR MAGNOLIES 34','08035','BARCELONA','BARCELONES','935667789',to_date('02/03/2004','DD/MM/YYYY'), 'N','PerisPujolMarta@gmail.coom');
INSERT INTO Alumnes VALUES(99,'01742155C','JOSEP M.','PAQUE ELIAS','CR FREIXES 13','08010','BARCELONA','BARCELONES','938778985',to_date('01/06/2005','DD/MM/YYYY'), 'N','eskimal95@hotmail.com');
INSERT INTO Alumnes VALUES(111,'61625833R','JOSEP','SASUN PEREZ','CR VELL','17005','GIRONA','GIRONES','972222324',to_date('01/05/2000','DD/MM/YYYY'), 'S','JSasun@correu.udg.edu');
INSERT INTO Alumnes VALUES(222,'58943399B','PERE','PEREZ VIDAL','CR PUJOLET 45','17005','GIRONA','GIRONES','972233445',to_date('01/05/2006','DD/MM/YYYY'),'S','PPV_gironi@gmail.com');
INSERT INTO Alumnes VALUES(333,'61261261W','MANEL','PEREZ VIDAL','CR/ AMPLE','17005','GIRONA','GIRONES','972414104',to_date('12/10/1992','DD/MM/YYYY'), 'N','MPerez@correu.udg.edu');
INSERT INTO Alumnes VALUES(444,'93380262D','LOLA','SASUN MORELL','CR.NOU 45','17003','GIRONA','GIRONES','972343434',to_date('01/05/2000','DD/MM/YYYY'), 'N','LSasun@correu.udg.edu');
INSERT INTO Alumnes VALUES(555,'53599607Q','JORDI','PEREZ PALS','CR GROS 32','08025','BARCELONA','BARCELONES','932345678',to_date('23/05/2006','DD/MM/YYYY'), 'N','GeorgePSticks@gmail.com');
INSERT INTO Alumnes VALUES(666,'57588249K','ANNA','VAZQUEZ TORREMIRONA','CR PIVERT 32','17600','FIGUERES','ALT EMPORDA','972232232',to_date('01/06/2005','DD/MM/YYYY'), NULL,'AVazquez@correu.udg.edu');
INSERT INTO Alumnes VALUES(777,'38755594L','RODRIGO','BENET CANTALLOPS','PL REPUBLICA 1 ','17257','TORROELLA MONTGRI','BAIX EMPORDA','972750001',to_date('12/10/2005','DD/MM/YYYY'), 'N','RBenet@correu.udg.edu');
INSERT INTO Alumnes VALUES(888,'77355912N','PERE','PRATS PIGEM','CR CROSCAT 15','17772','SANTA PAU','GARROTXA','972680003',to_date('01/05/2002','DD/MM/YYYY'), NULL,'PPrats@correu.udg.edu');
INSERT INTO Alumnes VALUES(999,'71150013L','GEMMA','PRATS PIGEM','CR CROSCAT 15','17772','SANTA PAU','GARROTXA','972680003',to_date('04/04/1976','DD/MM/YYYY'), 'N','GPrats@correu.udg.edu');
INSERT INTO Alumnes VALUES(1200,'67683116G','OLGA','PRAT SALA','PUIGVISTOS,4','17003','GIRONA','GIRONES','972345445',to_date('15/01/2000','DD/MM/YYYY'), 'N','Olga.Prat@gmail.com');


INSERT INTO Professors VALUES(2100,'38121458T','JOSEP','MORALES ANTUNEZ','VELL 45','17002','GIRONA','GIRONES','972234578',to_date('12/03/1964','DD/MM/YYYY'),'N','josep.morales@udg.edu','Titular',2500,1,to_date('02/09/1987','DD/MM/YYYY'));
INSERT INTO Professors VALUES(2500,'40157256F','MARTIN','MORALES BLESA','PL.CATALUNYA 34','17001','GIRONA','GIRONES','972412345',to_date('12/12/1952','DD/MM/YYYY'),'S','martin.morales@udg.edu','Titular',2600,1,to_date('01/09/1980','DD/MM/YYYY')); 
INSERT INTO Professors VALUES(2600,'42587269G','MARIA','PUIG PUIG','LLUIS COMPANYS','17800','OLOT','GARROTXA','972262623',to_date('12/01/1954','DD/MM/YYYY'),'N','maria.puig@udg.edu','Titular',2550,3,to_date('01/08/1989','DD/MM/YYYY')); 
INSERT INTO Professors VALUES(2700,'39444221Q','PERE','SERRA SOLER','ENTENZA 125','08030','BARCELONA','BARCELONES','933456789',to_date('01/07/1970','DD/MM/YYYY'),'N','pere.serra@udg.edu','Titular',2600,4,to_date('08/07/1986','DD/MM/YYYY')); 
INSERT INTO Professors VALUES(3000,'41234941D','PERE','SOLA MORALES','NOU 23','17001','GIRONA','GIRONES','972212223',to_date('12/12/1959','DD/MM/YYYY'),'S','pere.sola@udg.edu','Titular',2500,1,to_date('01/09/1978','DD/MM/YYYY')); 
INSERT INTO Professors VALUES(5555,'40439420S','MARTA','MUNE BORDES','NOU 34','17001','GIRONA','GIRONES','972228976',to_date('23/04/1969','DD/MM/YYYY'),'N','marta.mune@gmail.com','Associat',900,2,to_date('02/07/2001','DD/MM/YYYY')); 
INSERT INTO Professors VALUES(6500,'44518902D','SERGI','GONZALEZ GONZALEZ','SARDANA 23',null,'BANYOLES','PLA DE L''ESTANY','972575758',to_date('18/03/1970','DD/MM/YYYY'),'S','sergigonza@gmail.com','Associat',800,1,to_date('02/10/1998','DD/MM/YYYY')); 
INSERT INTO Professors VALUES(7000,'40586221P','EVA','GARCIA PLANES','DIAGONAL 728','08028','BARCELONA','BARCELONES','934104578',to_date('23/07/1969','DD/MM/YYYY'),'N','garciaeva@hotmail.com','Associat',950,2,to_date('01/09/1999','DD/MM/YYYY'));
INSERT INTO Professors VALUES(8000,'43458222O','MANOLO','LOPEZ LOPEZ','MONTILIVI 54','17003','GIRONA','GIRONES','972414344',to_date('12/03/1965','DD/MM/YYYY'),'N','lolo1965@hotmail,com','Associat',750,1,to_date('01/09/1997','DD/MM/YYYY'));
INSERT INTO Professors VALUES(12000,'40123123S','PERE','VIDAL POUS','RAMBLA 18','17001','GIRONA','GIRONES','972232321',to_date('19/09/1954','DD/MM/YYYY'),'S','pere.vidal@udg.edu','Titular',2500,5,to_date('02/09/1990','DD/MM/YYYY'));

INSERT INTO Carreres VALUES('GEINF','ENGINYERIA INFORMATICA', 100, 2010);
INSERT INTO Carreres VALUES('GDDV','DISSENY I DESENVOLUPAMENT DE VIDEOJOCS',40,2014);
INSERT INTO Carreres VALUES('GEB','ENGINYERIA BIOMEDICA',40,2016);
INSERT INTO Carreres VALUES('GETI','ENGINYERIA TECNOLOGIES INDUSTRIALS',70,2009);

INSERT INTO Assignatures VALUES(1,'MULTIMEDIA I INTERFICIES USUARI',4.50,2100,1,2,'obligatoria','GEINF');
INSERT INTO Assignatures VALUES(2,'SISTEMES DE GESTIO DE BASES DE DADES',6,2500,1,2,'optativa','GEINF');
INSERT INTO Assignatures VALUES(3,'ANALISI I PROCESSAMENT IMATGES',9,8000,1,1,'optativa','GEINF');
INSERT INTO Assignatures VALUES(4,'DISSENY DE MOTORS DE JOCS',6,6500,1,3,'obligatoria','GDDV');
INSERT INTO Assignatures VALUES(5,'SISTEMES MULTIJUGADOR',4.50,3000,1,2,'optativa','GDDV');
INSERT INTO Assignatures VALUES(6,'INICIATIVES EMPRESARIALS',6,2700,1,5,'optativa','GDDV');
INSERT INTO Assignatures VALUES(7,'SISTEMES ROBOTITZATS',6,8000,2,1,'obligatoria','GEB');
INSERT INTO Assignatures VALUES(8,'INSTRUMENTACIO ELECTRONICA',6,5555,1,1,'obligatoria','GEB');
INSERT INTO Assignatures VALUES(9,'BIOFABRICACIO',9,12000,1,1,'optativa','GEB');
INSERT INTO Assignatures VALUES(10,'ARQUITECTURA DE COMPUTADORS',6,2100,2,2,'obligatoria','GEINF');

INSERT INTO Departaments VALUES (1,'INFORMATICA MATEMATICA APLICADA I ESTADISTICA','POLITECNICA 4','972418417',2100);
INSERT INTO Departaments VALUES (2,'FISICA','POLITECNICA 2','972418288',7000);
INSERT INTO Departaments VALUES (3,'ARQUITECTURA DE COMPUTADORS','POLITECNICA 4','972418456',2600);
INSERT INTO Departaments VALUES (4,'ORGANITZACIO I GESTIO EMPRESES','POLITECNICA 1','972414141',2700);
INSERT INTO Departaments VALUES (5,'CIENCIES MEDIQUES','EDIFICI CENTRE','972419741',12000);

-- per evitar dependències creuades creem aquí la clau forana departament de la taula Professors
ALTER TABLE Professors
  ADD CONSTRAINT cf_departament
    FOREIGN KEY (departament)
    REFERENCES Departaments (codi);

INSERT INTO Matricula VALUES (11,1,3.00,6.00);
INSERT INTO Matricula VALUES (11,2,2.00,7.00);
INSERT INTO Matricula VALUES (11,5,1.00,6.00);
INSERT INTO Matricula VALUES (22,1,1.00,9.00);
INSERT INTO Matricula VALUES (22,2,1.00,7.00);
INSERT INTO Matricula VALUES (22,3,2.00,9.00);
INSERT INTO Matricula VALUES (33,1,1.00,6.00);
INSERT INTO Matricula VALUES (44,4,4.00,7.00);
INSERT INTO Matricula VALUES (55,1,5.00,9.00);
INSERT INTO Matricula VALUES (55,2,1.00,9.00);
INSERT INTO Matricula VALUES (55,3,1.00,8.00);
INSERT INTO Matricula VALUES (55,4,2.00,5.00);
INSERT INTO Matricula VALUES (66,7,1.00,8.00);
INSERT INTO Matricula VALUES (66,8,1.00,8.00);
INSERT INTO Matricula VALUES (66,9,1.00,9.00);
INSERT INTO Matricula VALUES (99,7,1.00,8.00);
INSERT INTO Matricula VALUES (99,8,1.00,8.00);
INSERT INTO Matricula VALUES (99,9,1.00,7.00);
INSERT INTO Matricula VALUES (111,2,1.00,6.00);
INSERT INTO Matricula VALUES (111,3,1.00,7.00);
INSERT INTO Matricula VALUES (111,4,1.00,4.00);
INSERT INTO Matricula VALUES (111,5,1.00,6.00);
INSERT INTO Matricula VALUES (111,6,1.00,5.00);
INSERT INTO Matricula VALUES (222,1,1.00,8.00);
INSERT INTO Matricula VALUES (222,2,1.00,9.00);
INSERT INTO Matricula VALUES (222,3,1.00,3.00);
INSERT INTO Matricula VALUES (222,5,1.00,6.00);
INSERT INTO Matricula VALUES (666,2,4.00,1.00);
INSERT INTO Matricula VALUES (666,4,4.00,1.00);
INSERT INTO Matricula VALUES (666,5,2.00,2.00);
INSERT INTO Matricula VALUES (777,4,1.00,3.00);
INSERT INTO Matricula VALUES (777,5,4.00,3.00);
INSERT INTO Matricula VALUES (777,6,6.00,0.00);
INSERT INTO Matricula VALUES (888,2,5.00,0.00);
INSERT INTO Matricula VALUES (888,3,6.00,1.00);
INSERT INTO Matricula VALUES (888,5,6.00,6.00);
INSERT INTO Matricula VALUES (111,10,1.00,6.50);
INSERT INTO Matricula VALUES (99,10,1.00,5.00);
INSERT INTO Matricula VALUES (11,10,1.00,10.00);

INSERT INTO AssignaturesProfessors VALUES (1,2100);
INSERT INTO AssignaturesProfessors VALUES (1,8000);
INSERT INTO AssignaturesProfessors VALUES (1,3000);
INSERT INTO AssignaturesProfessors VALUES (2,2500);
INSERT INTO AssignaturesProfessors VALUES (9,12000);
INSERT INTO AssignaturesProfessors VALUES (3,6500);
INSERT INTO AssignaturesProfessors VALUES (3,8000);
INSERT INTO AssignaturesProfessors VALUES (4,6500);
INSERT INTO AssignaturesProfessors VALUES (5,2100);
INSERT INTO AssignaturesProfessors VALUES (5,3000);
INSERT INTO AssignaturesProfessors VALUES (5,6500);
INSERT INTO AssignaturesProfessors VALUES (5,8000);
INSERT INTO AssignaturesProfessors VALUES (6,2700);
INSERT INTO AssignaturesProfessors VALUES (7,8000);
INSERT INTO AssignaturesProfessors VALUES (8,5555);
INSERT INTO AssignaturesProfessors VALUES (10,2100);
INSERT INTO AssignaturesProfessors VALUES (10,3000);
INSERT INTO AssignaturesProfessors VALUES (10,8000);
INSERT INTO AssignaturesProfessors VALUES (10,6500);

COMMIT;

select 'Departaments' AS "Taula", count(*) AS "HiHa", 5-COUNT(*) AS "Falten" from Departaments UNION 
select 'Alumnes' AS "Taula", count(*) AS "HiHa", 19-COUNT(*) AS "Falten" from Alumnes UNION
select 'Professors' AS "Taula", count(*) AS "HiHa", 10-COUNT(*) AS "Falten" from Professors UNION 
select 'Assignatures' AS "Taula", count(*) AS "HiHa", 10-COUNT(*) AS "Falten" from Assignatures UNION 
select 'AssignaturesProfessor' AS "Taula", count(*) AS "HiHa", 19-COUNT(*) AS "Falten" from AssignaturesProfessors UNION 
select 'Matricula' AS "Taula", count(*) AS "HiHa", 39-COUNT(*) AS "Falten" from Matricula UNION
select 'Carreres' AS "Taula", count(*) AS "HiHa",4-count(*) AS "Falten" from Carreres; 
set echo on;
