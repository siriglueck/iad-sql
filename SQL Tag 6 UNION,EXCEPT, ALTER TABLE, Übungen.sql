-- SQL Tag 6 25.08.25

/*
Übungsaufgaben

1. Anzahl der Bänder, die nach dem 01.01.1970 mit galliern aus Armorica erschienen
2. Anzahl aller Bände in denen Asterix die wichtigste Rolle(bchar) spielt
3. Alle gallier aus Lutetia
4. Römer und Gallier die am gleichen Ort leben
*/

--1. Anzahl der Bänder, die nach dem 01.01.1970 mit galliern aus Armorica erschienen
SELECT COUNT(*) FROM band JOIN gallier
ON gbnr=bnr
WHERE bjahr >= '01.01.1970'
AND gort= 'Armorica';

--2. Anzahl aller Bände in denen Asterix die wichtigste Rolle(bchar) spielt
SELECT COUNT(*) FROM band
WHERE bchar= (SELECT gnr FROM gallier
				WHERE gname= 'Asterix');

-- oder
SELECT COUNT(*) FROM band JOIN gallier
ON bchar=gnr
WHERE gname='Asterix';

--3. Alle gallier aus Lutetia
SELECT * FROM gallier
WHERE gort= 'Lutetia';

--4. Römer und Gallier die am gleichen Ort leben
SELECT gname, rname, gort FROM gallier JOIN römer
ON gort=rort;

----------------------------------------------------------------------------------------------------

-- Addition von Mengen mit UNION
-- zwischen den beiden Mengen muss eine kompatibilität existieren
-- das bedeutet gleiche Anzahl an Spalten und gleichen Datentypen addiert werden

-- UNION eliminiert automatisch doppelte Datensätze

-- Alle Orte in denen Gallier oder auch Römer leben
SELECT gort FROM gallier
UNION
SELECT rort FROM römer;

-- alle Datensätze anzeigen
SELECT gort FROM gallier
UNION ALL
SELECT rort FROM römer;


-- minus mit EXCEPT

-- gesucht sind alle Wohnortew von galliern, in denen keine römer leben
SELECT gort FROM gallier
EXCEPT
SELECT rort FROM römer;


SELECT rort FROM römer
EXCEPT
SELECT gort FROM gallier;

-- Schnittmenge mit INTERSECT

-- gesucht sind alle Wohnorte von galliern, in denen auch römer leben
SELECT gort FROM gallier
INTERSECT
SELECT rort FROM römer;


--------------------------------------------------------------------------------------------------------

-- Mit Kleopatra soll eine neue Römerin der Tabelle hinzugefügt werden.
INSERT INTO römer VALUES('R11','Kleopatra','Pharaonin','Alexandria','B01');


-- Tabellen in datenbanken Bearbeiten

-- ALTER TABLE
-- ALTER TABLE wird verwendet um bestehende Tabellen nachträglich zu ändern, ohne sie komplett
-- neu erstellen zu müssen

-- neue Spalte hinzufügen z.B. alle gallier sollen die Spalte alter_jahre erhalten

ALTER TABLE gallisch.gallier
ADD alter_jahre INT;

SELECT * FROM gallier;

-- Die Spalte alter_jahre befüllen

-- allen Galliern das alter 20 Zuweisen
UPDATE gallier 
SET alter_jahre = 20;

-- Majestix ist aber nicht 20 sondern 45 Jahre alt
UPDATE gallier
SET alter_jahre = 45
WHERE gname= 'Majestix';


-- Spalte alter_jahre löschen
ALTER TABLE gallisch.gallier
DROP COLUMN alter_jahre;

SELECT * FROM gallier;

-- Datentyp oder Dateneigenschaften ändern

-- Die gallier haben demnächst längere Namen
ALTER TABLE gallisch.gallier
ALTER COLUMN gname nvarchar(100) NOT NULL;


-- Bedingungen hinzufügen

-- das alter darf nicht kleiner als 1 sein

-- dazu haben wir die Spalte alter_jahre nocheinmal angelegt und befüllt

ALTER TABLE gallisch.gallier
ADD CONSTRAINT alt_chk CHECK(alter_jahre >= 1);

-- test
INSERT INTO gallier VALUES('G11','Verleihnix','Fischhändler',10,'Armorica','B01',0);
--Fehlermeldung:
--Die INSERT-Anweisung steht in Konflikt mit der CHECK-Einschränkung "alt_chk".


-- löschen der Bedingung
ALTER TABLE gallisch.gallier
DROP CONSTRAINT alt_chk;

-- test 
INSERT INTO gallier VALUES('G11','Verleihnix','Fischhändler',10,'Armorica','B01',0);

SELECT * FROM gallier;

-- Verleihnix löschen
DELETE FROM gallier
WHERE gname='Verleihnix';

-- Spalte alter_jahre löschen
ALTER TABLE gallisch.gallier
DROP COLUMN alter_jahre;

SELECT * FROM gallier;

-------------------------------------------------------------------------------------

