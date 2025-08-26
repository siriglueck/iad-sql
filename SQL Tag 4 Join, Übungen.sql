-- SQL Tag 4 21.8.25


-- Verknüpfen von Tabellen mit JOIN

-- Man unterscheidet in drei Arten von Verknüpfungen

-- Innere Verknüfung INNER JOIN
-- äußere Verknüpfung OUTER JOIN
-- kreutzverknüpfung CROSS JOIN

-- JOIN Typen

-- CROSS JOIN			-kennzeichnet das kartesische Produkt
-- INNER JOIN			-kennzeichnet die natürliche verknüpfung zweier Tabellen

--LEFT (OUTER) JOIN		-linke Außenverknüpfung
--RIGHT (OUTER)JOIN		-rechte Außenverknüpfung
--FULL (OUTER) JOIN		-eine kombination aus beiden Verknüpfungen


-- CROSS JOIN

-- das kartesische Produkt zwischen den Tabellen lieferant und lieferung
SELECT * FROM lieferant CROSS JOIN lieferung;

SELECT * FROM lieferant, lieferung;


-- INNER JOIN
-- Beim inner JOIN werden zwei oder mehrere Tabellen über eine Spalte 
-- miteinander verbunden

SELECT * FROM lieferant a JOIN lieferung b
ON a.lnr=b.lnr;


SELECT * FROM lieferant a JOIN lieferung b
ON a.lnr=b.lnr JOIN artikel c ON b.anr=c.anr;


-- gesucht sind die nummern und Namen der Lieferanten die geliefert haben

-- ohne JOIN
SELECT lnr, lname FROM lieferant
WHERE lnr IN (SELECT lnr FROM lieferung);

-- mit JOIN
SELECT DISTINCT a.lnr, lname FROM lieferant a JOIN lieferung b
ON a.lnr=b.lnr;

-- gesucht sind alle artikel die an einem Ort gelagert werden, an dem auch Lieferanten leben

-- ohne JOIN
SELECT * FROM artikel
WHERE astadt IN (SELECT lstadt FROM lieferant);

-- mit JOIN
SELECT * FROM artikel JOIN lieferant
ON astadt=lstadt;

-- gesucht sind die Lieferanten, die an einem Ort wohnen, an dem auch andere
-- Lieferanten leben
SELECT a.* FROM lieferant a JOIN lieferant b
ON a.lstadt = b.lstadt
AND a.lnr != b.lnr;

-- OUTER JOIN

-- LEFT JOIN
-- LEFT JOIN beeinhaltet sämtliche Reihen aus der zuerst (linke) genannten Tabelle,
-- sowie die Reihen der zweiten Tabelle die die Verknüpfung erfüllen

-- gesucht alle lieferanten sowie ihre Lieferungen, es sollen auch die Lieferanten
-- angezeigt werden, die noch nicht geliefert haben

SELECT a.*, anr, lmenge,ldatum FROM lieferant a LEFT JOIN Lieferung b
ON a.lnr=b.lnr;

-- RIGHT
-- Right JOIN beeinhaltet sämtliche Reihen aus der zuerst (rechten) genannten Tabelle,
-- sowie die Reihen der zweiten Tabelle die die Verknüpfung erfüllen

-- gesucht sind die lieferungen und ihre zugehörigen lieferanten, es sollen aber auch
-- die lieferungen angezeigt werden, zu der kein lieferant existiert
SELECT a.*, lname, lstadt FROM lieferung a RIGHT JOIN lieferant b
ON a.lnr=b.lnr;

-- FULL JOIN

-- beinhaltet sämtliche Reihen der linken und rechten Tabelle
-- die die Bedingungen erfüllen, aber auch die Reihen der linken und rechten Tabelle
-- die sie nicht erfüllen

SELECT * FROM lieferant a FULL JOIN lieferung b
ON a.lnr=b.lnr;


