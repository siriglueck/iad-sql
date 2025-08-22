-- Datenbank fünfzigvChr erstellen

-- eventuell vorhandene Datenbank fünfzigvChr löschen
IF EXISTS (SELECT * FROM sys.databases 
WHERE database_ID = db_id('fünfzigvChr'))
DROP DATABASE fünfzigvChr;

-- Datenbank erstellen
CREATE DATABASE fünfzigvChr;

USE fünfzigvChr;

-- Schmas erstellen
-- bitte einzeln ausführen
CREATE SCHEMA gallisch AUTHORIZATION dbo;
CREATE SCHEMA roemisch AUTHORIZATION dbo;


-- Tabellen samt Inhalte zu erstellen
-- Tabelle gallier
CREATE TABLE gallisch.gallier (
	gnr nchar(3) NOT NULL 
		CONSTRAINT gnr_ps PRIMARY KEY,
		CONSTRAINT gnr_chk 
			CHECK(gnr LIKE 'g%' AND 
			CAST(SUBSTRING(gnr,2,2) AS INT)BETWEEN 1 AND 99),
	gname nvarchar(50) NOT NULL
		CONSTRAINT gname_chk CHECK(gname LIKE '[A-Z]%'),
	gberuf nvarchar(50) NOT NULL
		CONSTRAINT gberuf_chk CHECK(gberuf LIKE '[A-Z]%'),
	wschweine int NULL
		CONSTRAINT wind_chk CHECK(wschweine BETWEEN 1 AND 200),
	gort nvarchar(50) NOT NULL
		CONSTRAINT gort_chk CHECK(gort LIKE '[A-Z]%'),
	gbnr nchar(3) NULL 
		CONSTRAINT gbnr_chk 
			CHECK(gbnr LIKE 'b%' AND 
			CAST(SUBSTRING(gbnr,2,2) AS INT)BETWEEN 1 AND 99) 
)

-- Tabelle gallier befüllen
INSERT INTO gallisch.gallier VALUES('G01','Majestix','Häuptling',10,'Armorica','B01');
INSERT INTO gallisch.gallier VALUES('G02','Asterix','Krieger',10,'Armorica','B01');
INSERT INTO gallisch.gallier VALUES('G03','Obelix','Hinkelsteinlieferant',50,'Armorica','B01');
INSERT INTO gallisch.gallier VALUES('G04','Miraculix','Druide',2,'Armorica','B01');
INSERT INTO gallisch.gallier VALUES('G05','Troubadix','Barde',5,'Armorica','B01');
INSERT INTO gallisch.gallier VALUES('G06','Falbala','Hausfrau',2,'Armorica','B10');
INSERT INTO gallisch.gallier VALUES('G07','Ozeanix','Krieger',12,'Lutetia','B09');
INSERT INTO gallisch.gallier VALUES('G08','Gelantine','Vaerwalterin',4,'Lutetia','B25');
INSERT INTO gallisch.gallier VALUES('G09','Gaulix','Wirt',12,'Londinium','B08');
INSERT INTO gallisch.gallier VALUES('G10','Grautvorix','Krieger',1,'Lutetia','B09');

-- SYNNONYM
CREATE SYNONYM gallier FOR fünfzigvChr.gallisch.gallier;

SELECT * FROM gallier;


--------------------------------------------------------------------------------------------------


-- Tabelle Römer
CREATE TABLE roemisch.römer (
	rnr nchar(3) NOT NULL 
		CONSTRAINT rnr_ps PRIMARY KEY,
		CONSTRAINT Rnr_chk 
			CHECK(rnr LIKE 'r%' AND 
			CAST(SUBSTRING(rnr,2,2) AS INT)BETWEEN 1 AND 99),
	rname nvarchar(50) NOT NULL
		CONSTRAINT rname_chk CHECK(rname LIKE '[A-Z]%'),
	rrang nvarchar(50) NULL
		CONSTRAINT rrang_chk CHECK(rrang LIKE '[A-Z]%'),
	rort nvarchar(50) NULL
		CONSTRAINT rort_chk CHECK(rort LIKE '[A-Z]%'),
	rbnr nchar(3) NULL 
		CONSTRAINT rbnr_chk 
			CHECK(rbnr LIKE 'b%' AND 
			CAST(SUBSTRING(rbnr,2,2) AS INT)BETWEEN 1 AND 99) 
);


