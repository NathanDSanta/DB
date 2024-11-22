-- Bases de Dades 2024/25 2on GEINF/GDDV, 3er GEB Universitat de Girona
-- Creació base de dades d'exemple per les pràctiques
-- v1 per ORACLE (2024-02-17)

SET ECHO OFF

PROMPT Construint les taules per la BD de treball...

SET termout on
SET feedback off
-- si alguna cosa no va prou bé, podem posar el feedback a on en la linia anterior

prompt Primer fem un DROP VIEW Eines per evitar els problemes de l'exemple dels idiomes i les Vistes 
prompt que es veurà cap al final del bloc de l'SQL. Donarà un error si no existeix... no passa res.
DROP VIEW Eines;
DROP TABLE EinesTaula CASCADE CONSTRAINT;

prompt Ara fem "reset" de la Base de Dades esborrant i tornant a crear totes les taules.
prompt La primera vegada donarà errors 'ORA-00942: table or view does not exist'
prompt que podem ignorar (són els de les comandes DROP TABLE que hi ha abans de cada
prompt CREATE TABLE i com que encara no existeix la taula el DROP TABLE dóna error)


--
-- Table structure for table `Usuaris`
--

DROP TABLE Usuaris CASCADE CONSTRAINT;
CREATE TABLE Usuaris (
  alias varchar2(15) NOT NULL CONSTRAINT cp_usuaris PRIMARY KEY,
  nom varchar2(20) DEFAULT NULL,
  cognoms varchar2(45) DEFAULT NULL,
  dataAlta date DEFAULT NULL,
  email varchar2(25) DEFAULT NULL,
  telefon varchar2(12) DEFAULT NULL,
  DD_Lat decimal(9,6) DEFAULT NULL,
  DD_Long decimal(9,6) DEFAULT NULL,
  saldo decimal(9,2) DEFAULT NULL
);


--
-- Table structure for table `TipusPersonatges`
--

DROP TABLE TipusPersonatges CASCADE CONSTRAINT;
CREATE TABLE TipusPersonatges (
  nom varchar2(15) NOT NULL  CONSTRAINT cp_tipusPersonatges PRIMARY KEY,
  descripcio varchar2(60) DEFAULT NULL,
  costMensual decimal(5,2) DEFAULT NULL,
  personatgeModel varchar2(15) NULL
);

--
-- Table structure for table `Personatges`
--

DROP TABLE Personatges CASCADE CONSTRAINT;
CREATE TABLE Personatges (
  alias varchar2(15) NOT NULL CONSTRAINT cp_personatges PRIMARY KEY,
  despesaMensual decimal(5,2) DEFAULT NULL,
  dataCreacio date DEFAULT NULL,
  usuari varchar2(15) NOT NULL,
  tipusPersonatge varchar2(15) DEFAULT NULL,
  CONSTRAINT cf_personatges_usuaris
    FOREIGN KEY (usuari)
    REFERENCES usuaris (alias),
  CONSTRAINT cf_personatges_tipus
    FOREIGN KEY (tipusPersonatge)
    REFERENCES tipusPersonatges (nom)
);

    

--
-- Table structure for table `Eines`
--

DROP TABLE Eines CASCADE CONSTRAINT;
CREATE TABLE Eines (
  codi varchar2(10) NOT NULL CONSTRAINT cp_eines PRIMARY KEY,
  descripcio varchar2(45) DEFAULT NULL,
  preuHoraLloguer decimal(3,2) DEFAULT NULL
);    
    
--
-- Table structure for table `GrupsVehicles`
--

DROP TABLE GrupsVehicles CASCADE CONSTRAINT;
CREATE TABLE GrupsVehicles (
  codi varchar2(10) NOT NULL CONSTRAINT cp_grupsVehicles PRIMARY KEY,
  descripcio varchar2(45) DEFAULT NULL
);    
    
--
-- Table structure for table `Combustibles`
--

DROP TABLE Combustibles CASCADE CONSTRAINT;
CREATE TABLE Combustibles (
  descripcio varchar2(20) NOT NULL CONSTRAINT cp_combustibles PRIMARY KEY,
  preuUnitat decimal(4,2) DEFAULT NULL
);

--
-- Table structure for table `Vehicles`
--

DROP TABLE Vehicles CASCADE CONSTRAINT;
CREATE TABLE Vehicles (
  codi varchar2(10) NOT NULL  CONSTRAINT cp_vehicles PRIMARY KEY,
  descripcio varchar2(45) DEFAULT NULL,
  color varchar2(45) DEFAULT NULL,
  consum decimal(4,2) DEFAULT NULL,
  dataCompra date DEFAULT NULL,
  preu decimal(8,2) DEFAULT NULL,
  grupVehicle varchar2(10) NOT NULL,
  combustible varchar2(20) DEFAULT 'gasolina' NOT NULL,
  propietari varchar2(15) NOT NULL,
  CONSTRAINT cf_vehicles_grupsVehicles1
    FOREIGN KEY (grupVehicle)
    REFERENCES grupsVehicles (codi),
  CONSTRAINT cf_vehicles_combustible1
    FOREIGN KEY (combustible)
    REFERENCES combustibles (descripcio),
 CONSTRAINT cf_vehicles_propietari1
    FOREIGN KEY (propietari)
    REFERENCES usuaris (alias)
);

--
-- Table structure for table `Curses`
--

DROP TABLE Curses CASCADE CONSTRAINT ;
CREATE TABLE Curses (
  codi varchar2(15) NOT NULL CONSTRAINT cp_curses PRIMARY KEY,
  nom varchar2(45) DEFAULT NULL,
  premi decimal(5,0) DEFAULT NULL,
  inscripcio decimal(5,2) DEFAULT NULL,
  iniciPrevist date DEFAULT NULL,
  iniciReal date DEFAULT NULL,
  millorTemps decimal(6,3) DEFAULT NULL
);

--
-- Table structure for table `PersonatgesEines`
--

DROP TABLE PersonatgesEines CASCADE CONSTRAINT;
CREATE TABLE PersonatgesEines (
  eina varchar2(10) NOT NULL,
  personatge varchar2(15) NOT NULL,
  habilitat decimal(3,1) DEFAULT NULL,
  CONSTRAINT cp_personatgesEines PRIMARY KEY (personatge, eina),
  CONSTRAINT cf_personatgesEines_pers
    FOREIGN KEY (personatge)
    REFERENCES personatges (alias),
  CONSTRAINT cf_personatgesEines_eina
    FOREIGN KEY (eina)
    REFERENCES eines (codi)
);