-- Wiederholungsübungen

/*
1. Alle Römer aus Rom 
2. alle Gallier deren Namen auf ix enden
3. Bandnamen und erscheinungsjahr aller Bände mit 47 oder 49 Seiten
4. Gallier und Römer mit übereinstimmenden Wohnorten
5. Durchschnittliche Seitenzahl aller bände
6. Wohnort und Name des Galliers, der in Band B14 eine wichtige Rolle spielt
7. Namen aller Gallier die mehr als 10 Wildschweine verdrücken
8. Name und Beruf aller Römer die in Band 1 ihren ersten Auftritt hatten
9. Gallier die in mindestens 2 Bänden eine wichtige rolle spielen
10. Alle Römer aufsteigend nach ihrem Beruf alphabetisch sortiert 
*/

--1. Alle Römer aus Rom
SELECT * FROM römer
WHERE rort='Rom';

--2. alle Gallier deren Namen auf ix enden
SELECT gname FROM gallier
WHERE gname LIKE '%ix';

--3. Bandnamen und erscheinungsjahr aller Bände mit 47 oder 49 Seiten
SELECT bname, bjahr FROM band
WHERE banzahl= 47 OR banzahl=49;

-- oder
SELECT bname, bjahr FROM band
WHERE banzahl IN(47,49);

--4. Gallier und Römer mit übereinstimmenden Wohnorten
SELECT gname, rname, gort FROM gallier JOIN römer
ON gort=rort;

--5. Durchschnittliche Seitenzahl aller bände
SELECT AVG(banzahl) AS 'durchschnittsseiten' FROM band;

--6. Wohnort und Name des Galliers, der in Band B14 eine wichtige Rolle spielt
SELECT gname, gort FROM gallier JOIN Band
ON gnr=bchar
WHERE bnr='B14';

--oder
SELECT gname, gort FROM gallier
WHERE gnr IN (SELECT bchar FROM band
				WHERE bnr= 'B14');

--7. Namen aller Gallier die mehr als 10 Wildschweine verdrücken
SELECT gname FROM gallier
WHERE wschweine > 10;

--8. Name und Beruf aller Römer die in Band 1 ihren ersten Auftritt hatten
SELECT rname, rrang FROM römer
WHERE rbnr='B01';

--9. Gallier die in mindestens 2 Bänden eine wichtige rolle spielen
SELECT * FROM gallier 
WHERE gnr IN (SELECT bchar FROM band
				GROUP BY bchar
				HAVING COUNT(bchar) >= 2);

--oder
SELECT gname FROM gallier JOIN band
ON gnr=bchar
GROUP BY gname
HAVING COUNT(bchar) >= 2;

-- oder
SELECT gname, COUNT(bchar) FROM gallier JOIN band
ON gnr=bchar
GROUP BY gname
HAVING COUNT(bchar) >= 2

--10. Alle Römer aufsteigend nach ihrem Beruf alphabetisch sortiert
SELECT * FROM römer
ORDER BY rrang ASC;


-- weitere Übungsaufgaben

--11.zeige alle gallischen Krieger und den Namen des Bandes, in dem sie zuerst auftraten
SELECT gname, bname FROM gallier JOIN band 
ON gbnr=bnr 
WHERE gberuf='Krieger';

--12.zeige alle Römer die im band 'Der Kampf der Häuptlinge' zum ersten mal auftraten
SELECT * FROM römer
WHERE rbnr IN (SELECT bnr FROM band 
				WHERE bname = 'Der Kampf der Häuptlinge')

-- oder

SELECT rname, rbnr FROM römer JOIN band
ON rbnr=bnr
WHERE bname= 'Der Kampf der Häuptlinge';

--13.Zeige die Namen aller Bänder die nicht mit dem Buchstaben A beginnen
SELECT bname FROM band 
WHERE bname NOT LIKE 'A%';

-- oder
SELECT bname FROM band 
WHERE bname LIKE '[B-Z]%';

--14.Zeige alle Römer die in einem Band des Jahres 1971 das erste mal auftraten
SELECT rname FROM römer JOIN band 
ON rbnr=bnr
WHERE bjahr BETWEEN '01.01.1971' AND '31.12.1971';

-- oder
SELECT * FROM römer
WHERE rbnr IN (SELECT bnr FROM band
				WHERE DATEPART(yy,bjahr) = 1971);

--15.zeige alle Römer und Gallier die im Band B01 das erste mal auftraten
SELECT gname AS 'Chars Band 1' FROM gallier 
WHERE gbnr= 'B01'
UNION
SELECT rname FROM römer
WHERE rbnr= 'B01';

-- oder
SELECT gname,rname FROM gallier JOIN römer
ON gbnr=rbnr
WHERE gbnr='B01';

--16.Zeige alle Gallier deren Wildschweinkonsum größer ist als der von G04, aber kleiner als der von G03
SELECT gname FROM gallier
WHERE wschweine > (SELECT wschweine FROM gallier WHERE gnr = 'G04')
AND wschweine < (SELECT wschweine FROM gallier WHERE gnr = 'G03');

