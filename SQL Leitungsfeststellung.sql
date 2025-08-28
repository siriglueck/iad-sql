-- # Leistungsfeststellung # --
-- Siriluck Rattanapong 28.02.2025 --

-- 1. Die Daten aller Lieferanten aus Aachen. (3P)
SELECT * FROM lieferant
WHERE lstadt = 'Aachen';

-- 2. Namen, Lagerorte und Gewicht aller einzelnen Artikel in kg. (3P)
SELECT aname, astadt, gewicht/1000 AS 'Gewicht in Kilo' FROM artikel;

-- 3. Die Daten aller Lieferungen von in Ludwigshafen gelagerten Artikeln. (3P)
SELECT * FROM lieferung
WHERE anr IN (SELECT anr FROM artikel
			  WHERE astadt = 'Ludwigshafen');

-- 4. Namen und Nummern aller Lieferanten mit einem Status zwischen 8 und 20. (3P)
SELECT lname, lnr FROM lieferant
WHERE status BETWEEN 8 AND 20;

-- 5. Das Datum Aller Lieferungen, bei denen der Artikel A01 ausgeliefert wurde. (3P)
SELECT anr, ldatum FROM lieferung
WHERE anr = 'A01';

-- 6. Artikelnummer, Artikelname sowie alle Daten der Lieferanten mit übereinstimmendem Lager und Wohnort. (3P)
SELECT anr, aname, b.* FROM artikel a JOIN lieferant b
ON a.astadt = b.lstadt ;

-- 7 Nummern, Namen aller Lieferanten die mindestens einen Artikel geliefert haben, den auch Lieferant L04 geliefert hat. (3P)
SELECT lnr, lname FROM lieferant
WHERE lnr IN(SELECT DISTINCT lnr FROM lieferung
			  WHERE anr IN(SELECT anr FROM lieferung
							WHERE lnr = 'L04'));

-- 8 Nummern und Namen aller Lieferanten, die mindestens 2 verschiedene Artikel geliefert haben. (3P)
SELECT lnr, lname FROM lieferant
WHERE lnr IN (SELECT lnr FROM Lieferung
			  GROUP BY lnr
			  HAVING COUNT(anr) >= 2);

-- 9. Alle Lieferanten die in Hamburg wohnen und in deren Namen kein „h“ vorkommt. (3P)
SELECT * FROM lieferant
WHERE lstadt = 'Hamburg'
AND lname NOT LIKE '%h%';

-- 10. Die Menge der gelagerten Artikel soll in einer Tabelle „Bestand“ ausgegeben werden. 
--     Sollte die Menge eines Artikels 400 oder weniger betragen muss nachbestellt werden, 
--	   bis 1000 Stück sind ausreichend viele Artikel im Lager. 
-- Alle Artikel deren Lagerbestand über 1000 Stück liegen, sollen ins Angebot genommen werden. (4P)
SELECT anr, amenge, 
CASE
	WHEN amenge BETWEEN 0 AND 400 THEN 'nachbestellen'
	WHEN amenge BETWEEN 401 AND 1000 THEN 'ausreichend'
	WHEN amenge > 1000 THEN 'ins Angebot nehmen'
	ELSE 'error'
END AS 'Bestand'
FROM artikel;

-- 11. Gesamtliefermenge aller Lieferungen des Artikels A01 durch den Lieferanten L04. (4P)
SELECT SUM(lmenge) FROM lieferung
WHERE anr = 'A01' AND lnr = 'L04';


--12. Nummern und Namen der Lieferanten, deren Statuswert größer als der von Lieferant L05 ist. (4P)
SELECT lnr, lname FROM lieferant
WHERE status > (SELECT status FROM lieferant 
				WHERE lnr = 'L05');

-- 13. Nummern, Namen und Status aller Lieferanten die nicht den Artikel A04 geliefert haben. (4P)
SELECT lnr, lname, status FROM lieferant
WHERE lnr NOT IN (SELECT lnr FROM lieferung 
				  WHERE anr ='A04');

-- 14. Alle Angaben, bei denen Hamburger Lieferanten im Juli 1990 grüne Artikel lieferten. (4P) 
SELECT * FROM lieferung
WHERE MONTH(ldatum) = 7
AND YEAR(ldatum) = 1990
AND lnr IN (SELECT lnr FROM lieferant
			WHERE lstadt = 'Hamburg')
AND anr IN (SELECT anr FROM artikel
			WHERE farbe = 'grün');

-- 15. Lagerorte aller Artikel die von Lieferant L01 geliefert wurden. (4P)
SELECT DISTINCT astadt FROM artikel
WHERE anr IN (SELECT anr FROM lieferung 
			  WHERE lnr = 'L01');

-- 16. Die Daten aller Lieferanten die mindestens 4 verschiedene Artikel mindestens einmal ausgeliefert haben. (5P)
SELECT * FROM lieferant
WHERE lnr IN (SELECT lnr FROM Lieferung
			  GROUP BY lnr
			  HAVING COUNT(anr) >= 4 );

-- 17. Anzahl der Lieferungen die seit dem 01.08.1990 von Lieferanten aus Ludwigshafen ausgeführt wurden. (5P)
SELECT COUNT(lnr) FROM lieferung
WHERE ldatum > '01.08.1990'
AND lnr IN ( SELECT lnr FROM lieferant
			 WHERE lstadt = 'Ludwigshafen');


-- 18. Nummern und Namen aller Artikel, deren größte Liefermenge kleiner als die durchschnittliche Menge von Artikel A02 ist. (5P)
SELECT a.anr, aname FROM artikel a JOIN lieferung b
ON a.anr = b.anr
GROUP BY a.anr, aname
HAVING MAX(lmenge) < (SELECT AVG(lmenge) FROM lieferung
					  WHERE anr = 'A02');


-- 19. Nummern, Namen und Wohnort der Lieferanten, die mindestens 2 Lieferungen durchgeführt haben 
--     und deren Status größer als der kleinste Status aller Lieferanten ist. (5P)
SELECT lnr, lname, lstadt FROM lieferant
WHERE lnr IN (SELECT lnr FROM lieferung
			  GROUP BY lnr
			  HAVING COUNT(lnr) >= 2)
AND status > (SELECT MIN(status) FROM lieferant);


-- 20. Schreibe eine Abfrage die folgenden Satz zum Artikel A05 ausgibt(3P)
-- Die Nockenwelle mit der Artikelnummer A05 ist blau und wiegt 12 Gramm, sie wird in Ludwigshafen gelagert.
SELECT 'Die ' + aname + ' mit der Artikelnummer ' + anr + ' ist ' + farbe + ' und wiegt ' + CAST(gewicht AS CHAR(5)) + ' Gramm, sie wird in '+ astadt + ' gelagert'
FROM artikel
WHERE anr = 'A05';


-- 21. Ein neuer Artikel mit der Nummer A38 soll ins Sortiment hinzugefügt werden. 
-- Es handelt sich um einen blauen Passierschein. 
-- Der 10 gram leichte Schein soll in Erfurt gelagert werden, noch ist die Menge der Scheine unbekannt. (3P)

INSERT INTO artikel (anr, farbe, aname, gewicht, astadt, amenge)
VALUES ('A38', 'blau','Passierschein', 10, 'Erfurt', NULL);

SELECT * FROM artikel;


-- 22. Füge der Tabelle Lieferant eine neue Spalte mit dem Namen Postleitzahl hinzu. Sie muss nicht befüllt werden. (3P)  
ALTER TABLE verwaltung.lieferant
ADD Postleitzahl INT;

SELECT * FROM lieferant;