--
-- Table structure for table `EinesVehicles`
--

DROP TABLE EinesVehicles CASCADE CONSTRAINT;
CREATE TABLE EinesVehicles (
  vehicle varchar2(10) NOT NULL,
  eina varchar2(10) NOT NULL,
  compatibilitat decimal(3,1) DEFAULT NULL,
  horesUsada decimal(3,0) DEFAULT NULL,
  PRIMARY KEY (eina, vehicle),
  CONSTRAINT cf_einesVehicles_eina
    FOREIGN KEY (eina)
    REFERENCES eines (codi),
  CONSTRAINT cf_einesVehicles_veh
    FOREIGN KEY (vehicle)
    REFERENCES vehicles (codi)
);

--
-- Table structure for table `EinesGrupVehicles`
--

DROP TABLE EinesGrupVehicles CASCADE CONSTRAINT;
CREATE TABLE EinesGrupVehicles (
  eina varchar2(10) NOT NULL,
  grup varchar2(10) NOT NULL,
  compatibilitatDefecte decimal(3,1) DEFAULT NULL,
  PRIMARY KEY (eina, grup),
  CONSTRAINT cf_einesGrupsVehicles_eina
    FOREIGN KEY (eina)
    REFERENCES eines (codi),
  CONSTRAINT cf_einesGrupsVehicles_grup
    FOREIGN KEY (grup)
    REFERENCES grupsVehicles (codi)
);

--
-- Table structure for table `ParticipantsCurses`
--

DROP TABLE ParticipantsCurses CASCADE CONSTRAINT;
CREATE TABLE ParticipantsCurses (
  codi INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, -- exemple autoincrement
  cursa varchar2(15) NOT NULL,
  vehicle varchar2(10) NOT NULL,
  personatge varchar2(15) NOT NULL,
  temps decimal(6,3) DEFAULT NULL,
  CONSTRAINT cf_Participants_cursa
    FOREIGN KEY (cursa)
    REFERENCES curses (codi),
  CONSTRAINT cf_Participants_vehicle
    FOREIGN KEY (vehicle)
    REFERENCES vehicles (codi),
  CONSTRAINT cf_Participants_personatge
    FOREIGN KEY (personatge)
    REFERENCES personatges (alias)
);

--
-- Table structure for table `PersonatgesGrupVehicles`
--

DROP TABLE PersonatgesGrupVehicles CASCADE CONSTRAINT;
CREATE TABLE PersonatgesGrupVehicles (
  grupVehicles varchar2(10) NOT NULL,
  personatge varchar2(15) NOT NULL,
  habilitat decimal(3,1) DEFAULT NULL,
  PRIMARY KEY (personatge, grupVehicles),
  CONSTRAINT cf_personatgesGrups_pers
    FOREIGN KEY (personatge)
    REFERENCES personatges (alias),
  CONSTRAINT cf_personatgesGrups_veh
    FOREIGN KEY (grupVehicles)
    REFERENCES grupsVehicles (codi)
);

prompt inserts a usuaris 
INSERT INTO Usuaris (alias, nom, cognoms, dataAlta, email, telefon, DD_Lat, DD_Long, saldo) 
  VALUES ('aaaauuuu','Rodrigo','Benet Cantallops',to_date('2020-02-12 13:02:34','YYYY-MM-DD HH24:MI:SS'),'RBenet@correu.udg.edu','677750001',42.957239,-9.190057,5000.00);
INSERT INTO Usuaris (alias, nom, cognoms, dataAlta, email, telefon, DD_Lat, DD_Long, saldo) 
  VALUES ('ammeg76','Gemma','Prats Pigem',to_date('2021-06-24 23:29:36','YYYY-MM-DD HH24:MI:SS'),'GPrats@correu.udg.edu','658680003',37.879570,-4.780620,NULL);
INSERT INTO Usuaris (alias, nom, cognoms, dataAlta, email, telefon, DD_Lat, DD_Long, saldo) 
  VALUES ('BigPine','Manel','Pi Gros',to_date('2021-02-27 06:12:15','YYYY-MM-DD HH24:MI:SS'),'MPi@correu.udg.edu','669567898',41.917589,3.163284,7500.00);
INSERT INTO Usuaris (alias, nom, cognoms, dataAlta, email, telefon, DD_Lat, DD_Long, saldo) 
  VALUES ('dos31416','Maria','Pi Pi',to_date('2020-02-02 05:15:39','YYYY-MM-DD HH24:MI:SS'),'PiPiMaria@gmail.com','648262626',42.786829,0.692773,15940.00);
INSERT INTO Usuaris (alias, nom, cognoms, dataAlta, email, telefon, DD_Lat, DD_Long, saldo) 
  VALUES ('elDeLesClaus','Pere','Prats Pigem',to_date('2020-01-01 11:45:19','YYYY-MM-DD HH24:MI:SS'),'PPrats@correu.udg.edu','639680003',58.596582,-3.526456,95999.00);
INSERT INTO Usuaris (alias, nom, cognoms, dataAlta, email, telefon, DD_Lat, DD_Long, saldo) 
  VALUES ('exAdam','Eva','Puig Pelat',to_date('2020-03-01 21:04:41','YYYY-MM-DD HH24:MI:SS'),'EvaPP1996@hotmail.com','625262728',39.736618,3.056348,NULL);
INSERT INTO Usuaris (alias, nom, cognoms, dataAlta, email, telefon, DD_Lat, DD_Long, saldo) 
  VALUES ('fathers','Josep M.','Paque Elias',to_date('2021-06-01 00:52:15','YYYY-MM-DD HH24:MI:SS'),'eskimal95@hotmail.com','674778985',42.693679,2.896999,500.00);
INSERT INTO Usuaris (alias, nom, cognoms, dataAlta, email, telefon, DD_Lat, DD_Long, saldo) 
  VALUES ('granPili','Pilar','Mata Depera',to_date('2021-01-06 08:08:23','YYYY-MM-DD HH24:MI:SS'),'PMata@correu.udg.edu','653414870',39.505709,-0.365448,15000.00);
INSERT INTO Usuaris (alias, nom, cognoms, dataAlta, email, telefon, DD_Lat, DD_Long, saldo) 
  VALUES ('H2O','Enrique','Lopez Aguado',to_date('2020-04-01 06:56:55','YYYY-MM-DD HH24:MI:SS'),'ELopez@correu.udg.edu','680222324',42.231685,2.595641,NULL);
