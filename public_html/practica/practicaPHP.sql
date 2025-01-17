SET ECHO OFF
SET termout on
SET feedback off

DROP TABLE revisions;

CREATE TABLE revisions (
  codiVehicle varchar2(10) not null,
  data date default null,
  curses number(4,0) default null,
  personatge varchar2(15) default null,
  PRIMARY KEY(codiVehicle,data),
  constraint cf_revisions_codiVehicle
    FOREIGN KEY(codiVehicle) 
    REFERENCES vehicles(codi) 
  constraint cf_revisions_personatge
    FOREIGN KEY(personatge) 
    REFERENCES personatges(alias) 
);
