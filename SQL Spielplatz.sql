/*
auskommentieren
*/

-- auskommentieren einer Zeile

--
SELECT GETDATE();
SELECT 5 * 12;

-- Alle Daten der Tabelle Lieferant
SELECT * FROM lieferant;
SELECT * FROM artikel;
SELECT aname FROM artikel;

--

SELECT * FROM artikel
WHERE farbe = 'rot';

SELECT * FROM lieferant
WHERE lstadt = 'Hamburg';

SELECT aname FROM artikel
WHERE gewicht = '17';

-- gesucht sind die Nummer,Namen aller 
SELECT anr, aname FROM artikel
WHERE gewicht = 17;

-- gesucht sind die Namen, Status aller Lieferanten die in Aachen wohnen 
SELECT lname, status FROM lieferant
WHERE lstadt = 'Aachen';

-- gesucht sind alle Lieferungen, bei denen der Artikel A02 ausgeliefert wurde
SELECT * FROM lieferung
WHERE anr = 'A02';

SELECT * FROM lieferung
WHERE lmenge >= 200;

SELECT * FROM lieferung
WHERE ldatum = '09.08.1990';

SELECT * FROM lieferung
WHERE ldatum 
BETWEEN '01.08.1990' AND '31.08.1990';


SELECT * FROM artikel
WHERE gewicht
BETWEEN 14 AND 17;

SELECT * FROM lieferant
WHERE lstadt = 'Hamburg' 
OR lstadt = 'Aachen'; 

SELECT * FROM lieferant
WHERE status > 10
AND lstadt = 'Ludwigshafen';

SELECT * FROM artikel
WHERE aname = 'schraube'
AND farbe = 'blau';


SELECT aname FROM artikel
WHERE gewicht = 14 OR astadt = 'Mannheim';

SELECT * FROM lieferung
WHERE lmenge = 100
OR lmenge = 300
OR lmenge = 400;

SELECT * FROM lieferung
WHERE lmenge IN(100,300,400);

SELECT * FROM artikel
WHERE farbe IN('rot','blau');

SELECT * FROM artikel
WHERE farbe NOT IN('rot','grün');

SELECT * FROM lieferant
WHERE lstadt NOT IN('Hamburg','Aachen');

SELECT * FROM lieferant
WHERE lstadt != 'Hamburg'
AND lstadt !='Aachen';

SELECT anr, aname, astadt FROM artikel
WHERE aname IN ('Mutter', 'Zahnrad');

SELECT * FROM artikel
WHERE aname LIKE 'S%';

SELECT * FROM lieferant
WHERE lname LIKE 'B%'
OR lname LIKE 'J%';

SELECT * FROM lieferant
WHERE lname LIKE '[BJ]%';

SELECT * FROM lieferant
WHERE lname LIKE '[BJ]%';

SELECT * FROM lieferant
WHERE lname LIKE '[B-J]%';

SELECT * FROM artikel
WHERE aname LIKE '_o%';

SELECT * FROM artikel
WHERE aname LIKE '%l_';

SELECT * FROM lieferant
WHERE lname NOT LIKE '%a%';


-- 1. gesucht sind die Namen und der Status aller Hamburger Lieferanten
SELECT lname, status FROM lieferant
WHERE lstadt = 'Hamburg';

-- 2. gesucht sind alle roten Artikel die 14 oder 19 gramm wiegen
SELECT * FROM artikel
WHERE gewicht IN(14,19)
AND farbe = 'rot';

-- 3. alle Lieferanten die nicht in Hamburg wohnen
SELECT * FROM lieferant
WHERE lstadt NOT IN ('Hamburg');

-- 4. gesucht sind alle lieferungen bei denen die Artikel A01 oder A04 versendet wurden
SELECT * FROM lieferung
WHERE anr IN ('A01','A04');

-- 5. alle Artikel mit einer Lagermenge vob 900 oder mehr
SELECT * FROM artikel
WHERE amenge >= 900;

-- 6. Alle Lieferanten in deren Namen kein z vorkommt
SELECT * FROM lieferant
WHERE lname NOT LIKE('%z%');