-- Übungsaufgaben
-- freie Befehlswahl bei der lösung der Übungsaufgaben
/*
1. Nummern aller Lieferanten, die mindestens einen Artikel geliefert
	haben den auch Lieferant L03 geliefert hat.
2. Nummern aller Lieferanten, die mehr als eine Artikel geliefert haben
3. Nummern und Namen der Artikel, die am selben Ort wie Artikel A03 
	gelagert werden.
4. Durchschnittliche Liefermenge von Artikel A01
5. Gesamtliefermenge aller Lieferungen des Artikels A01 durch den
	Lieferanten L02
6. Lagerorte der Artikel, die von Lieferant L02 geliefert wurden
7. Nummern und Namen der Lieferanten, deren Status kleiner als der 
	von Lieferant L03 ist
8. Nummern und Namen aller Lieferanten, die den Artikel A05 nicht 
	geliefert haben.
*/

-- 1. Nummern aller Lieferanten, die mindestens einen Artikel geliefert
--		haben den auch Lieferant L03 geliefert hat.

SELECT lnr FROM lieferung a 
WHERE EXISTS (SELECT * FROM lieferung b
				WHERE a.anr=b.anr AND lnr='L03')
AND lnr !='L03';


-- oder
SELECT lnr FROM lieferung  
WHERE anr IN (SELECT anr FROM lieferung 
				WHERE lnr='L03')
AND lnr !='L03';


-- oder
SELECT a.lnr FROM lieferung a JOIN lieferung b
ON a.anr=b.anr
WHERE b.lnr='L03'
AND a.lnr !='L03';

--2. Nummern aller Lieferanten, die mehr als eine Artikel geliefert haben
SELECT lnr AS 'Anzahl' FROM lieferung
GROUP BY lnr 
HAVING COUNT(DISTINCT anr) > 1;

-- oder 
SELECT lnr AS 'Anzahl' FROM lieferung
GROUP BY lnr 
HAVING 2 <= COUNT(anr);

-- oder
SELECT a.lnr, a.anr FROM lieferung a JOIN lieferung b
ON a.lnr=b.lnr
AND a.anr!=b.anr

-- oder
SELECT DISTINCT a.lnr FROM lieferung a
WHERE 1 < (SELECT COUNT(anr) FROM lieferung b
			WHERE a.lnr=b.lnr);

--3. Nummern und Namen der Artikel, die am selben Ort wie Artikel A03 
-- 	 gelagert werden.
SELECT anr, aname, astadt FROM artikel
WHERE astadt IN (SELECT astadt FROM artikel
					WHERE anr='A03');

-- oder
SELECT anr, aname FROM artikel
WHERE astadt = (SELECT astadt FROM artikel
					WHERE anr='A03');

-- oder
SELECT a.anr, a.aname FROM artikel a JOIN artikel b
ON a.astadt=b.astadt
AND b.anr='A03'


--4. Durchschnittliche Liefermenge von Artikel A01
SELECT AVG(lmenge) AS 'Durchschnittsmenge' FROM lieferung
WHERE anr='A01';


--5. Gesamtliefermenge aller Lieferungen des Artikels A01 durch den
--	 Lieferanten L02
SELECT SUM(lmenge) AS 'Gesamtmenge' FROM lieferung
WHERE anr = 'A01' AND lnr= 'L02';


--6. Lagerorte der Artikel, die von Lieferant L02 geliefert wurden
SELECT astadt FROM artikel
WHERE anr IN (SELECT anr FROM lieferung 
				WHERE lnr= 'L02');

-- oder
SELECT a.anr, a.astadt FROM artikel a JOIN lieferung b
ON a.anr=b.anr
WHERE lnr='L02';


--7. Nummern und Namen der Lieferanten, deren Status kleiner als der 
-- 	 von Lieferant L03 ist
SELECT lnr, lname FROM lieferant
WHERE status < (SELECT status FROM lieferant
				WHERE lnr='L03');

