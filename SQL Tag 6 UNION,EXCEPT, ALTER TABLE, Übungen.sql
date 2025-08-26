-- SQL Tag 6 25.08.25

/*
�bungsaufgaben

1. Anzahl der B�nder, die nach dem 01.01.1970 mit galliern aus Armorica erschienen
2. Anzahl aller B�nde in denen Asterix die wichtigste Rolle(bchar) spielt
3. Alle gallier aus Lutetia
4. R�mer und Gallier die am gleichen Ort leben
*/

--1. Anzahl der B�nder, die nach dem 01.01.1970 mit galliern aus Armorica erschienen
SELECT COUNT(*) FROM band JOIN gallier
ON gbnr=bnr
WHERE bjahr >= '01.01.1970'
AND gort= 'Armorica';

--2. Anzahl aller B�nde in denen Asterix die wichtigste Rolle(bchar) spielt
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

--4. R�mer und Gallier die am gleichen Ort leben
SELECT gname, rname, gort FROM gallier JOIN r�mer
ON gort=rort;

----------------------------------------------------------------------------------------------------

-- Addition von Mengen mit UNION
-- zwischen den beiden Mengen muss eine kompatibilit�t existieren
-- das bedeutet gleiche Anzahl an Spalten und gleichen Datentypen addiert werden

-- UNION eliminiert automatisch doppelte Datens�tze

-- Alle Orte in denen Gallier oder auch R�mer leben
SELECT gort FROM gallier
UNION
SELECT rort FROM r�mer;

-- alle Datens�tze anzeigen
SELECT gort FROM gallier
UNION ALL
SELECT rort FROM r�mer;


-- minus mit EXCEPT

-- gesucht sind alle Wohnortew von galliern, in denen keine r�mer leben
SELECT gort FROM gallier
EXCEPT
SELECT rort FROM r�mer;


SELECT rort FROM r�mer
EXCEPT
SELECT gort FROM gallier;

-- Schnittmenge mit INTERSECT

-- gesucht sind alle Wohnorte von galliern, in denen auch r�mer leben
SELECT gort FROM gallier
INTERSECT
SELECT rort FROM r�mer;


--------------------------------------------------------------------------------------------------------

-- Mit Kleopatra soll eine neue R�merin der Tabelle hinzugef�gt werden.
INSERT INTO r�mer VALUES('R11','Kleopatra','Pharaonin','Alexandria','B01');


-- Tabellen in datenbanken Bearbeiten

-- ALTER TABLE
-- ALTER TABLE wird verwendet um bestehende Tabellen nachtr�glich zu �ndern, ohne sie komplett
-- neu erstellen zu m�ssen

-- neue Spalte hinzuf�gen z.B. alle gallier sollen die Spalte alter_jahre erhalten

ALTER TABLE gallisch.gallier
ADD alter_jahre INT;

SELECT * FROM gallier;

-- Die Spalte alter_jahre bef�llen

-- allen Galliern das alter 20 Zuweisen
UPDATE gallier 
SET alter_jahre = 20;

-- Majestix ist aber nicht 20 sondern 45 Jahre alt
UPDATE gallier
SET alter_jahre = 45
WHERE gname= 'Majestix';


-- Spalte alter_jahre l�schen
ALTER TABLE gallisch.gallier
DROP COLUMN alter_jahre;

SELECT * FROM gallier;

-- Datentyp oder Dateneigenschaften �ndern

-- Die gallier haben demn�chst l�ngere Namen
ALTER TABLE gallisch.gallier
ALTER COLUMN gname nvarchar(100) NOT NULL;


-- Bedingungen hinzuf�gen

-- das alter darf nicht kleiner als 1 sein

-- dazu haben wir die Spalte alter_jahre nocheinmal angelegt und bef�llt

ALTER TABLE gallisch.gallier
ADD CONSTRAINT alt_chk CHECK(alter_jahre >= 1);

-- test
INSERT INTO gallier VALUES('G11','Verleihnix','Fischh�ndler',10,'Armorica','B01',0);
--Fehlermeldung:
--Die INSERT-Anweisung steht in Konflikt mit der CHECK-Einschr�nkung "alt_chk".


-- l�schen der Bedingung
ALTER TABLE gallisch.gallier
DROP CONSTRAINT alt_chk;