INSERT INTO Usuaris (alias, nom, cognoms, dataAlta, email, telefon, DD_Lat, DD_Long, saldo) 
  VALUES ('KinKon','Ferran','Lopez Aguado',to_date('2020-01-06 18:18:10','YYYY-MM-DD HH24:MI:SS'),'FLopez@correu.udg.edu','602233445',42.133524,3.120786,NULL);
INSERT INTO Usuaris (alias, nom, cognoms, dataAlta, email, telefon, DD_Lat, DD_Long, saldo) 
  VALUES ('lola89','Lola','Sasun Morell',to_date('2020-05-01 10:17:09','YYYY-MM-DD HH24:MI:SS'),'LSasun@correu.udg.edu','693343434',40.538414,0.473666,38945.00);
INSERT INTO Usuaris (alias, nom, cognoms, dataAlta, email, telefon, DD_Lat, DD_Long, saldo) 
  VALUES ('lolo92','Manel','Perez Vidal',to_date('2020-10-12 06:55:44','YYYY-MM-DD HH24:MI:SS'),'MPerez@correu.udg.edu','600414104',41.933704,2.254012,38945.00);
INSERT INTO Usuaris (alias, nom, cognoms, dataAlta, email, telefon, DD_Lat, DD_Long, saldo) 
  VALUES ('mapepu','Marta','Peris Pujol',to_date('2020-03-02 04:25:37','YYYY-MM-DD HH24:MI:SS'),'PerisPujolMarta@gmail.com','686667789',48.122922,-1.714913,100.00);
INSERT INTO Usuaris (alias, nom, cognoms, dataAlta, email, telefon, DD_Lat, DD_Long, saldo) 
  VALUES ('PePeVi','Pere','Perez Vidal',to_date('2020-03-01 14:55:46','YYYY-MM-DD HH24:MI:SS'),'PPV_gironi@gmail.com','611233445',42.071612,2.949498,115000.00);
INSERT INTO Usuaris (alias, nom, cognoms, dataAlta, email, telefon, DD_Lat, DD_Long, saldo) 
  VALUES ('Prat97','Olga','Prat Sala',to_date('2020-01-15 08:15:15','YYYY-MM-DD HH24:MI:SS'),'Olga.Prat@gmail.com','650345445',42.043733,3.134903,27987.00);
INSERT INTO Usuaris (alias, nom, cognoms, dataAlta, email, telefon, DD_Lat, DD_Long, saldo) 
  VALUES ('princeseta','Anna','Vazquez Torremirona',to_date('2020-03-10 05:15:39','YYYY-MM-DD HH24:MI:SS'),'AVazquez@correu.udg.edu','654232232',40.561447,8.325723,47000.00);
INSERT INTO Usuaris (alias, nom, cognoms, dataAlta, email, telefon, DD_Lat, DD_Long, saldo) 
  VALUES ('sisetsese','Narcis','Sega Sega',to_date('2022-01-12 19:51:58','YYYY-MM-DD HH24:MI:SS'),'NSega@correu.udg.edu','626567890',41.156625,1.110828,10.00);
INSERT INTO Usuaris (alias, nom, cognoms, dataAlta, email, telefon, DD_Lat, DD_Long, saldo) 
  VALUES ('totiArros','Jordi','Perez Pals',to_date('2020-05-23 12:57:19','YYYY-MM-DD HH24:MI:SS'),'GeorgePSticks@gmail.com','677345678',42.429594,3.158895,81500.00);
INSERT INTO Usuaris (alias, nom, cognoms, dataAlta, email, telefon, DD_Lat, DD_Long, saldo) 
  VALUES ('VaraFlorida','Josep','Sasun Perez',to_date('2020-04-11 17:29:15','YYYY-MM-DD HH24:MI:SS'),'JSasun@correu.udg.edu','681222324',42.039871,3.122781,72000.00);

prompt inserts a tipusPersonatges
INSERT INTO TipusPersonatges (nom, descripcio, costMensual, personatgeModel) 
  VALUES ('Assenyat','No te gaire habilitat amb la majoria de tipus de vehicles',250.00,'xinuxanu');
INSERT INTO TipusPersonatges (nom, descripcio, costMensual, personatgeModel) 
  VALUES ('Esbojarrat','Ho condueix tot acceptamblement pero no te seny',100.00,'elSonat');
INSERT INTO TipusPersonatges (nom, descripcio, costMensual, personatgeModel) 
  VALUES ('Especialista','Condueixa a la perfeccio un o dos tipus de vehicles',500.00,'finezza');
INSERT INTO TipusPersonatges (nom, descripcio, costMensual, personatgeModel) 
  VALUES ('Professional','Condueix qualsevol vehicle i la majoria ho fa molt be',750.00,'tuManes');