-- Tabelle gallier befüllen
INSERT INTO roemisch.römer VALUES('R01','Gaius Julius Cäsar','Imperator','Rom','B01');
INSERT INTO roemisch.römer VALUES('R02','Gaius Bonus','Zenturio','Kleinbonum','B01');
INSERT INTO roemisch.römer VALUES('R03','Marcus Schmalzlockus','Zenturio','Kleinbonum','B01');
INSERT INTO roemisch.römer VALUES('R04','Plumpus','Zenturio','Londinium','B08');
INSERT INTO roemisch.römer VALUES('R05','Titus Bulgus','Legionär','Laudanum','B04');
INSERT INTO roemisch.römer VALUES('R06','Brutus','Senator','Rom','B10');
INSERT INTO roemisch.römer VALUES('R07','Markus Ludus','Legionär','Aquarium','B04');
INSERT INTO roemisch.römer VALUES('R08','Rufus Syndica','Verwalterin','Aquarium','B17');
INSERT INTO roemisch.römer VALUES('R09','Antivirus','Berater','Rom','B36');
INSERT INTO roemisch.römer VALUES('R10','Bigfatha','Schreiber','Barbaorum','B35');

-- SYNNONYM
CREATE SYNONYM römer FOR fünfzigvChr.roemisch.römer;


SELECT * FROM römer;

DROP TABLE roemisch.römer;

--------------------------------------------------------------------------------------------------


-- Tabelle band
CREATE TABLE gallisch.band (
	bnr nchar(3) NOT NULL 
		CONSTRAINT bbnr_ps PRIMARY KEY,
		CONSTRAINT bbnr_chk 
			CHECK(bnr LIKE 'b%' AND 
			CAST(SUBSTRING(bnr,2,2) AS INT)BETWEEN 1 AND 99),
	bname nvarchar(50) NOT NULL
		CONSTRAINT bname_chk CHECK(bname LIKE '[A-Z]%'),
	bchar nchar(3) NULL 
		CONSTRAINT bchar_chk 
			CHECK(bchar LIKE '[GR]%' AND 
			CAST(SUBSTRING(bchar,2,2) AS INT)BETWEEN 1 AND 99),
	banzahl int NULL 
		CONSTRAINT banzahl_chk CHECK(banzahl BETWEEN 1 AND 1000),
	bjahr DATETIME NOT NULL 
);

-- Tabelle gallier befüllen
INSERT INTO gallisch.band VALUES('B01','Asterix der Gallier','G02',48,'29.10.1968');
INSERT INTO gallisch.band VALUES('B04','Der Kampf der Häuptlinge','G01',48,'04.03.1969');
INSERT INTO gallisch.band VALUES('B08','Asterix bei den Briten','G09',47,'03.01.1971');
INSERT INTO gallisch.band VALUES('B09','Asterix und die Normannen','G10',49,'09.09.1971');
INSERT INTO gallisch.band VALUES('B10','Asterix als Legionär','R02',48,'03.11.1971');
INSERT INTO gallisch.band VALUES('B14','Asterix in Spanien','G03',50,'22.02.1973');
INSERT INTO gallisch.band VALUES('B17','Die Trabantenstadt','R01',52,'15.08.1974');
INSERT INTO gallisch.band VALUES('B25','Der große Graben','G08',47,'02.09.1980');
INSERT INTO gallisch.band VALUES('B28','Asterix im Morgenland','G02',54,'21.10.1987');
INSERT INTO gallisch.band VALUES('B35','Asterix bei den Pikten','R10',51,'24.10.2013');
INSERT INTO gallisch.band VALUES('B36','Der Papyrus des Cäsar','R09',46,'01.10.2015');

-- SYNNONYM
CREATE SYNONYM band FOR fünfzigvChr.gallisch.band;


SELECT * FROM band;