-- test 
INSERT INTO gallier VALUES('G11','Verleihnix','Fischh�ndler',10,'Armorica','B01',0);

SELECT * FROM gallier;

-- Verleihnix l�schen
DELETE FROM gallier
WHERE gname='Verleihnix';

-- Spalte alter_jahre l�schen
ALTER TABLE gallisch.gallier
DROP COLUMN alter_jahre;

SELECT * FROM gallier;

-------------------------------------------------------------------------------------

-- Wiederholungs�bungen

/*
1. Alle R�mer aus Rom 
2. alle Gallier deren Namen auf ix enden
3. Bandnamen und erscheinungsjahr aller B�nde mit 47 oder 49 Seiten
4. Gallier und R�mer mit �bereinstimmenden Wohnorten
5. Durchschnittliche Seitenzahl aller b�nde
6. Wohnort und Name des Galliers, der in Band B14 eine wichtige Rolle spielt
7. Namen aller Gallier die mehr als 10 Wildschweine verdr�cken
8. Name und Beruf aller R�mer die in Band 1 ihren ersten Auftritt hatten
9. Gallier die in mindestens 2 B�nden eine wichtige rolle spielen
10. Alle R�mer aufsteigend nach ihrem Beruf alphabetisch sortiert 
*/

--1. Alle R�mer aus Rom
SELECT * FROM r�mer
WHERE rort='Rom';

--2. alle Gallier deren Namen auf ix enden
SELECT gname FROM gallier
WHERE gname LIKE '%ix';

--3. Bandnamen und erscheinungsjahr aller B�nde mit 47 oder 49 Seiten
SELECT bname, bjahr FROM band
WHERE banzahl= 47 OR banzahl=49;

-- oder
SELECT bname, bjahr FROM band
WHERE banzahl IN(47,49);

--4. Gallier und R�mer mit �bereinstimmenden Wohnorten
SELECT gname, rname, gort FROM gallier JOIN r�mer
ON gort=rort;

--5. Durchschnittliche Seitenzahl aller b�nde
SELECT AVG(banzahl) AS 'durchschnittsseiten' FROM band;

--6. Wohnort und Name des Galliers, der in Band B14 eine wichtige Rolle spielt
SELECT gname, gort FROM gallier JOIN Band
ON gnr=bchar
WHERE bnr='B14';

--oder
SELECT gname, gort FROM gallier
WHERE gnr IN (SELECT bchar FROM band
				WHERE bnr= 'B14');

--7. Namen aller Gallier die mehr als 10 Wildschweine verdr�cken
SELECT gname FROM gallier
WHERE wschweine > 10;

--8. Name und Beruf aller R�mer die in Band 1 ihren ersten Auftritt hatten
SELECT rname, rrang FROM r�mer
WHERE rbnr='B01';

--9. Gallier die in mindestens 2 B�nden eine wichtige rolle spielen
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

--10. Alle R�mer aufsteigend nach ihrem Beruf alphabetisch sortiert
SELECT * FROM r�mer
ORDER BY rrang ASC;


-- weitere �bungsaufgaben

--11.zeige alle gallischen Krieger und den Namen des Bandes, in dem sie zuerst auftraten
SELECT gname, bname FROM gallier JOIN band 
ON gbnr=bnr 
WHERE gberuf='Krieger';

--12.zeige alle R�mer die im band 'Der Kampf der H�uptlinge' zum ersten mal auftraten
SELECT * FROM r�mer
WHERE rbnr IN (SELECT bnr FROM band 
				WHERE bname = 'Der Kampf der H�uptlinge')

-- oder

SELECT rname, rbnr FROM r�mer JOIN band
ON rbnr=bnr
WHERE bname= 'Der Kampf der H�uptlinge';

--13.Zeige die Namen aller B�nder die nicht mit dem Buchstaben A beginnen
SELECT bname FROM band 
WHERE bname NOT LIKE 'A%';

-- oder
SELECT bname FROM band 
WHERE bname LIKE '[B-Z]%';

--14.Zeige alle R�mer die in einem Band des Jahres 1971 das erste mal auftraten
SELECT rname FROM r�mer JOIN band 
ON rbnr=bnr
WHERE bjahr BETWEEN '01.01.1971' AND '31.12.1971';

-- oder
SELECT * FROM r�mer
WHERE rbnr IN (SELECT bnr FROM band
				WHERE DATEPART(yy,bjahr) = 1971);