--17.Zeige alle Daten der Bänder, in denen Cäsar am wichtigsten ist
SELECT * FROM band
WHERE bchar IN (SELECT rnr FROM römer
				WHERE rname = 'Gaius Julius Cäsar');

-- oder

SELECT * FROM band
WHERE bchar IN (SELECT rnr FROM römer
				WHERE rname LIKE '%Cäsar');


--oder

SELECT * FROM band JOIN römer
ON rnr=bchar
WHERE rname= 'Gaius Julius Cäsar';


--18.gesucht sind die Wohnorte aller römischen Zenturios
SELECT rort, rname FROM römer
WHERE rrang= 'Zenturio';

--19.gesucht sind alle gallier, die im selben Band wie Troubadix zum ersten mal auftraten
SELECT gname FROM gallier
WHERE gbnr = (SELECT gbnr FROM gallier
				WHERE gname='Troubadix')
AND gname !='Troubadix'
ORDER BY gname ASC;


-- letzte Übungsaufgaben für Heute

--20.bewerte den Wildschweinkonsum der Gallier.
--   unter 10 Wildschweinen sind sie Hungerhacken, zwischen 11 und 30 gut genährt 
--   und über 31 sind sie zu hungrig
SELECT gname, wschweine, CASE
						WHEN wschweine < 10 THEN 'hungerhaken'
						WHEN wschweine BETWEEN 11 AND 30 THEN 'gut genährt'
						ELSE 'zu hungrig'
						END AS 'Bewertung'
FROM gallier;

--21.zeige den Namen aller Bänder die zwischen dem 01.01.1970 und 01.01.1980 erschienen sind,
--   in denen ein Römer eine wichtige rolle einnimmt
SELECT bname FROM band 
WHERE bjahr BETWEEN '01.01.1970' AND '01.10.1980'
AND bchar LIKE 'R%';

--22.zeige den in Lutetia lebenden Gallier mit dem geringsten Wildschweinverbrauch
SELECT * FROM gallier 
WHERE wschweine = (SELECT MIN(wschweine) FROM gallier)
AND gort='Lutetia';

-- oder
SELECT TOP(1) * FROM gallier
WHERE gort='Lutetia'
ORDER BY wschweine ASC;

--23.Zeige alle Gallier die im Selben Band wie der Römer Brutus das erste mal auftraten
SELECT gname FROM gallier
WHERE gbnr IN (SELECT rbnr FROM römer
				WHERE rname = 'Brutus');

--24.gesucht sind alle gallier die im Band 'Asterix der Gallier' erstmalig auftraten,
--   deren Wildschweinkonsum 20 nicht überschreitet 
SELECT gname, wschweine FROM gallier
WHERE gbnr IN (SELECT bnr FROM band
				WHERE bname= 'Asterix der Gallier')
AND wschweine <= 20;

-- oder
SELECT * FROM gallier JOIN band 
ON gbnr=bnr
WHERE bname= 'Asterix der Gallier'
AND wschweine <= 20;

--25.gesucht sind die namen und der beruf bzw. rang aller gallier und 
--   Römer die in Londinium leben
SELECT gname, gberuf FROM gallier 
WHERE gort='Londinium'
UNION
SELECT rname, rrang FROM römer 
WHERE rort='Londinium';

-- oder
SELECT rname, rrang, gname, gberuf FROM römer JOIN gallier
ON rort=gort
WHERE gort='Londinium';

--26.gesucht sind der Name des Bandes, sowie der Name des wichtigsten Gallier des Bandes,
--   welcher am 02.09.1980 erschienen ist
SELECT bname, gname FROM band JOIN gallier
ON bchar=gnr
WHERE bjahr= '02.09.1980';

--27.Zeige alle Gallier-Namen zusammen mit ihren Bands.
SELECT gname, bnr, bname FROM gallier JOIN band
ON gnr=bchar;

--28.Liste alle Römer auf, die in Bänden vorkommen, zusammen mit dem Bandnamen und dem Jahr.
SELECT rname, bnr, bname, bjahr FROM römer JOIN band
ON rnr=bchar;

--29.gesucht sind die Gallier, die mehr als 10 Wildschweine verputzen, und zeige die Bände,
--   in denen sie vorkommen.
SELECT gname, wschweine, bname FROM gallier JOIN band
ON gnr=bchar
WHERE wschweine > 10;

--30 der Gallier Alkoholix mit der Nummer G11 soll in die Datenbank eingefügt werden,
--   von ihm ist nur noch der Wohnort Lutetia bekannt.
INSERT INTO gallier VALUES('G11','Alkoholix',NULL,NULL,'Lutetia',NULL);

-- oder
INSERT INTO gallier (gnr,gname,gort) VALUES ('G11','Alkoholix','Lutetia')

SELECT * FROM gallier;

DELETE FROM gallier
WHERE gnr='G11';