prompt inserts a personatges 
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('apanemhitots',1.99,to_date('2020-12-03 23:55:01','YYYY-MM-DD HH24:MI:SS'),'lolo92','Esbojarrat');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('aviMiquel',15.00,to_date('2021-05-23 14:00:19','YYYY-MM-DD HH24:MI:SS'),'totiArros','Assenyat');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('beWater',65.00,to_date('2020-04-01 06:58:50','YYYY-MM-DD HH24:MI:SS'),'H2O','Professional');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('bubu',20.00,to_date('2020-01-15 08:15:59','YYYY-MM-DD HH24:MI:SS'),'Prat97','Assenyat');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('copDeVolant',35.00,to_date('2020-12-04 01:36:40','YYYY-MM-DD HH24:MI:SS'),'lolo92','Especialista');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('elCec',25.00,to_date('2021-04-01 22:13:49','YYYY-MM-DD HH24:MI:SS'),'elDeLesClaus','Esbojarrat');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('elCorbes',25.00,to_date('2022-04-05 00:07:10','YYYY-MM-DD HH24:MI:SS'),'ammeg76','Especialista');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('elQuiet',10.00,to_date('2021-05-01 15:05:00','YYYY-MM-DD HH24:MI:SS'),'PePeVi','Assenyat');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('elSonat',15.00,to_date('2021-10-12 14:10:14','YYYY-MM-DD HH24:MI:SS'),'aaaauuuu','Esbojarrat');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('fillaDenMiquel',70.00,to_date('2021-08-07 12:00:11','YYYY-MM-DD HH24:MI:SS'),'totiArros','Professional');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('fillDenMiquel',35.00,to_date('2020-05-23 18:12:08','YYYY-MM-DD HH24:MI:SS'),'totiArros','Especialista');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('finezza',35.00,to_date('2021-01-06 13:55:02','YYYY-MM-DD HH24:MI:SS'),'granPili','Especialista');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('floquet1',20.00,to_date('2021-05-01 18:30:12','YYYY-MM-DD HH24:MI:SS'),'KinKon','Assenyat');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('floquet2',8.00,to_date('2021-05-01 21:07:22','YYYY-MM-DD HH24:MI:SS'),'KinKon','Esbojarrat');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('gasAFons',40.00,to_date('2020-05-01 12:03:10','YYYY-MM-DD HH24:MI:SS'),'elDeLesClaus','Especialista');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('gustavo',60.00,to_date('2022-02-07 21:13:30','YYYY-MM-DD HH24:MI:SS'),'princeseta','Professional');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('James',50.00,to_date('2021-10-30 15:16:17','YYYY-MM-DD HH24:MI:SS'),'BigPine','Professional');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('jesuset',20.00,to_date('2020-05-01 18:12:20','YYYY-MM-DD HH24:MI:SS'),'VaraFlorida','Assenyat');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('keepCalm',75.00,to_date('2020-03-07 19:46:12','YYYY-MM-DD HH24:MI:SS'),'mapepu','Professional');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('laPoma',10.00,to_date('2020-08-07 23:39:21','YYYY-MM-DD HH24:MI:SS'),'exAdam','Esbojarrat');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('netDenMiquel',10.00,to_date('2020-05-23 14:07:51','YYYY-MM-DD HH24:MI:SS'),'totiArros','Esbojarrat');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('pacient',27.00,to_date('2020-05-01 12:00:00','YYYY-MM-DD HH24:MI:SS'),'lola89','Especialista');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('sargantana',15.00,to_date('2020-04-05 06:20:18','YYYY-MM-DD HH24:MI:SS'),'dos31416','Assenyat');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('tranki',10.00,to_date('2021-10-12 14:00:10','YYYY-MM-DD HH24:MI:SS'),'aaaauuuu','Assenyat');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('tuManes',60.00,to_date('2020-05-01 13:53:31','YYYY-MM-DD HH24:MI:SS'),'elDeLesClaus','Professional');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('tuPaguesJoCobro',55.00,to_date('2021-01-03 15:07:40','YYYY-MM-DD HH24:MI:SS'),'PePeVi','Professional');
INSERT INTO Personatges (alias, despesaMensual, dataCreacio, usuari, tipusPersonatge) 
  VALUES ('xinuxanu',15.00,to_date('2021-08-07 21:14:00','YYYY-MM-DD HH24:MI:SS'),'exAdam','Assenyat');


ALTER TABLE tipusPersonatges
  ADD CONSTRAINT cf_tipusPerson_person
    FOREIGN KEY (personatgeModel)
    REFERENCES personatges (alias);
    
    
prompt inserts a combustibles 
INSERT INTO Combustibles (descripcio, preuUnitat) VALUES ('electricitat',0.10);
INSERT INTO Combustibles (descripcio, preuUnitat) VALUES ('gas',0.80);
INSERT INTO Combustibles (descripcio, preuUnitat) VALUES ('gasoil',1.55);
INSERT INTO Combustibles (descripcio, preuUnitat) VALUES ('gasolina',1.65);
INSERT INTO Combustibles (descripcio, preuUnitat) VALUES ('huma',0.00);

prompt inserts a curses
INSERT INTO Curses (codi, nom, premi, inscripcio, iniciPrevist, iniciReal, millorTemps) 
  VALUES ('Rally2020','Rally carreteretes 2020',5000,750.00,
    to_date('2020-04-30 07:00:00','YYYY-MM-DD HH24:MI:SS'),
    to_date('2020-04-30 07:00:00','YYYY-MM-DD HH24:MI:SS'),15.400);
INSERT INTO Curses (codi, nom, premi, inscripcio, iniciPrevist, iniciReal, millorTemps) 
  VALUES ('Rally2021','Rally carreteretes 2021',5000,750.00,
    to_date('2021-04-30 07:00:00','YYYY-MM-DD HH24:MI:SS'),
    to_date('2021-04-30 07:00:00','YYYY-MM-DD HH24:MI:SS'),16.290);
INSERT INTO Curses (codi, nom, premi, inscripcio, iniciPrevist, iniciReal, millorTemps) 
  VALUES ('Rally2022','Rally carreteretes 2022',5000,750.00,
    to_date('2022-04-30 07:00:00','YYYY-MM-DD HH24:MI:SS'),
    to_date('2022-04-30 07:00:00','YYYY-MM-DD HH24:MI:SS'),16.360);
INSERT INTO Curses (codi, nom, premi, inscripcio, iniciPrevist, iniciReal, millorTemps) 
  VALUES ('RuralEmp2021','Raid rural empordanes',2000,500.00,
    to_date('2021-06-24 09:00:00','YYYY-MM-DD HH24:MI:SS'),
    to_date('2021-06-24 09:15:00','YYYY-MM-DD HH24:MI:SS'),15.180);
INSERT INTO Curses (codi, nom, premi, inscripcio, iniciPrevist, iniciReal, millorTemps) 
  VALUES ('VoltaMedes2022','Volta ciclista a Les Medes',500,100.00,
    to_date('2022-09-11 17:14:00','YYYY-MM-DD HH24:MI:SS'),
    to_date('2022-09-11 17:14:00','YYYY-MM-DD HH24:MI:SS'),1.060);