-- 7. Alle Lieferungen die nicht zwischen dem 01.07 und dem 30.07.1990 stattfanden
SELECT * FROM lieferung
WHERE ldatum
NOT BETWEEN '01.07.1990' AND '30.07.1990';

/* Distinct wirkt sich auf den gesamten Datensatz im Ergebnis aus, deswegen wird es direkt in der SELECT abfrage angegeben. Die gleichheit der Datensätze werden überprüft.
*/

SELECT lnr FROM lieferung;
-- ergebnis sind 12 Datensätze

SELECT DISTINCT lnr FROM lieferung;
-- ergebniss 4 Datensätze


-- Berrechnen der Ergebnismengen

-- das Gewicht aller artikel in kg
SELECT amenge * 0.001 as 'Gewicht in KG' 
FROM artikel;

SELECT lnr, ldatum, lmenge, lmenge + 100 
as 'neune Menge'
FROM lieferung 
WHERE lnr = 'L02';

SELECT lnr, lname, status, status - 10 
FROM lieferant
WHERE lname = 'Adam';

SELECT 'Der Lieferant '+lname+' wohnt in '+lstadt
FROM lieferant;

SELECT 'Die '+aname
+' mit der Artikelnummer '+anr
+' ist '+farbe
+' und wird in '+astadt+' gelagert'
FROM artikel;


-- 1. gesucht sind alle Artikel die über 13 gramm wiegen
SELECT * FROM artikel
WHERE gewicht > 13;

-- 2. gesucht sind alle lieferanten die kein b im namen tragen
SELECT * FROM lieferant
WHERE lname NOT LIKE '%b%';

-- 3. gesucht sind alle lieferungen die zwischen dem 06.08. und dem 21.08.1990 getätigt wurden
SELECT * FROM lieferung
WHERE ldatum BETWEEN '06.08.1990' AND '21.08.1990';

-- 4. gesucht sind alle Schrauben die nicht blau oder grün sind
SELECT * FROM artikel
WHERE aname = 'Schraube'
AND farbe NOT IN('blau','grün');

-- 5. gesucht sind alle artikel die mit dem Buchstaben e enden
SELECT * FROM artikel
WHERE aname LIKE '%e';

-- 6. gesucht sind alle artikel die ein c an zweiter stelle tragen
SELECT * FROM artikel
WHERE aname LIKE '_c%';

-- 7. gesucht sind alle artikel die mehr als 15 gramm wiegen oder deren lagermenge größer als 600 ist
SELECT * FROM artikel
WHERE gewicht > 15 
OR amenge > 600;

-- Sortiergen der ergebnissmenge mit ORDER BY

SELECT aname, farbe, astadt FROM artikel
ORDER BY aname DESC;

-- sortiren nach Spaltennamen
SELECT aname as 'Artikelname',
farbe as 'Artikelfarbe',
astadt as 'Lagerort'
FROM artikel
ORDER BY 'Artikelname' ASC;

-- Auflisten der TOP n Werte
-- gesucht sind die drei Lieferungen mit den höchsten liefermengen
SELECT TOP(3) lnr, lmenge, ldatum 
FROM lieferung
ORDER BY lmenge DESC;

-- gesucht sind die drei Lieferanten mit dem niedrigsten Status
SELECT TOP(3) * 
FROM lieferant
ORDER BY status ASC;


-- CASE

SELECT anr, aname, astadt, amenge, 
CASE 
	WHEN amenge BETWEEN 0 AND 400 
		THEN 'nachbestellen'
	WHEN amenge BETWEEN 401 AND 1000
		THEN 'ausreichend'
	ELSE 'Lager voll'
END as 'Bewertung'
FROM artikel;


SELECT lnr, anr, lmenge,
CASE
	WHEN lmenge BETWEEN 0 AND 100
		THEN 'da hätte mehr draufgepasst'
	WHEN lmenge BETWEEN 101 AND 300 
		THEN 'gut ausgelastet'
	ELSE 'Anzeige ist raus!'
END AS 'Liefernotiz'
FROM lieferung;