--15.zeige alle R�mer und Gallier die im Band B01 das erste mal auftraten
SELECT gname AS 'Chars Band 1' FROM gallier 
WHERE gbnr= 'B01'
UNION
SELECT rname FROM r�mer
WHERE rbnr= 'B01';

-- oder
SELECT gname,rname FROM gallier JOIN r�mer
ON gbnr=rbnr
WHERE gbnr='B01';

--16.Zeige alle Gallier deren Wildschweinkonsum gr��er ist als der von G04, aber kleiner als der von G03
SELECT gname FROM gallier
WHERE wschweine > (SELECT wschweine FROM gallier WHERE gnr = 'G04')
AND wschweine < (SELECT wschweine FROM gallier WHERE gnr = 'G03');

--17.Zeige alle Daten der B�nder, in denen C�sar am wichtigsten ist
SELECT * FROM band
WHERE bchar IN (SELECT rnr FROM r�mer
				WHERE rname = 'Gaius Julius C�sar');

-- oder

SELECT * FROM band
WHERE bchar IN (SELECT rnr FROM r�mer
				WHERE rname LIKE '%C�sar');


--oder

SELECT * FROM band JOIN r�mer
ON rnr=bchar
WHERE rname= 'Gaius Julius C�sar';


--18.gesucht sind die Wohnorte aller r�mischen Zenturios
SELECT rort, rname FROM r�mer
WHERE rrang= 'Zenturio';

--19.gesucht sind alle gallier, die im selben Band wie Troubadix zum ersten mal auftraten
SELECT gname FROM gallier
WHERE gbnr = (SELECT gbnr FROM gallier
				WHERE gname='Troubadix')
AND gname !='Troubadix'
ORDER BY gname ASC;


-- letzte �bungsaufgaben f�r Heute

--20.bewerte den Wildschweinkonsum der Gallier.
--   unter 10 Wildschweinen sind sie Hungerhacken, zwischen 11 und 30 gut gen�hrt 
--   und �ber 31 sind sie zu hungrig
SELECT gname, wschweine, CASE
						WHEN wschweine < 10 THEN 'hungerhaken'
						WHEN wschweine BETWEEN 11 AND 30 THEN 'gut gen�hrt'
						ELSE 'zu hungrig'
						END AS 'Bewertung'
FROM gallier;

--21.zeige den Namen aller B�nder die zwischen dem 01.01.1970 und 01.01.1980 erschienen sind,
--   in denen ein R�mer eine wichtige rolle einnimmt
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

--23.Zeige alle Gallier die im Selben Band wie der R�mer Brutus das erste mal auftraten
SELECT gname FROM gallier
WHERE gbnr IN (SELECT rbnr FROM r�mer
				WHERE rname = 'Brutus');

--24.gesucht sind alle gallier die im Band 'Asterix der Gallier' erstmalig auftraten,
--   deren Wildschweinkonsum 20 nicht �berschreitet 
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
--   R�mer die in Londinium leben
SELECT gname, gberuf FROM gallier 
WHERE gort='Londinium'
UNION
SELECT rname, rrang FROM r�mer 
WHERE rort='Londinium';

-- oder
SELECT rname, rrang, gname, gberuf FROM r�mer JOIN gallier
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

--28.Liste alle R�mer auf, die in B�nden vorkommen, zusammen mit dem Bandnamen und dem Jahr.
SELECT rname, bnr, bname, bjahr FROM r�mer JOIN band
ON rnr=bchar;

--29.gesucht sind die Gallier, die mehr als 10 Wildschweine verputzen, und zeige die B�nde,
--   in denen sie vorkommen.
SELECT gname, wschweine, bname FROM gallier JOIN band
ON gnr=bchar
WHERE wschweine > 10;

--30 der Gallier Alkoholix mit der Nummer G11 soll in die Datenbank eingef�gt werden,
--   von ihm ist nur noch der Wohnort Lutetia bekannt.
INSERT INTO gallier VALUES('G11','Alkoholix',NULL,NULL,'Lutetia',NULL);

-- oder
INSERT INTO gallier (gnr,gname,gort) VALUES ('G11','Alkoholix','Lutetia')

SELECT * FROM gallier;

DELETE FROM gallier
WHERE gnr='G11';