INSERT INTO Curses (codi, nom, premi, inscripcio, iniciPrevist,iniciReal) 
  VALUES ('SantJoan2023','Raid crema coca amb crema',5000,800.00, 
    to_date('2023-06-24 09:00:00','YYYY-MM-DD HH24:MI:SS'), 
    to_date('2023-06-24 09:15:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Curses(codi, nom, premi, inscripcio, iniciPrevist) 
  VALUES ('FestaCalella','Volta ciclista a Les Formigues',1000,200.00,
    to_date('2023-06-29 11:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Curses(codi, nom, premi, inscripcio, iniciPrevist) 
  VALUES ('FestaLlafranc','PujaBaixa nocturn al Faru',6000,666.00,
    to_date('2023-08-30 23:00:00','YYYY-MM-DD HH24:MI:SS'));

prompt inserts a eines
INSERT INTO Eines (codi, descripcio, preuHoraLloguer) VALUES ('alicates','alicates extensibles i universals',2.00);
INSERT INTO Eines (codi, descripcio, preuHoraLloguer) VALUES ('allens','joc claus allen',1.00);
INSERT INTO Eines (codi, descripcio, preuHoraLloguer) VALUES ('carraca','clau de carraca',1.00);
INSERT INTO Eines (codi, descripcio, preuHoraLloguer) VALUES ('clauTub','clau de tub i accessoris',2.00);
INSERT INTO Eines (codi, descripcio, preuHoraLloguer) VALUES ('gatGran','gat per vehicles pesats',3.00);
INSERT INTO Eines (codi, descripcio, preuHoraLloguer) VALUES ('gatPetit','gat per cotxes i 4x4 lleugers',2.00);
INSERT INTO Eines (codi, descripcio, preuHoraLloguer) VALUES ('martell','martell',1.00);
INSERT INTO Eines (codi, descripcio, preuHoraLloguer) VALUES ('tornavisos','tornavisos de diverses mides i puntes',1.00);
INSERT INTO Eines (codi, descripcio, preuHoraLloguer) VALUES ('torx','joc claus torx',1.00);

prompt inserts a grupsVehicles
INSERT INTO GrupsVehicles (codi, descripcio) VALUES ('4x4','cotxe tot terreny');
INSERT INTO GrupsVehicles (codi, descripcio) VALUES ('bici','bicicleta');
INSERT INTO GrupsVehicles (codi, descripcio) VALUES ('moto','motocicleta');
INSERT INTO GrupsVehicles (codi, descripcio) VALUES ('segway','segway');
INSERT INTO GrupsVehicles (codi, descripcio) VALUES ('tractor','vehicle agricola');
INSERT INTO GrupsVehicles (codi, descripcio) VALUES ('turisme','cotxe turisme');

prompt inserts a vehicles 
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('131_01','Seat 131 Supermiriafiori','fucsia',6.00,to_date('2020-12-03','YYYY-MM-DD'),7500.00,'turisme','gasolina','lolo92');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('307WRC_01','Peugeot 307 WRC','verd',12.00,to_date('2020-03-10','YYYY-MM-DD'),28000.00,'turisme','gasolina','princeseta');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('500_01','Fiat 500','blanc',5.00,to_date('2020-04-23','YYYY-MM-DD'),9000.00,'turisme','gasoil','VaraFlorida');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Civic_01','Honda Civic hibrid','blanc',3.00,to_date('2020-04-24','YYYY-MM-DD'),20000.00,'turisme','gasolina','PePeVi');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Clio_01','Renault Clio quite edition','groc',9.00,to_date('2020-02-23','YYYY-MM-DD'),12000.00,'turisme','gasolina','dos31416');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Escort_01','Ford Escort Racing','blau',12.00,to_date('2020-01-02','YYYY-MM-DD'),21000.00,'turisme','gasolina','elDeLesClaus');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Giant_01','Giant TCR 100','blanc',0.00,to_date('2022-02-20','YYYY-MM-DD'),2500.00,'bici','huma','BigPine');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Giant_02','Giant TCX advandec Pro','blanc',0.00,to_date('2022-01-06','YYYY-MM-DD'),4000.00,'bici','huma','princeseta');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('HondaCR_01','Honda CR','vermell',6.00,to_date('2020-09-11','YYYY-MM-DD'),5000.00,'moto','gasolina','elDeLesClaus');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Ibiza_01','Seat Ibiza','taronja',6.00,to_date('2020-02-28','YYYY-MM-DD'),15000.00,'turisme','gasolina','Prat97');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('JDeere_01','John Deere 7000','vermell',15.00,to_date('2021-04-01','YYYY-MM-DD'),35000.00,'tractor','gasoil','aaaauuuu');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('JDeere_02','John Deere 6000','groc',15.00,to_date('2021-03-25','YYYY-MM-DD'),30000.00,'tractor','gasoil','BigPine');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('JDeere_03','John Deere 6000','verd',14.00,to_date('2020-10-12','YYYY-MM-DD'),29000.00,'tractor','gasoil','PePeVi');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Lambor_01','Lamborgini','verd',10.00,to_date('2020-04-30','YYYY-MM-DD'),50000.00,'turisme','gasolina','H2O');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('LRover_01','Land rover','festuc',2.00,to_date('2020-12-06','YYYY-MM-DD'),2500.00,'4x4','gasoil','lolo92');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Ninja_01','Kawasaki Ninja','negre',6.00,to_date('2020-10-01','YYYY-MM-DD'),25000.00,'moto','gasolina','mapepu');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Orbea_01','Orbea classic','blau',0.00,to_date('2022-02-10','YYYY-MM-DD'),600.00,'bici','huma','totiArros');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Panda_01','Seat Panda atrotinat','groc',5.00,to_date('2020-03-31','YYYY-MM-DD'),10000.00,'turisme','gasolina','exAdam');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Polo_01','Volkswagen Polo arlequin','multicolor',7.00,to_date('2020-01-06','YYYY-MM-DD'),13000.00,'turisme','gasolina','KinKon');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Segway_01','Segway first edition','negre',0.70,to_date('2021-08-30','YYYY-MM-DD'),5000.00,'segway','electricitat','elDeLesClaus');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Segway_02','Segway first edition','grana',0.70,to_date('2020-08-30','YYYY-MM-DD'),5500.00,'segway','electricitat','lola89');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Segway_03','Segway legacy','negre',0.50,to_date('2022-01-06','YYYY-MM-DD'),2000.00,'segway','electricitat','H2O');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Segway_04','Segway legacy','gris',0.50,to_date('2022-01-06','YYYY-MM-DD'),2100.00,'segway','electricitat','aaaauuuu');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Tesla_01','Tesla S','blanc',5.00,to_date('2022-02-28','YYYY-MM-DD'),24000.00,'turisme','electricitat','granPili');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Toyota_01','Toyota Sequoya','gris',15.00,to_date('2020-01-24','YYYY-MM-DD'),60000.00,'4x4','gasolina','elDeLesClaus');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Toyota_02','Toyota Tacoma','verd',12.00,to_date('2020-03-07','YYYY-MM-DD'),40000.00,'4x4','gasoil','aaaauuuu');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Toyota_03','Toyota Prius','blau',4.00,to_date('2020-02-24','YYYY-MM-DD'),25000.00,'turisme','electricitat','KinKon');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Toyota_04','Toyota Land Cruiser','blanc',13.00,to_date('2021-06-24','YYYY-MM-DD'),55000.00,'4x4','gasolina','ammeg76');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Trek_01','Trek Domane','gris',0.00,to_date('2022-03-01','YYYY-MM-DD'),2500.00,'bici','huma','mapepu');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Trek_02','Trek Boone','vermell',0.00,to_date('2020-06-23','YYYY-MM-DD'),3500.00,'bici','huma','PePeVi');
INSERT INTO Vehicles (codi, descripcio, color, consum, dataCompra, preu, grupVehicle, combustible, propietari) 
  VALUES ('Yamaha_01','Yamaha VMAX','vermell',10.00,to_date('2021-01-31','YYYY-MM-DD'),25000.00,'moto','gasolina','granPili');