-- oder
SELECT a.lnr, a.lname FROM lieferant a JOIN lieferant b
ON a.status < b.status
WHERE b.lnr='L03';

--8. Nummern und Namen aller Lieferanten, die den Artikel A05 nicht 
--	 geliefert haben.
SELECT lnr, lname FROM lieferant
WHERE lnr NOT IN (SELECT lnr FROM lieferung 
					WHERE anr = 'A05');

-- oder ohne die Lieferanten die noch nie lieferten
SELECT lnr, lname FROM lieferant
WHERE lnr NOT IN (SELECT lnr FROM lieferung 
					WHERE anr = 'A05' OR anr=NULL);

-- oder
SELECT a.lnr, a.lname FROM lieferant a
WHERE NOT EXISTS (SELECT lnr FROM lieferung b
					WHERE a.lnr=b.lnr
					AND anr='A05');

-- oder
SELECT a.lnr, a.lname FROM lieferant a JOIN lieferung b
ON a.lnr=b.lnr
AND b.lnr NOT IN (SELECT lnr FROM lieferung
					WHERE anr = 'A05');


-- kleine Übung vor dem Mittag

-- Schreibe zwei verschiedene Abfragen die alle Lieferantan ausgibt, deren
-- Namen mit S, C oder B beginnen und deren dritter Buchstabe ein a ist.
SELECT * FROM lieferant
WHERE lname LIKE '[SCB]%' AND lname LIKE '__a%';

-- oder
SELECT * FROM lieferant
WHERE lname LIKE '[SCB]_a%';

-- oder
SELECT a.lname FROM lieferant a JOIN Lieferant b
ON a.lname=b.lname
AND b.lname LIKE '[SCB]_a%';

-- oder
SELECT * FROM lieferant
WHERE lname LIKE 'S_a%' OR lname LIKE 'C_a%' OR lname LIKE 'B_a%';

-- oder
SELECT * FROM lieferant
WHERE lname IN (SELECT lname FROM lieferant
				WHERE lname LIKE '[SCB]%')
AND lname LIKE '__a%';



-- mittelgroße Übungen
/*
1. Nummern, Namen und Wohnort der Lieferanten, die bereits geliefert haben
   und deren status größer als der kleinste status aller lieferanten ist
2. Nummern und namen aller artikel,deren durchschnittliche Liefermenge kleiner als die
   durchschnittsmenge von artikel A03 ist
3. Lieferantennamen und nummern, Artikelname und artikelnummern aller lieferungen
   die seit dem 05.05.1990 von Hamburger lieferanten durchgeführt wurden

Zusatz:
4. Lieferantennummern und Namen, die alle verschiedenen Artikel geliefert haben
*/

--1. Nummern, Namen und Wohnort der Lieferanten, die bereits geliefert haben
--   und deren status größer als der kleinste status aller lieferanten ist
SELECT lnr,lname,lstadt FROM lieferant
WHERE status > (SELECT MIN(status) FROM lieferant)
AND lnr IN (SELECT lnr FROM lieferung);

-- oder
SELECT a.lnr, lname, lstadt, status FROM lieferant a JOIN lieferung b
ON a.lnr=b.lnr
AND status >ANY (SELECT status FROM lieferant);

-- oder
SELECT a.lnr, lname, lstadt, status FROM lieferant a JOIN lieferung b
ON a.lnr=b.lnr
WHERE a.status > (SELECT MIN(status) FROM lieferant);

-- oder
SELECT a.lnr, lname, lstadt, status FROM lieferant a JOIN lieferung b
ON a.lnr=b.lnr
AND EXISTS (SELECT * FROM lieferant c
			WHERE c.status < a.status);


--2. Nummern und namen aller artikel,deren durchschnittliche Liefermenge kleiner als die
--   durchschnittsmenge von artikel A03 ist
SELECT anr, aname FROM artikel
WHERE anr IN (SELECT anr FROM lieferung
				GROUP BY anr
				HAVING AVG(lmenge) < (SELECT AVG(lmenge) FROM lieferung
										WHERE anr= 'A03'));

