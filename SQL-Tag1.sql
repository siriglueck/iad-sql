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