prompt inserts a einesGrupVehicles 
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('alicates','4x4',7.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('alicates','bici',5.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('alicates','moto',6.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('alicates','segway',2.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('alicates','tractor',9.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('alicates','turisme',7.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('allens','4x4',5.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('allens','bici',8.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('allens','moto',5.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('allens','segway',8.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('allens','tractor',3.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('allens','turisme',5.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('carraca','4x4',6.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('carraca','bici',3.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('carraca','moto',6.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('carraca','segway',3.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('carraca','tractor',8.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('carraca','turisme',6.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('clauTub','4x4',7.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('clauTub','bici',2.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('clauTub','moto',8.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('clauTub','segway',3.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('clauTub','tractor',9.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('clauTub','turisme',7.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('gatGran','4x4',9.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('gatGran','bici',0.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('gatGran','moto',0.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('gatGran','segway',0.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('gatGran','tractor',9.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('gatGran','turisme',6.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('gatPetit','4x4',3.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('gatPetit','bici',0.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('gatPetit','moto',0.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('gatPetit','segway',0.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('gatPetit','tractor',0.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('gatPetit','turisme',9.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('martell','4x4',7.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('martell','bici',2.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('martell','moto',3.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('martell','segway',2.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('martell','tractor',9.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('martell','turisme',7.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('tornavisos','4x4',9.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('tornavisos','bici',9.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('tornavisos','moto',9.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('tornavisos','segway',9.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('tornavisos','tractor',9.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('tornavisos','turisme',9.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('torx','4x4',8.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('torx','bici',3.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('torx','moto',7.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('torx','segway',7.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('torx','tractor',3.0);
INSERT INTO EinesGrupVehicles (eina, grup, compatibilitatDefecte) VALUES ('torx','turisme',7.0);

prompt inserts a einesVehicles 
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('307WRC_01','gatPetit',9.0,9);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('500_01','tornavisos',9.0,28);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Clio_01','allens',7.0,1);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Clio_01','gatPetit',9.0,7);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Clio_01','tornavisos',9.0,12);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Escort_01','allens',2.0,14);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Escort_01','tornavisos',9.0,1);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Giant_01','alicates',8.0,12);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Giant_01','tornavisos',9.0,6);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Giant_02','allens',9.0,24);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('HondaCR_01','clauTub',6.0,6);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Ibiza_01','allens',8.0,21);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Ibiza_01','gatPetit',7.0,21);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Ibiza_01','tornavisos',9.0,4);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('JDeere_01','gatGran',9.0,7);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('JDeere_02','alicates',7.0,1);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('JDeere_03','carraca',8.0,8);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('JDeere_03','martell',9.0,1);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('JDeere_03','tornavisos',9.0,20);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('LRover_01','allens',5.0,15);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('LRover_01','torx',9.0,8);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Ninja_01','clauTub',8.0,4);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Orbea_01','alicates',10.0,10);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Orbea_01','allens',8.0,9);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Orbea_01','tornavisos',9.0,3);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Panda_01','gatPetit',9.0,8);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Segway_01','allens',8.0,6);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Segway_01','tornavisos',9.0,8);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Segway_02','allens',8.0,15);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Segway_02','tornavisos',9.0,7);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Segway_03','allens',8.0,12);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Segway_03','tornavisos',9.0,3);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Segway_04','tornavisos',5.0,32);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Tesla_01','tornavisos',9.0,20);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Toyota_01','gatGran',8.0,4);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Toyota_01','tornavisos',9.0,1);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Toyota_01','torx',8.0,32);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Toyota_04','gatGran',9.0,6);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Toyota_04','tornavisos',9.0,6);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Toyota_04','torx',8.0,18);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Trek_01','alicates',6.0,6);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Trek_01','tornavisos',9.0,28);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Trek_02','alicates',5.0,18);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Trek_02','allens',8.0,2);
INSERT INTO EinesVehicles (vehicle, eina, compatibilitat, horesUsada) VALUES ('Yamaha_01','tornavisos',3.0,14);

prompt inserts a participantsCurses
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2020','307WRC_01','gustavo',29.080);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2020','500_01','jesuset',31.760);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2020','Civic_01','elQuiet',19.050);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2020','Clio_01','sargantana',27.300);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2020','Escort_01','elCec',15.400);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2020','Ibiza_01','bubu',22.800);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2020','Lambor_01','beWater',27.080);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2020','Panda_01','xinuxanu',NULL);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2020','Polo_01','floquet2',20.480);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2020','Toyota_01','tuManes',27.670);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2020','Toyota_02','tranki',33.690);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2020','Toyota_03','floquet1',29.380);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2021','307WRC_01','gustavo',27.200);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2021','500_01','jesuset',32.490);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2021','Civic_01','tuPaguesJoCobro',34.830);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2021','Clio_01','sargantana',25.960);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2021','Escort_01','gasAFons',25.440);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2021','Ibiza_01','bubu',19.960);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2021','Lambor_01','beWater',33.350);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2021','LRover_01','apanemhitots',33.430);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2021','Panda_01','laPoma',16.290);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2021','Polo_01','floquet1',19.900);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2021','Toyota_01','tuManes',17.350);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2021','Toyota_02','tranki',17.290);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2021','Toyota_03','floquet2',NULL);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2022','131_01','copDeVolant',26.040);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2022','307WRC_01','gustavo',NULL);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2022','500_01','jesuset',29.260);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2022','Civic_01','tuPaguesJoCobro',30.490);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2022','Clio_01','sargantana',28.520);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2022','Escort_01','gasAFons',NULL);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2022','Ibiza_01','bubu',26.040);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2022','Lambor_01','beWater',18.030);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2022','LRover_01','apanemhitots',33.140);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2022','Panda_01','xinuxanu',32.840);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2022','Polo_01','floquet1',NULL);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2022','Tesla_01','finezza',NULL);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2022','Toyota_01','tuManes',16.360);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2022','Toyota_02','tranki',28.490);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('Rally2022','Toyota_03','floquet2',29.400);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('RuralEmp2021','JDeere_01','tranki',21.420);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('RuralEmp2021','JDeere_02','James',17.730);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('RuralEmp2021','JDeere_03','tuPaguesJoCobro',16.680);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('RuralEmp2021','LRover_01','copDeVolant',17.390);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('RuralEmp2021','Toyota_01','elCec',15.770);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('RuralEmp2021','Toyota_02','elSonat',15.180);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('RuralEmp2021','Toyota_04','elCorbes',NULL);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('VoltaMedes2022','Giant_01','James',2.340);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('VoltaMedes2022','Giant_02','gustavo',2.860);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('VoltaMedes2022','HondaCR_01','elCec',1.440);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('VoltaMedes2022','Segway_01','tuManes',1.060);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('VoltaMedes2022','Segway_02','pacient',1.630);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('VoltaMedes2022','Segway_03','beWater',2.230);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('VoltaMedes2022','Segway_04','tranki',1.080);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('VoltaMedes2022','Trek_01','keepCalm',2.020);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge, temps) VALUES ('VoltaMedes2022','Trek_02','tuPaguesJoCobro',2.510);
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge) VALUES ('SantJoan2023','307WRC_01','gustavo');
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge) VALUES ('SantJoan2023','500_01','jesuset');
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge) VALUES ('SantJoan2023','Civic_01','elQuiet');
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge) VALUES ('SantJoan2023','Clio_01','sargantana');
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge) VALUES ('SantJoan2023','Escort_01','elCec');
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge) VALUES ('SantJoan2023','Ibiza_01','bubu');
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge) VALUES ('SantJoan2023','Lambor_01','beWater');
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge) VALUES ('SantJoan2023','Panda_01','xinuxanu');
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge) VALUES ('SantJoan2023','Polo_01','floquet2');
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge) VALUES ('SantJoan2023','Toyota_01','tuManes');
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge) VALUES ('SantJoan2023','Toyota_02','tranki');
INSERT INTO ParticipantsCurses (cursa, vehicle, personatge) VALUES ('SantJoan2023','Toyota_03','floquet1');

prompt inserts a personatgesEines
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','apanemhitots',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','aviMiquel',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','beWater',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','bubu',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','copDeVolant',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','elCec',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','elCorbes',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','elQuiet',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','elSonat',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','fillaDenMiquel',8.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','fillDenMiquel',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','finezza',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','floquet1',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','floquet2',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','gasAFons',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','gustavo',9.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','James',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','jesuset',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','keepCalm',9.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','laPoma',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','netDenMiquel',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','pacient',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','sargantana',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','tranki',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','tuManes',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','tuPaguesJoCobro',9.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('alicates','xinuxanu',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','apanemhitots',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','aviMiquel',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','beWater',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','bubu',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','copDeVolant',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','elCec',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','elCorbes',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','elQuiet',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','elSonat',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','fillaDenMiquel',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','fillDenMiquel',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','finezza',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','floquet1',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','floquet2',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','gasAFons',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','gustavo',6.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','James',6.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','jesuset',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','keepCalm',9.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','laPoma',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','netDenMiquel',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','pacient',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','sargantana',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','tranki',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','tuManes',10.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','tuPaguesJoCobro',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('allens','xinuxanu',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','apanemhitots',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','aviMiquel',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','beWater',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','bubu',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','copDeVolant',6.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','elCec',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','elCorbes',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','elQuiet',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','elSonat',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','fillaDenMiquel',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','fillDenMiquel',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','finezza',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','floquet1',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','floquet2',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','gasAFons',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','gustavo',10.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','James',6.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','jesuset',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','keepCalm',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','laPoma',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','netDenMiquel',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','pacient',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','sargantana',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','tranki',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','tuManes',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','tuPaguesJoCobro',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('carraca','xinuxanu',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','apanemhitots',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','aviMiquel',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','beWater',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','bubu',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','copDeVolant',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','elCec',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','elCorbes',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','elQuiet',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','elSonat',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','fillaDenMiquel',10.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','fillDenMiquel',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','finezza',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','floquet1',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','floquet2',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','gasAFons',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','gustavo',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','James',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','jesuset',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','keepCalm',10.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','laPoma',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','netDenMiquel',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','pacient',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','sargantana',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','tranki',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','tuManes',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','tuPaguesJoCobro',6.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('clauTub','xinuxanu',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','apanemhitots',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','aviMiquel',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','beWater',6.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','bubu',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','copDeVolant',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','elCec',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','elCorbes',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','elQuiet',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','elSonat',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','fillaDenMiquel',8.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','fillDenMiquel',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','finezza',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','floquet1',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','floquet2',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','gasAFons',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','gustavo',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','James',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','jesuset',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','keepCalm',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','laPoma',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','netDenMiquel',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','pacient',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','sargantana',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','tranki',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','tuManes',9.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','tuPaguesJoCobro',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatGran','xinuxanu',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','apanemhitots',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','aviMiquel',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','beWater',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','bubu',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','copDeVolant',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','elCec',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','elCorbes',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','elQuiet',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','elSonat',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','fillaDenMiquel',8.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','fillDenMiquel',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','finezza',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','floquet1',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','floquet2',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','gasAFons',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','gustavo',6.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','James',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','jesuset',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','keepCalm',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','laPoma',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','netDenMiquel',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','pacient',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','sargantana',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','tranki',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','tuManes',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','tuPaguesJoCobro',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('gatPetit','xinuxanu',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','apanemhitots',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','aviMiquel',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','beWater',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','bubu',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','copDeVolant',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','elCec',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','elCorbes',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','elQuiet',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','elSonat',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','fillaDenMiquel',10.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','fillDenMiquel',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','finezza',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','floquet1',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','floquet2',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','gasAFons',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','gustavo',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','James',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','jesuset',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','keepCalm',6.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','laPoma',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','netDenMiquel',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','pacient',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','sargantana',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','tranki',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','tuManes',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','tuPaguesJoCobro',6.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('martell','xinuxanu',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','apanemhitots',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','aviMiquel',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','beWater',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','bubu',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','copDeVolant',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','elCec',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','elCorbes',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','elQuiet',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','elSonat',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','fillaDenMiquel',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','fillDenMiquel',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','finezza',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','floquet1',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','floquet2',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','gasAFons',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','gustavo',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','James',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','jesuset',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','keepCalm',6.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','laPoma',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','netDenMiquel',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','pacient',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','sargantana',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','tranki',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','tuManes',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','tuPaguesJoCobro',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('tornavisos','xinuxanu',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','apanemhitots',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','aviMiquel',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','beWater',10.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','bubu',3.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','copDeVolant',6.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','elCec',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','elCorbes',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','elQuiet',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','elSonat',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','fillaDenMiquel',9.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','fillDenMiquel',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','finezza',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','floquet1',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','floquet2',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','gasAFons',7.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','gustavo',10.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','James',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','jesuset',4.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','keepCalm',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','laPoma',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','netDenMiquel',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','pacient',5.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','sargantana',1.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','tranki',2.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','tuManes',6.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','tuPaguesJoCobro',6.0);
INSERT INTO PersonatgesEines (eina, personatge, habilitat) VALUES ('torx','xinuxanu',1.0);

prompt inserts a personatgesGrupVehicles
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','apanemhitots',3.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','aviMiquel',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','beWater',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','bubu',3.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','copDeVolant',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','elCec',7.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','elCorbes',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','elQuiet',3.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','elSonat',7.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','fillaDenMiquel',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','fillDenMiquel',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','finezza',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','floquet1',3.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','floquet2',4.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','gasAFons',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','gustavo',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','James',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','jesuset',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','keepCalm',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','laPoma',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','netDenMiquel',6.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','pacient',6.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','sargantana',4.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','tranki',3.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','tuManes',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','tuPaguesJoCobro',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('4x4','xinuxanu',3.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','apanemhitots',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','aviMiquel',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','beWater',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','bubu',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','copDeVolant',6.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','elCec',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','elCorbes',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','elQuiet',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','elSonat',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','fillaDenMiquel',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','fillDenMiquel',6.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','finezza',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','floquet1',3.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','floquet2',1.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','gasAFons',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','gustavo',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','James',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','jesuset',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','keepCalm',10.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','laPoma',4.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','netDenMiquel',6.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','pacient',6.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','sargantana',4.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','tranki',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','tuManes',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','tuPaguesJoCobro',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('bici','xinuxanu',4.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','apanemhitots',1.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','aviMiquel',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','beWater',7.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','bubu',3.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','copDeVolant',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','elCec',6.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','elCorbes',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','elQuiet',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','elSonat',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','fillaDenMiquel',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','fillDenMiquel',7.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','finezza',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','floquet1',3.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','floquet2',4.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','gasAFons',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','gustavo',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','James',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','jesuset',3.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','keepCalm',10.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','laPoma',3.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','netDenMiquel',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','pacient',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','sargantana',4.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','tranki',4.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','tuManes',7.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','tuPaguesJoCobro',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('moto','xinuxanu',3.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','apanemhitots',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','aviMiquel',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','beWater',10.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','bubu',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','copDeVolant',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','elCec',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','elCorbes',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','elQuiet',7.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','elSonat',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','fillaDenMiquel',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','fillDenMiquel',6.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','finezza',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','floquet1',4.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','floquet2',1.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','gasAFons',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','gustavo',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','James',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','jesuset',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','keepCalm',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','laPoma',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','netDenMiquel',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','pacient',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','sargantana',4.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','tranki',4.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','tuManes',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','tuPaguesJoCobro',7.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('segway','xinuxanu',3.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','apanemhitots',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','aviMiquel',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','beWater',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','bubu',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','copDeVolant',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','elCec',3.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','elCorbes',4.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','elQuiet',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','elSonat',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','fillaDenMiquel',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','fillDenMiquel',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','finezza',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','floquet1',4.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','floquet2',1.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','gasAFons',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','gustavo',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','James',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','jesuset',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','keepCalm',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','laPoma',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','netDenMiquel',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','pacient',10.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','sargantana',4.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','tranki',6.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','tuManes',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','tuPaguesJoCobro',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('tractor','xinuxanu',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','apanemhitots',3.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','aviMiquel',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','beWater',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','bubu',3.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','copDeVolant',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','elCec',6.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','elCorbes',6.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','elQuiet',3.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','elSonat',4.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','fillaDenMiquel',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','fillDenMiquel',6.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','finezza',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','floquet1',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','floquet2',4.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','gasAFons',10.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','gustavo',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','James',7.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','jesuset',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','keepCalm',9.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','laPoma',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','netDenMiquel',2.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','pacient',7.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','sargantana',6.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','tranki',5.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','tuManes',7.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','tuPaguesJoCobro',8.0);
INSERT INTO PersonatgesGrupVehicles (grupVehicles, personatge, habilitat) VALUES ('turisme','xinuxanu',5.0);

COMMIT;

PROMPT Proces finalitzat.
set pagesize 200;
prompt Files per taules:
select 'Combustibles' AS Taula,count(*) as FilesInserides, 5 as Previstes, count(*) -5 as Dif from combustibles
UNION
select 'Eines',count(*) as FilesInserides, 9 as Previstes, count(*) -9 as dif from eines
UNION
select 'Curses',count(*) as FilesInserides, 8 as Previstes, count(*) - 8 as dif from curses
UNION
select 'EinesGrupVehicles', count(*) as FilesInserides, 54 as Previstes, count(*) - 54 as dif from einesGrupVehicles
UNION
select 'EinesVehicles', count(*) as FilesInserides, 45 as Previstes, count(*) - 45 as dif from einesVehicles
UNION
select 'GrupsVehicles', count(*) as FilesInserides, 6 as Previstes, count(*) - 6 as dif from grupsVehicles
UNION
select 'ParticipantsCurses', count(*) as FilesInserides, 68 as Previstes, count(*) - 68 as dif from participantsCurses
UNION
select 'Personatges', count(*) as FilesInserides, 27 as Previstes, count(*) - 27 as dif from personatges
UNION
select 'PersonatgesEines', count(*) as FilesInserides, 243 as Previstes, count(*) - 243 as dif from personatgesEines
UNION
select 'PersonatgesGrupVehicles', count(*) as FilesInserides, 162 as Previstes, count(*) - 162 as dif from personatgesGrupVehicles
UNION
select 'TipusPersonatges', count(*) as FilesInserides, 4 as Previstes, count(*) - 4 as dif from tipusPersonatges
UNION
select 'Usuaris', count(*) as FilesInserides, 19 as Previstes, count(*) - 19 as dif from usuaris
UNION
select 'Vehicles', count(*) as FilesInserides, 31 as Previstes, count(*) - 31 as dif from vehicles;

SET termout on
SET feedback on 
SET echo on

