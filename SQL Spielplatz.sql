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


-- 19.08.25 SQL Tag 2

-- Übungen zu LIKE, BETWEEN, IN

-- 1. Schreibe zwei verschiedene Abfrage, die alle Lieferungen vom 05.08 bzw. 06.08.1990 ausgeben
SELECT * FROM lieferung
WHERE ldatum IN('05.08.1990','06.08.1990');

SELECT * FROM lieferung
WHERE ldatum BETWEEN '05.08.1990' AND '06.08.1990';


-- 2. Alle Lieferanten, deren Namen mit A oder S beginnen
SELECT * FROM lieferant
WHERE lname LIKE 'A%' OR lname LIKE 'S%';

-- oder
SELECT * FROM lieferant
WHERE lname LIKE '[AS]%';

-- 3. Name und Status aller Lieferanten die in Hamburg oder Aachen leben
SELECT lname, status FROM lieferant
WHERE lstadt IN('Hamburg','Aachen');

-- 4. Alle Lieferungen des Liferanten L01, bei denen 200 oder 300 Stück Ware ausgeliefert wurde
SELECT * FROM lieferung
WHERE lnr = 'L01'
AND lmenge IN(200,300);


---------------------------------------------------

-- Einsatz von Aggregatfunktionen
-- AVG		Durchschnitt von Spaltenwerten
-- MAX		größte Spaltenwert
-- MIN		kleinste Spaltenwert
-- SUM		Summe der Spaltenwert
-- COUNT	Anzahl der Spaltenwerte


-- gesucht ist der kleinste status aller Lieferanten
SELECT MIN(status) FROM lieferant;

-- gesucht ist der nach der alphabetischen Reihenfolge erste Lieferant
SELECT MIN(lname) FROM lieferant;

-- Anzahl aller bisherigen lieferungen, die Lieferanten ausgeführt haben
SELECT COUNT(*) FROM lieferung;

-- größste, kleinste und den durchschnitts status aller lieferanten
SELECT 
MIN(status) as 'Maximum',
MAX(status) as 'Minimum',
AVG(status) as 'Durchschnitt'
FROM lieferant;

SELECT lnr, lname, MIN(status) FROM lieferant
GROUP BY lnr, lname;

-- geht nicht!
SELECT COUNT(MAX(status)) FROM lieferant;

-- größste liefermenge aller lieferungen
SELECT MAX(lmenge) FROM lieferung;

-- die Durchschnittsmenge aller gelagerten artikel
SELECT AVG(amenge) FROM artikel;


-- GROUP BY Klausel
-- legt Spalten fest, über die Gruppen gebildet werden
-- gruppiert Zeilen mit gleichen Werten damit man Aggregatfunktionen in ihnen nutzen kann

-- die kleinste liefermenge, jedes Lieferanten
SELECT lnr, MIN(lmenge) as 'Minimum' FROM lieferung
GROUP BY lnr; 


-- Anzahl der Lieferanten pro Ort
SELECT lstadt, COUNT(lnr) FROM lieferant
GROUP BY lstadt;

-- kleinster status aller lieferanten pro Ort
SELECT lstadt, MIN(status) FROM lieferant
GROUP BY lstadt;

-- anzahl lieferungen pro lieferant
SELECT lnr, COUNT(lnr) FROM lieferung
GROUP BY lnr; 

-- Summe aller gelaferten Artikel pro Farbe
SELECT farbe, SUM(amenge) FROM artikel
GROUP BY farbe;


-- die größte liefermenge des Artikels A02 pro lieferant
SELECT lnr, MAX(lmenge) FROM lieferung
WHERE anr = 'A02'
GROUP BY lnr; 



---------------------------------------------
-- HAVING-Klausel
-- HAVING ist die WHERE Abfrage für Gruppen
-- HAVING selektiert Gruppen die mit GROUP BY festgelegt wurden

-- In der GROUP BY kausel düfen keine Aggregatfunktionen stehen in der Having schon

-- gesucht ist der größste Lieferantenstatus des jeweiligen Ortes von
-- Lieferanten die nicht aus Aachen kommen. Wenn der durchschnittliche Statuswert nicht
-- kleiner als 15 ist.

SELECT lstadt, MAX(status) FROM lieferant
WHERE lstadt != 'Aachen'
AND AVG(status) > 15
GROUP BY lstadt;
-- geht nicht, da in einer WHERE Abfrage 
-- keine Aggregatfunktion vorkommen darf.

SELECT lstadt, MAX(status) FROM lieferant
WHERE lstadt != 'Aachen'
GROUP BY lstadt
HAVING AVG(status) > 15;

-- es gibt keine Einschränkung für die Anzahl
-- der Aggregatfunktionen innerhalb einer
-- HAVING-Klausel

SELECT lnr ,SUM(lmenge) FROM lieferung
GROUP BY lnr
HAVING MIN(lmenge) < 300
AND AVG(lmenge) < 1300;


----------------------------------------

-- Tabellen verbinden über Unterabfragen
-- ist eine Abfrage innerhalb einer Abfrage.
-- Die erste Abfrage wird äußere und
-- die anderen innere Abfrage genannt.

-- Es werden immer zuerst die inneren
-- und anschließend die äußere Abfrage bearbeitet

-- gesucht sind alle Lieferanten, in der selben stadt leben
-- in der der Artikel A02 gelagert wirf

-- die tabellen lieferant und artikel werden benötigt
SELECT * FROM lieferant
WHERE lstadt = (SELECT astadt FROM artikel
				WHERE anr = 'A02');

-- gesucht sind die Lieferanten, deren status 
-- größer als der durchschnittsstatus
-- aller Lieferanten ist


SELECT * FROM lieferant
WHERE status > (SELECT AVG(status) FROM lieferant);

-- gesucht sind die Daten aller lieferanten
-- ,die schon einmal geliefert haben
SELECT * FROM lieferant
WHERE lnr IN (SELECT lnr FROM lieferung);

-- Artikelnummer und 
-- namen sowie der Lagerort aller Artikel
-- die am 23.07.1990 ausgeliefert wurden

SELECT anr, aname, astadt FROM artikel
WHERE anr IN(SELECT anr FROM lieferung
			 WHERE ldatum = '23.07.1990');

SELECT anr, aname, astadt FROM artikel
WHERE anr IN(SELECT anr FROM lieferung
			 WHERE ldatum 
			 BETWEEN '23.07.1990'
			 AND '30.07.1990');


-- liefermenge und das lieferdatum 
-- an dem roter Muttern versendet wurden

SELECT lmenge, ldatum FROM lieferung
WHERE anr IN ( SELECT anr FROM artikel 
				WHERE farbe = 'rot'
				AND aname = 'Mutter');


-- Die Daten aller Lieferungen von Hamburger Lieferanten
SELECT * FROM lieferung
WHERE lnr IN (SELECT lnr FROM lieferant
				WHERE lstadt = 'Hamburg');


-- Nummern und Namen der Lieferanten, deren Status kleiner als der von L03 sind.
SELECT lnr, lname FROM lieferant
WHERE status < ( SELECT status FROM lieferant
					WHERE lnr = 'L03');

-- gewicht und der name aller artikel die von Lieferant L02 geliefert wurden
SELECT gewicht, aname from artikel
WHERE anr IN (SELECT anr FROM lieferung
				WHERE lnr = 'L02');

-- Nummern und Namen der Lieferanten, die den Artikel A05 nicht lieferten
SELECT lnr, lname FROM lieferant
WHERE lnr NOT IN (SELECT lnr FROM lieferung
					WHERE anr = 'A05');

-- die Daten aller lieferungen von Lieferanten mit dem status 20
SELECT * FROM lieferung
WHERE lnr IN (SELECT lnr FROM lieferant
				WHERE status = 20);


------------------------------------------------------------------

/*
1. Gesucht ist die Menge aller grünen Artikel, minus die 200 
	die wir bereits verplant aber noch nicht versendet haben.
*/

SELECT amenge, amenge - 200 as 'nach verplant' FROM artikel
WHERE farbe = 'grün';

-- 2. Gesucht sind alle Lieferanten mit dem höchsten Status.
SELECT * FROM lieferant
WHERE status = (SELECT MAX(status) as 'Max' FROM lieferant);

-- oder

SELECT * FROM lieferant
WHERE status IN (SELECT MAX(status) FROM lieferant);

-- 3. Gesucht ist das durchschnittliche Gewicht aller Artikel.
SELECT AVG(gewicht) FROM artikel;

/*
4. Gesucht ist die größte Lieferung jedes Lieferanten,
	die nach dem 23.7.90 stattgefunden hat und deren durchschnittliche
	Liefermenge mindestens 250 beträgt.
*/

SELECT lnr, MAX(lmenge), ldatum FROM lieferung
WHERE ldatum > '23.07.1990'
GROUP BY lnr, ldatum
HAVING AVG(lmenge) >= 250;

/*
5. Gesucht ist der kleinste Status des jeweiligen Wohnortes von 
	Lieferanten die nicht aus Erfurt kommen, wenn der durchschnittliche
	Statuswert am jeweiligen Ort nicht kleiner ist als 12
*/

SELECT lstadt, MIN(status) FROM lieferant
WHERE lstadt != 'Erfurt'
GROUP BY lstadt
HAVING AVG(status) >= 12;



/*
6. Gesucht ist der Name, Nummer von allen Artikeln.
	Zudem soll die Menge der Artikel bewertet werden. Bis 600 Artikel
	soll nachbestellt werden, bis 1000 soll es unbedingt verkauft 
	werden, bis 1200 sollen sie verschenkt werden. Alle Artikel mit
	einem Bestand über 1200 sollen weggeworfen werden. */
SELECT anr, aname, amenge, 
							CASE 
								WHEN amenge BETWEEN 0 AND 600		THEN 'nachbestellen'
								WHEN amenge BETWEEN 601 AND 1000	THEN 'verkaufen'
								WHEN amenge BETWEEN 1001 AND 1200	THEN 'verschenken'
								WHEN amenge > 1200					THEN 'wegwerfen'
								ELSE 'fehler'
							END as 'Bewertung'
FROM artikel;

-- 7. Schreibe eine Abfrage die das aktuelle Datum ausgibt.
SELECT GETDATE();

/*
8. Gesucht sind die Namen aller Lieferanten aus Aachen mit einem
	Statuswert zwischen 20 und 30 */
SELECT lname FROM lieferant
WHERE lstadt = 'Aachen'
AND status BETWEEN 20 AND 30;

/*
9. Gesucht sind die Namen und Nummern aller Artikel, deren Gewicht
	12, 14 oder 17 gramm beträgt. */
SELECT aname, anr FROM artikel
WHERE gewicht IN (12,14,17);


/*
10. Gesucht ist der Statuswert aller Lieferanten, die am 5.8.90 oder 
	6.8.90 ausgeliefert haben. */
SELECT lnr, status FROM lieferant
WHERE lnr IN (SELECT lnr FROM lieferung
			   WHERE ldatum = '05.08.1990'
			   OR ldatum = '06.08.1990');

--- oder

SELECT lnr, status FROM lieferant
WHERE lnr IN (SELECT lnr FROM lieferung
			   WHERE ldatum IN ('05.08.1990', '06.08.1990'));

--- oder
SELECT lnr, status FROM lieferant
WHERE lnr IN (SELECT lnr FROM lieferung
			   WHERE ldatum BETWEEN '05.08.1990' AND '06.08.1990');

-- Zusatz: Namen und nummern aller artikel, die am selben ort wie A03 gelagert werden
SELECT aname,anr FROM artikel
WHERE astadt IN (SELECT astadt FROM artikel
				WHERE anr = 'A03');



-----------------------------------------

-- gesucht sind die Nummern und Namen der Lieferanten die geliefert haben
-- ohne JOIN
SELECT lnr, lname FROM lieferant
WHERE lnr IN (SELECT lnr FROM lieferung);

-- mit JOIN
SELECT DISTINCT a.lnr, lname FROM lieferant a JOIN lieferung b
ON a.lnr = b.lnr

-- gesucht sind aller artikel die an einem Ort gelagert werden, 
-- an dem auch Lieferant leben
-- ohne JOIN
SELECT * FROM artikel
WHERE astadt IN (SELECT lstadt FROM lieferant);

-- mit JOIN
SELECT * FROM artikel JOIN lieferant
ON astadt = lstadt;

-- gesucht sind die Lieferanten, die an einem Ort wohnen, 
-- an dem auch andere Lieferanten leben
SELECT a.* FROM lieferant a JOIN lieferant b
ON a.lstadt = b.lstadt
AND a.lnr != b.lnr;

-- OUTER JOIN
---- ### LEFT JOIN ###
----- LEFT JOIN beeinhaltet sämtlicher Reihen aus der zuerst (linke) genannten Tabelle
----- ,sowie die Reihen der zweiten Tabelle die die Verknüpfung erfüllen
-------- gesucht alle lieferanten sowie ihre lieferungen, es sollen auch
-------- die Lieferanten angezeigt werden, die noch nicht gelifert haben
			-- * This way of selection only works with JOIN * --
			SELECT a.*, anr, lmenge, ldatum FROM lieferant a LEFT JOIN lieferung b
			ON a.lnr = b.lnr;
---- ### RIGHT JOIN ###
----- RIGHT JOIN beeinhaltet sämtlicher Reihen aus der zuerst (rechte) genannten Tabelle
----- ,sowie die Reihen der zweiten Tabelle die die Verknüpfung erfüllen
-------- gesucht sind dir lieferung und ihre zugehörigen lieferanten
-------- , es sollen aber auch die lieferungen angezeigt werden
-------- zu der kein lieferant existiert
			SELECT a.*, lname FROM lieferung a RIGHT JOIN lieferant b
			ON a.lnr = b.lnr;

---- ### FULL JOIN ###
----- beeinhaltet sämliche Reihen der linken und rechten Tabelle
----- ,die die Bedingungen erfüllen, aber auch die Reihen der linken und rechten Tabelle
----- die sie nicht erfüllen
		SELECT * FROM lieferant a FULL JOIN lieferung b
		ON a.lnr=b.lnr;

-- # Wiederholung # --
/*
1. Nummern aller Lieferanten, die mindestens einen Artikel geliefert
	haben den auch Lieferant L03 geliefert hat. */
	SELECT lnr FROM lieferung
	WHERE anr IN (SELECT anr FROM lieferung
				  WHERE lnr = 'L03');

	-- oder
	SELECT lnr FROM lieferung a
	WHERE EXISTS (SELECT anr FROM lieferung b
				  WHERE a.anr=b.anr AND lnr='L03');

	-- oder
	SELECT a.lnr FROM lieferung a JOIN lieferung b
	ON a.anr = b.anr
	WHERE b.lnr = 'L03';


/* 2. 
Nummern aller Lieferanten, die mehr als eine Artikel geliefert haben */
	SELECT lnr,COUNT(lnr) as 'result' FROM lieferung
	GROUP BY lnr
	HAVING COUNT(lnr) > 1;

	SELECT lnr as 'anzahl' FROM lieferung
	GROUP BY lnr
	HAVING COUNT(DISTINCT anr) > 1;

	-- oder
	SELECT lnr as 'anzahl' FROM lieferung
	GROUP BY lnr
	HAVING 2 <= COUNT(anr);

	-- oder
	SELECT a.lnr, a.anr FROM lieferung a JOIN lieferung b
	ON a.lnr = b.lnr
	AND a.anr != b.anr;

	-- oder
	SELECT DISTINCT a.lnr FROM lieferung a 
	WHERE 1 < (SELECT COUNT(anr) FROM lieferung b
			   WHERE a.lnr=b.lnr);


/*
3. Nummern und Namen der Artikel, die am selben Ort wie Artikel A03 
	gelagert werden. */
SELECT anr, aname FROM artikel 
WHERE astadt IN (SELECT astadt FROM artikel 
				 WHERE anr = 'A03');


SELECT a.anr, a.aname FROM artikel a JOIN artikel b
ON a.astadt = b.astadt
WHERE b.anr = 'A03';

-- oder

SELECT a.anr, a.aname FROM artikel a JOIN artikel b
ON a.astadt = b.astadt
AND b.anr = 'A03';



/*
4. Durchschnittliche Liefermenge von Artikel A01 */
SELECT AVG(lmenge) FROM lieferung
GROUP BY anr
HAVING anr = 'A01';

-- oder

SELECT AVG(lmenge) FROM lieferung
WHERE anr = 'A01';


/*
5. Gesamtliefermenge aller Lieferungen des Artikels A01 durch den
	Lieferanten L02 */
SELECT lnr ,SUM(lmenge) FROM lieferung
WHERE anr = 'A01'
GROUP BY lnr
HAVING lnr = 'L02';

-- oder

SELECT lnr ,SUM(lmenge) FROM lieferung
WHERE anr = 'A01'
AND lnr = 'L02';

/*
6. Lagerorte der Artikel, die von Lieferant L02 geliefert wurden */
SELECT astadt FROM artikel
WHERE anr IN (SELECT anr FROM lieferung
				WHERE lnr = 'L02');


SELECT a.astadt FROM artikel a JOIN lieferung b
ON a.anr = b.anr
WHERE lnr = 'L02';

/*
7. Nummern und Namen der Lieferanten, deren Status kleiner als der 
	von Lieferant L03 ist */
SELECT lnr, lname, status FROM lieferant
WHERE status < (SELECT status FROM lieferant
				WHERE lnr = 'L03');

-- oder
SELECT a.lnr, a.lname FROM lieferant a JOIN lieferant b
ON a.status < b.status
WHERE b.lnr = 'L03';


/*
8. Nummern und Namen aller Lieferanten, die den Artikel A05 nicht 
	geliefert haben. */
SELECT lnr, lname FROM lieferant
WHERE lnr NOT IN (SELECT lnr FROM lieferung
				  WHERE anr = 'A05');

-- oder

SELECT a.lnr, a.lname FROM lieferant a
WHERE NOT EXISTS (SELECT lnr FROM lieferung b
					WHERE a.lnr = b.lnr
					AND anr = 'A05');
-- oder
SELECT a.lnr, a.lname FROM lieferant a JOIN lieferung b
ON a.lnr = b.lnr
AND b.lnr NOT IN (SELECT lnr FROM lieferung
				  WHERE anr = 'A05');


-- kleine Übungen vor dem Mittag
-- Screibe zwei verschiedene Abfragen die alle Lieferanten ausgibt,
-- deren Namen mit S, C oder B beginnen und deren dritter Buchstabe ein a ist

SELECT * from lieferant
WHERE lname LIKE'S_a%'
OR lname LIKE 'C_a%'
OR lname LIKE 'B_a%';

SELECT * from lieferant
WHERE lname LIKE'[SCB]_a%';

/*
1. Nummern, Namen und Wohnort der Lieferanten, die bereits geliefert haben
   und deren status größer als der kleinste status aller lieferanten ist
*/

SELECT lnr, lname, lstadt FROM lieferant
WHERE lnr IN (SELECT DISTINCT lnr FROM  lieferung)
AND status > (SELECT MIN(status) FROM lieferant);

-- oder
SELECT a.lnr, lname, lstadt, status FROM lieferant a JOIN lieferung b
ON a.lnr = b.lnr
AND status > ANY (SELECT status FROM lieferant);

-- oder
SELECT a.lnr, lname, lstadt, status FROM lieferant a JOIN lieferung b
ON a.lnr = b.lnr
WHERE a.status > (SELECT MIN(status) FROM lieferant);

-- oder
SELECT a.lnr, lname, lstadt, status FROM lieferant a JOIN lieferung b
ON a.lnr = b.lnr
AND EXISTS (SELECT * FROM lieferant c
			WHERE c.status < a.status);

/*
2. Nummern und namen aller artikel,deren durchschnittliche Liefermenge kleiner als die durchschnittsmenge
   von artikel A03 ist
*/

-- falsch --
SELECT anr, aname FROM artikel 
WHERE (SELECT AVG(lmenge) FROM lieferung) < (SELECT AVG(lmenge) FROM lieferung WHERE anr = 'A03');

-- richtig --
SELECT anr, aname FROM artikel 
WHERE anr IN (SELECT anr FROM lieferung
			  GROUP BY anr
			  HAVING AVG(lmenge) < (SELECT AVG(lmenge) FROM lieferung WHERE anr = 'A03'));

-- oder --
SELECT a.anr, aname FROM artikel a JOIN lieferung b
ON a.anr=b.anr
GROUP BY a.anr, aname
HAVING AVG(lmenge) < (SELECT AVG(lmenge) FROM lieferung WHERE anr = 'A03');

/*
3. Lieferantennamen und nummern, Artikelname und artikelnummern aller lieferungen
   die seit dem 05.05.1990 von Hamburger lieferanten durchgeführt wurden
*/

SELECT b.lname, b.lnr, c.aname, c.anr FROM lieferung a JOIN lieferant b
ON a.lnr = b.lnr JOIN artikel c ON a.anr = c.anr
AND a.ldatum > '05.05.1990'
AND b.lstadt = 'Hamburg';


/*
4. Lieferantennummern und Namen, die alle verschiedenen Artikel geliefert haben
*/

SELECT a.lnr, lname FROM lieferant a JOIN lieferung b
ON a.lnr = b.lnr
GROUP BY a.lnr, lname
HAVING COUNT(DISTINCT b.anr) = (SELECT COUNT(anr) FROM artikel);

-- oder 
SELECT lnr, lname FROM lieferant
WHERE lnr IN (SELECT lnr FROM lieferung
			  GROUP BY lnr
			  HAVING COUNT(DISTINCT anr) = (SELECT COUNT(anr) FROM artikel));

-- noch mehr Übungen

-- 5. Ortsnamen die Wohnort aber kein Lagerort sind
	SELECT lstadt FROM lieferant
	WHERE lstadt NOT IN (SELECT astadt FROM artikel);

	-- nicht gut
	SELECT DISTINCT lstadt FROM lieferant JOIN artikel
	ON lstadt != astadt
	AND lstadt NOT IN (SELECT astadt FROM artikel);
	
	-- oder

	SELECT DISTINCT lstadt FROM lieferant
	WHERE NOT EXISTS (SELECT * FROM artikel
					  WHERE lstadt = astadt);


-- 6. Ortsnamen die sowohl Wohn- als auch Lagerorte sind
	SELECT DISTINCT lstadt FROM lieferant
	WHERE lstadt IN (SELECT astadt FROM artikel);

	-- or 
	SELECT DISTINCT lstadt FROM lieferant JOIN artikel
	ON lstadt = astadt;

	-- or , is cross join
	SELECT DISTINCT lstadt FROM lieferant, artikel
	WHERE lstadt = astadt;

-- 7. Nummern, Namen aller lieferanten, die mindestens zwei verschiederne Artikel lieferten
	SELECT lnr, lname FROM lieferant 
	WHERE lnr IN (SELECT lnr FROM Lieferung 
				 GROUP BY lnr
				 HAVING COUNT(anr) > 1);

	-- oder
	SELECT DISTINCT a.lnr, lname FROM lieferant a JOIN lieferung b
	ON a.lnr = b.lnr
	AND b.lnr IN (SELECT lnr FROM Lieferung 
				 GROUP BY lnr
				 HAVING COUNT(anr) >= 2);

	-- oder
	SELECT DISTINCT a.lnr, lname FROM lieferant a JOIN lieferung b
	ON a.lnr = b.lnr
	GROUP BY a.lnr, lname
	HAVING COUNT(anr) > 1;
					

-- 8.Farbe und der Name aller Artikel, die von dem Lieferanten Clark geliefert wurden

	SELECT farbe, aname FROM artikel a JOIN lieferung b
	ON a.anr = b.anr JOIN lieferant c ON b.lnr = c.lnr
	AND lname = 'Clark';

	-- oder
	SELECT farbe, aname FROM artikel a JOIN lieferung b
	ON a.anr = b.anr JOIN lieferant c ON b.lnr = c.lnr
	WHERE lname = 'Clark';

	-- oder
	SELECT farbe, aname FROM artikel
	WHERE anr IN (SELECT anr FROM lieferung
					WHERE lnr IN (SELECT lnr FROM lieferant
									WHERE lname = 'Clark'));





/*
1. Lieferantennummern und Namen der Lieferanten, 
die 3 verschiedene Artikel geliefert haben */
SELECT lnr, lname FROM lieferant
WHERE lnr IN (SELECT lnr FROM lieferung
				GROUP BY lnr
				HAVING COUNT(DISTINCT anr)=3);

-----------------------------------------
-- oder ** this one is not good
SELECT DISTINCT a.lnr, lname FROM lieferant a JOIN lieferung b
ON a.lnr IN (SELECT lnr FROM lieferung
				GROUP BY lnr
				HAVING COUNT(DISTINCT anr)=3);

-- oder
SELECT DISTINCT a.lnr, lname FROM lieferant a JOIN lieferung b
ON a.lnr = b.lnr
WHERE b.lnr IN (SELECT lnr FROM lieferung
				GROUP BY lnr
				HAVING COUNT(DISTINCT anr)=3);
--------------------------------------------------
-- oder
SELECT DISTINCT a.lnr, lname FROM lieferant a JOIN lieferung b
ON a.lnr = b.lnr
GROUP BY a.lnr, lname
HAVING COUNT(DISTINCT anr)=3;

-- oder
SELECT DISTINCT a.lnr, lname FROM lieferant a JOIN lieferung b
ON a.lnr = b.lnr
AND 3 = (SELECT COUNT(anr) FROM lieferung
		  WHERE b.lnr = lnr
		  GROUP BY lnr);


/*
2. Nummern, Namen und Wohnort der Lieferanten, die bereits
geliefert haben und deren Statuswert größer als der
durchschnittliche Statuswert aller Lieferanten ist. */
SELECT lnr, lname, lstadt FROM lieferant
WHERE lnr IN (SELECT lnr FROM lieferung)
AND status > (SELECT AVG(status) FROM lieferant);

-- oder
SELECT DISTINCT a.lnr, lname, lstadt FROM lieferant a JOIN lieferung b
ON a.lnr = b.lnr
AND status > (SELECT AVG(status) FROM lieferant);


-- 3. durchschnittliche Liefermenge des Artikels "A01"
SELECT anr,AVG(lmenge) FROM lieferung
GROUP BY anr
HAVING anr = 'A01';

-- oder
SELECT AVG(lmenge) FROM lieferung
WHERE anr = 'A01';

/*
4. Anzahl der Lieferungen roter Artikel, die seit dem 05.05.90 
durchgefüht wurden */
SELECT anr, COUNT(*) as 'Anzahl' FROM lieferung
WHERE ldatum > '05.05.1990' 
AND anr IN (SELECT anr FROM artikel WHERE farbe = 'rot')
GROUP BY anr;

SELECT anr, COUNT(*) as 'Anzahl' FROM lieferung
WHERE ldatum > '05.05.1990' 
GROUP BY anr
HAVING anr IN (SELECT anr FROM artikel WHERE farbe = 'rot');

-- oder
SELECT COUNT(b.anr) as 'Anzahl' FROM lieferung a JOIN artikel b
ON a.anr = b.anr
WHERE farbe = 'rot'
AND ldatum >= '05.05.1990';


/*
5. Nummern, Namen, und Wohnorte der Lieferanten, deren Status kleiner
als der von Lieferant L03 ist
*/
SELECT lnr, lname, lstadt FROM lieferant
WHERE status < (SELECT status FROM lieferant WHERE lnr = 'L03');

-- ** can polish more
SELECT DISTINCT a.lnr, a.lname, a.lstadt FROM lieferant a JOIN lieferant b
ON a.status < (SELECT status FROM lieferant WHERE lnr = 'L03');

-- oder
SELECT DISTINCT a.lnr, a.lname, a.lstadt FROM lieferant a JOIN lieferant b
ON a.status < b.status
WHERE b.lnr = 'L03';

/* 6. Gesamtliefermenge aller Lieferungen des Arikels A01 durch den Lieferanten L02*/
SELECT SUM(lmenge) FROM lieferung
WHERE anr = 'A01' AND lnr = 'L02';

/* 7. Der Lieferant Okupenko zieht jetzt nach Hamburg um */
UPDATE lieferant SET lstadt = 'Hamburg'
WHERE lname = 'Okupenko';

SELECT * FROM lieferant


-- Übungen

-- 1 Namen und Berufer aller gallier
SELECT gname, gberuf FROM gallier;

-- 2 Namen sowie der Wohnort aller römer
SELECT rname, rort FROM römer;

-- 3 anzahl aller in Kleinbonum lebenden römer
SELECT COUNT(*) FROM römer
WHERE rort = 'Kleinbonum';

-- 4 alle galliernamen in alphabetischer Reihenfolge
SELECT gname FROM gallier
ORDER BY gname ASC;

-- 5 alle Bände nach erscheinungsdatum sortiert

SELECT * FROM band
ORDER BY bjahr ASC;

-- 6 alle Gallier, die in Bände in denen sie eine besondere Rolle spielen
SELECT gname FROM gallier JOIN band
ON gnr = bchar;


-- 7. der Gallier mit dem höchsten Wildschweinkonsum
SELECT a.gname, a.wschweine FROM gallier a JOIN gallier b
on a.gnr = b.gnr
WHERE b.wschweine = (SELECT MAX(wschweine) FROM gallier);

SELECT gname, wschweine FROM gallier 
WHERE wschweine = (SELECT MAX(wschweine) FROM gallier);

SELECT TOP(1) gname, wschweine FROM gallier
ORDER BY wschweine DESC;


----------------------------------------------------------------
-- TOP Klausel
-- gesucht sind die drei gallier mit dem höchsten Wildschweinverbrauch
SELECT TOP(3) gname, wschweine FROM gallier
ORDER BY wschweine DESC;

-- mit OFFSET gibt man an, wie viele Datensätze übersprungen werden sollen 
-- bevor ein Ergebnis ausgegeben wird

-- FETCH gibt die Anzahl der Zeilen an, die zurückgegeben werden sollen
-- ,nachdem OFFSET verarbeitet wurde

-- gesucht sind die nächsten 5 Fallier nach den drei "stärksten" Wildschweinessern
SELECT gname, wschweine, gort FROM gallier
ORDER BY wschweine DESC
OFFSET 3 ROWS FETCH NEXT 5 ROWS ONLY;

-- Rangfolgen mit RANK
-- kann mit PARTITION BY verwendet werden
-- teilt das von der FROM klausel erzeugte Ergebnis, in Partitionenm
-- auf die die RANK funktion angewandet wird

-- Die Rangfolge der Gallier anhand der Wildschweine
-- it makes holders
SELECT gname, RANK() OVER(ORDER BY wschweine DESC) AS 'Rang', wschweine FROM gallier


-- Rangfolgefunktion NTILE
-- verteilt die zeilen in einer sortierten Partition in eine fest angelegte
-- Anzahl von Gruppen

-- Bildung von 4 Bandgruppen mit zuordnung ihres Erscheinungsjahres
SELECT NTILE(4) OVER(ORDER BY bjahr ASC) AS 'Kategorie', bname, bjahr FROM band
ORDER BY bjahr;

---------------------------------------------------------------------------------
-- Temporäre Tabellen
-- Lokale Temporäre Tabellen können von jedem Benutzer angelegt werden
-- Sie sind nur für die aktuelle Sitzung verfügbar
-- Sie werden mit einem # markiert
-- As long as the server, these tables will be obsoleted.

-- Die temporäre Tabelle hungrige_gallier soll erstellt werden. Sie soll alle Gallier
-- die 10 oder mehr Wildschweine essen beinhalten
SELECT gnr, gname, wschweine INTO #hungrige_gallier FROM gallier
WHERE wschweine >= 10;

DROP TABLE #hungrige_gallier;

SELECT * FROM #hungrige_gallier;

-- Lokale temporäre Tabellen #tabellenname
-- globale temporäre Tabellen ##tabellenname

SELECT gnr, gname, wschweine INTO ##hungrigere_gallier FROM gallier
WHERE wschweine >= 10;

SELECT * FROM ##hungrigere_gallier;


-- gesucht sind alle gallier die weniger Wildscwine Verdrücken als der höchste Wscheine Weirt
-- in der temporären Tabellen
SELECT * FROM gallier
WHERE wschweine < (SELECT MAX(wschweine)) FROM #hungrige_gallier);