-- oder
SELECT a.anr, aname FROM artikel a JOIN lieferung b
ON a.anr=b.anr
GROUP BY a.anr, aname
HAVING AVG(lmenge) < (SELECT AVG(lmenge) FROM lieferung
										WHERE anr= 'A03');
 

--3. Lieferantennamen und nummern, Artikelname und artikelnummern aller lieferungen
--  die seit dem 05.05.1990 von Hamburger lieferanten durchgeführt wurden
SELECT b.lname, b.lnr, c.aname, c.anr ,a.ldatum FROM Lieferung a JOIN lieferant b
ON a.lnr=b.lnr JOIN artikel c ON a.anr=c.anr
AND a.ldatum > '05.05.1990' 
AND b.lstadt= 'Hamburg';

--4. Lieferantennummern und Namen, die alle verschiedenen Artikel geliefert haben
SELECT a.lnr, lname FROM lieferant a JOIN lieferung b
ON a.lnr=b.lnr
GROUP BY a.lnr,lname
HAVING COUNT(DISTINCT b.anr) = (SELECT COUNT(anr) FROM artikel);

-- oder 
SELECT lnr, lname FROM lieferant
WHERE lnr IN (SELECT lnr FROM lieferung
				GROUP BY lnr
				HAVING COUNT(DISTINCT anr) = (SELECT COUNT(anr) FROM artikel));



-- noch mehr Übungen

/*
5.Ortsnamen die Wohnort aber kein Lagerort sind
6.Ortsnamen die sowohl Wohn- als auch Lagerorte sind
7.Nummern, Namen aller lieferanten, die mindestens zwei verschiedene Artikel lieferten
8.Farbe und der Name aller Artikel, die von dem Lieferanten Clark geliefert wurden 
*/

--5.Ortsnamen die Wohnort aber kein Lagerort sind
SELECT lstadt FROM lieferant
WHERE lstadt NOT IN (SELECT astadt FROM artikel);

-- oder
SELECT DISTINCT lstadt FROM lieferant
WHERE NOT EXISTS (SELECT * FROM artikel
					WHERE lstadt=astadt); 


--6.Ortsnamen die sowohl Wohn- als auch Lagerorte sind
SELECT DISTINCT lstadt FROM lieferant
WHERE lstadt IN (SELECT astadt FROM artikel);

-- oder
SELECT DISTINCT lstadt FROM lieferant, artikel
WHERE lstadt=astadt;

-- oder
SELECT DISTINCT lstadt FROM lieferant JOIN artikel
ON lstadt=astadt;

--7.Nummern, Namen aller lieferanten, die mindestens zwei verschiedene Artikel lieferten
SELECT DISTINCT a.lnr, lname FROM lieferant a JOIN lieferung b
ON a.lnr=b.lnr
AND b.lnr IN (SELECT lnr FROM lieferung 
				GROUP BY lnr 
				HAVING COUNT(anr) >= 2);

-- oder
SELECT DISTINCT a.lnr, lname FROM lieferant a JOIN lieferung b
ON a.lnr=b.lnr
GROUP BY a.lnr, lname
HAVING COUNT(anr) > 1;


--8.Farbe und der Name aller Artikel, die von dem Lieferanten Clark geliefert wurden 
SELECT farbe, aname FROM artikel a JOIN lieferung b ON a.anr=b.anr
JOIN lieferant c ON b.lnr=c.lnr
WHERE lname = 'Clark';

-- oder
SELECT farbe, aname, lname FROM lieferant a JOIN lieferung b ON a.lnr=b.lnr
JOIN artikel c ON b.anr=c.anr
WHERE lname = 'Clark';


-- oder
SELECT farbe, aname FROM artikel
WHERE anr IN (SELECT anr FROM lieferung 
				WHERE lnr IN (SELECT lnr FROM lieferant
								WHERE lname= 'Clark'));