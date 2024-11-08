-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 1.1.5
-- PostgreSQL version: 16.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE new_database;
-- ddl-end --


-- object: dbo_fantacalcio | type: SCHEMA --
-- DROP SCHEMA IF EXISTS dbo_fantacalcio CASCADE;
CREATE SCHEMA dbo_fantacalcio;
-- ddl-end --
ALTER SCHEMA dbo_fantacalcio OWNER TO postgres;
-- ddl-end --

SET search_path TO pg_catalog,public,dbo_fantacalcio;
-- ddl-end --

-- object: dbo_fantacalcio."Squadra" | type: TABLE --
-- DROP TABLE IF EXISTS dbo_fantacalcio."Squadra" CASCADE;
CREATE TABLE dbo_fantacalcio."Squadra" (
	"Id" bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	nome varchar(50),
	citta varchar(50),
	CONSTRAINT "Squadra_pk" PRIMARY KEY ("Id")
);
-- ddl-end --
ALTER TABLE dbo_fantacalcio."Squadra" OWNER TO postgres;
-- ddl-end --

-- object: dbo_fantacalcio."Giocatore" | type: TABLE --
-- DROP TABLE IF EXISTS dbo_fantacalcio."Giocatore" CASCADE;
CREATE TABLE dbo_fantacalcio."Giocatore" (
	"Id" bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	nome varchar(50),
	cognome varchar(50),
	CONSTRAINT "Giocatore_pk" PRIMARY KEY ("Id")
);
-- ddl-end --
ALTER TABLE dbo_fantacalcio."Giocatore" OWNER TO postgres;
-- ddl-end --

-- object: dbo_fantacalcio."Partita" | type: TABLE --
-- DROP TABLE IF EXISTS dbo_fantacalcio."Partita" CASCADE;
CREATE TABLE dbo_fantacalcio."Partita" (
	"Id" bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	data date,
	CONSTRAINT "Partita_pk" PRIMARY KEY ("Id")
);
-- ddl-end --
ALTER TABLE dbo_fantacalcio."Partita" OWNER TO postgres;
-- ddl-end --

-- object: dbo_fantacalcio.carriera | type: TABLE --
-- DROP TABLE IF EXISTS dbo_fantacalcio.carriera CASCADE;
CREATE TABLE dbo_fantacalcio.carriera (
	"Id_Squadra" bigint NOT NULL,
	"Id_Giocatore" bigint NOT NULL,
	id serial NOT NULL,
	data date,
	CONSTRAINT carriera_pk PRIMARY KEY (id)
);
-- ddl-end --

-- object: "Squadra_fk" | type: CONSTRAINT --
-- ALTER TABLE dbo_fantacalcio.carriera DROP CONSTRAINT IF EXISTS "Squadra_fk" CASCADE;
ALTER TABLE dbo_fantacalcio.carriera ADD CONSTRAINT "Squadra_fk" FOREIGN KEY ("Id_Squadra")
REFERENCES dbo_fantacalcio."Squadra" ("Id") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Giocatore_fk" | type: CONSTRAINT --
-- ALTER TABLE dbo_fantacalcio.carriera DROP CONSTRAINT IF EXISTS "Giocatore_fk" CASCADE;
ALTER TABLE dbo_fantacalcio.carriera ADD CONSTRAINT "Giocatore_fk" FOREIGN KEY ("Id_Giocatore")
REFERENCES dbo_fantacalcio."Giocatore" ("Id") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: dbo_fantacalcio.storico_partite_giocatore | type: TABLE --
-- DROP TABLE IF EXISTS dbo_fantacalcio.storico_partite_giocatore CASCADE;
CREATE TABLE dbo_fantacalcio.storico_partite_giocatore (
	"Id_Partita" bigint NOT NULL,
	"Id_Giocatore" bigint NOT NULL,
	id serial NOT NULL,
	data date,
	CONSTRAINT storico_partite_giocatore_pk PRIMARY KEY (id)
);
-- ddl-end --

-- object: "Partita_fk" | type: CONSTRAINT --
-- ALTER TABLE dbo_fantacalcio.storico_partite_giocatore DROP CONSTRAINT IF EXISTS "Partita_fk" CASCADE;
ALTER TABLE dbo_fantacalcio.storico_partite_giocatore ADD CONSTRAINT "Partita_fk" FOREIGN KEY ("Id_Partita")
REFERENCES dbo_fantacalcio."Partita" ("Id") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Giocatore_fk" | type: CONSTRAINT --
-- ALTER TABLE dbo_fantacalcio.storico_partite_giocatore DROP CONSTRAINT IF EXISTS "Giocatore_fk" CASCADE;
ALTER TABLE dbo_fantacalcio.storico_partite_giocatore ADD CONSTRAINT "Giocatore_fk" FOREIGN KEY ("Id_Giocatore")
REFERENCES dbo_fantacalcio."Giocatore" ("Id") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: dbo_fantacalcio.storico_partite_squadra | type: TABLE --
-- DROP TABLE IF EXISTS dbo_fantacalcio.storico_partite_squadra CASCADE;
CREATE TABLE dbo_fantacalcio.storico_partite_squadra (
	"Id_Partita" bigint NOT NULL,
	"Id_Squadra" bigint NOT NULL,
	id serial NOT NULL,
	data date,
	CONSTRAINT storico_partite_squadra_pk PRIMARY KEY (id)
);
-- ddl-end --

-- object: "Partita_fk" | type: CONSTRAINT --
-- ALTER TABLE dbo_fantacalcio.storico_partite_squadra DROP CONSTRAINT IF EXISTS "Partita_fk" CASCADE;
ALTER TABLE dbo_fantacalcio.storico_partite_squadra ADD CONSTRAINT "Partita_fk" FOREIGN KEY ("Id_Partita")
REFERENCES dbo_fantacalcio."Partita" ("Id") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Squadra_fk" | type: CONSTRAINT --
-- ALTER TABLE dbo_fantacalcio.storico_partite_squadra DROP CONSTRAINT IF EXISTS "Squadra_fk" CASCADE;
ALTER TABLE dbo_fantacalcio.storico_partite_squadra ADD CONSTRAINT "Squadra_fk" FOREIGN KEY ("Id_Squadra")
REFERENCES dbo_fantacalcio."Squadra" ("Id") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --


