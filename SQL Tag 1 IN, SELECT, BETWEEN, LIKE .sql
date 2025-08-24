
/*
auskommentieren 
*/

-- auskommentieren einer Zeile

/*
SQL= Structured Query Language,

ist eine Sprache zur kommunikation mit relationalen Datenbanken
und zur Verwaltung und bearbeitung ihrer Daten. Sie ermöglicht das
Abspeichern, Aktualisieren, Entfernen und Suchen sowie das Abrufen
von Informationen aus der Datenbank.
*/

-- Grundlegende Befehle im SQL

-- SELECT Befehl

-- SELECT Befehl ohne Form

SELECT GETDATE();

SELECT 5 * 12;


-- SELECT Befehl mit Objektangabe

-- Alle Daten der Tabelle Lieferant
SELECT * FROM lieferant;

SELECT * FROM artikel;

SELECT aname FROM artikel;
-- SELECT (Was soll ausgewählt werden) FROM (woher soll er die Daten beziehen)




------------------------------------------------------------------------

-- WHERE Klausel

-- WHERE Klausel legt Bedingungen für die SELECT Abfrage fest

-- alle roten Artikel sollen angezeigt werden
SELECT * FROM artikel 
WHERE farbe = 'rot';

-- alle Lieferaten aus Hamburg sollen angezeigt werden
SELECT * FROM lieferant
WHERE lstadt= 'Hamburg'; 

-- gesucht sind die Namen aller Artikel die 17 gramm wiegen
SELECT aname FROM artikel
WHERE gewicht = 17;

-- oder
SELECT aname FROM artikel
WHERE gewicht = '17';

-- gesucht sind die Nummern,Namen aller Artikel die 17 gramm wiegen
SELECT anr,aname FROM artikel
WHERE gewicht = 17;

-- gesucht sind die Namen und der status aller Lieferanten die 
-- in Aachen wohnen
SELECT lname, status FROM lieferant
WHERE lstadt= 'Aachen';

-- gesucht sind alle lieferungen, bei denen der Artikel A02 
-- ausgeliefert wurde
SELECT * FROM lieferung
WHERE anr = 'A02';

-- Vergleichsoperatoren

-- alle lieferungen mit einer Liefermenge von min. 200 Stück
SELECT * FROM lieferung
WHERE lmenge >= 200;

-- oder
SELECT * FROM lieferung
WHERE lmenge > 199;

-- gesucht sind alle Liferungen vom 9.August 1990
SELECT * FROM lieferung
WHERE ldatum = '09.08.1990';


---------------------------------------------------------------------

-- Schlüsselwort BETWEEN

-- BETWEEN wird immer mit dem Operator AND benutzt

-- gesucht sind alle Lieferungen zwischen dem 01.08 und dem 31.08.1990
SELECT * FROM lieferung
WHERE ldatum BETWEEN '01.08.1990' AND '31.08.1990';

-- alle Artikel deren Gewicht zwischen 14 und 17 gramm liegen
SELECT * FROM Artikel
WHERE gewicht BETWEEN 14 AND 17;

-- AND und OR

-- Gesucht sind alle Lieferanten die in Aachen oder Hamburg wohnen
SELECT * FROM lieferant
WHERE lstadt = 'Aachen' OR lstadt = 'Hamburg';

-- Gesucht sind alle Lieferanten deren Status größer als 10 ist und
-- in Ludwigshafen wohnen
SELECT * FROM lieferant
WHERE status > 10 AND lstadt='Ludwigshafen';

-- Gesucht sind alle blauen Schrauben
SELECT * FROM artikel
WHERE aname = 'Schraube' AND farbe= 'blau';

-- gesucht sind die Nummern, Namen aller artikel die 14 gramm wiegen oder in Mannheim lagern
SELECT anr,aname FROM artikel
WHERE gewicht = 14 OR astadt='Mannheim';

--------------------------------------------------------------------------------
-- Schlüsselwort IN
-- ermittelt, ob ein bestimmter Wert in der Abfrage mit den eingetragenen
-- Werten übereinstimmt

-- Alle Lieferungen von 100, 300 oder 400 stück

-- ohne IN Operator
SELECT * FROM lieferung
WHERE lmenge = 100 OR lmenge= 300 OR lmenge= 400;

-- IN Operator
SELECT * FROM lieferung
WHERE lmenge IN(100,300,400);

-- gesucht sind alle roten und blauen artikel
SELECT * FROM artikel
WHERE farbe IN('rot','blau');

-- gesucht sind alle artikel die nicht rot oder grün sind
SELECT * FROM artikel
WHERE farbe NOT IN('rot','grün');

-- gesucht sind alle Lieferanten die nicht in Hamburg oder Aachen wohnen
SELECT * FROM lieferant
WHERE lstadt NOT IN('Hamburg','Aachen');

-- ohne IN
SELECT * FROM lieferant
WHERE lstadt != 'Hamburg' AND lstadt != 'Aachen';

-- Nummer, Namen und lagerort aller artikel die Muttern oder Zahnräder sind
SELECT anr, aname, astadt FROM artikel
WHERE aname IN('Mutter','Zahnrad');

---------------------------------------------------------------------------------

-- Schlüsselwort LIKE

-- alle artikel die mit einem S beginnen
SELECT * FROM artikel
WHERE aname LIKE 'S%';

-- alle lieferanten deren Namen mit B oder J beginnen
SELECT * FROM lieferant
WHERE lname LIKE 'B%' OR lname LIKE 'J%';

-- oder
SELECT * FROM lieferant
WHERE lname LIKE '[BJ]%';

-- alle lieferanten deren Namen mit B bis J beginnen
SELECT * FROM lieferant
WHERE lname LIKE '[B-J]%';

-- alle artikel deren name an zweiter stelle ein o hat
SELECT * FROM artikel
WHERE aname LIKE '_o%';

-- alle artikel deren name an vorletzter stelle ein l hat
SELECT * FROM artikel
WHERE aname LIKE '%l_';

-- alle Daten dere Liferanten in deren Lieferantennamen kein a vorkommt
SELECT * FROM lieferant
WHERE lname NOT LIKE '%a%';

--------------------------------------------------------------------------------
-- Übungen
/*
1. gesucht sind die Namen und der Status aller Hamburger Lieferanten
2. gesucht sind alle roten Artikel die 14 oder 19 gramm wiegen
3. alle Lieferanten die nicht in Hamburg wohnen
4. gesucht sind alle lieferungen bei denen die Artikel A01 oder A04 versendet wurden
5. alle Artikel mit einer Lagermenge von 900 oder mehr
6. Alle Lieferanten in deren Namen kein z vorkommt
7. Alle Lieferungen die nicht zwischen dem 01.07 und dem 30.07.1990 stattfanden
*/

--1.gesucht sind die Namen und der Status aller Hamburger Lieferanten
SELECT lname, status FROM lieferant
WHERE lstadt = 'Hamburg';

--2. gesucht sind alle roten Artikel die 14 oder 19 gramm wiegen
SELECT * FROM artikel
WHERE farbe = 'rot' AND gewicht IN(14,19);

--3. alle Lieferanten die nicht in Hamburg wohnen
SELECT * FROM lieferant
WHERE lstadt != 'Hamburg';

--4. gesucht sind alle lieferungen bei denen die Artikel A01 oder A04 versendet wurden
SELECT * FROM lieferung 
WHERE anr IN('A01','A04');

-- 5. alle Artikel mit einer Lagermenge von 900 oder mehr
SELECT * FROM artikel
WHERE amenge >= 900;

--6. Alle Lieferanten in deren Namen kein z vorkommt
SELECT * FROM lieferant
WHERE lname NOT LIKE '%z%';

--7. Alle Lieferungen die nicht zwischen dem 01.07 und dem 30.07.1990 stattfanden
SELECT * FROM lieferung
WHERE ldatum NOT BETWEEN '01.07.1990' AND '30.07.1990';

---------------------------------------------------------------------------------

-- Entfernen doppelter Datensätze mit DISTINCT

-- DISTINCT wirkt sich auf den gesamten Datensatz im Ergebnis aus, deswegen
-- wird es direkt in der SELECT abfrage angegeben
-- Die gleichheit der Datensätze werden überprüft


SELECT lnr FROM lieferung;
-- ergebniss sind 12 Datensätze

SELECT DISTINCT lnr FROM lieferung;
-- ergebinss 4 Datensätze

--------------------------------------------------------------------------------
-- Berrechnen der Ergebnismengen

-- + Addieren
-- - Subtrahieren
-- * Multiplizieren
-- / Dividieren
-- % (Modulo) Gibt den Ganzzahligen Rest einer Division aus

-- das Gewicht aller artikel in kg 
SELECT amenge * 0.001 as 'Gewicht in KG' FROM artikel;


SELECT lnr, ldatum,lmenge, lmenge + 100 as 'neue Menge' FROM lieferung
WHERE lnr = 'L03';


SELECT lnr,lname, status - 10 AS 'neuer Status' FROM lieferant
WHERE lname= 'Adam';


-- Operator + für das verketten von Zeichenfolgen

SELECT 'Der Lieferant ' +lname+ ' wohnt in ' +lstadt FROM lieferant;

SELECT 'Die '+aname+ ' mit der Artikelnummer '+anr+ ' ist '+farbe+
' und wird in '+astadt+ ' gelagert' FROM artikel
WHERE anr='A03';

------------------------------------------------------------------------------

-- mehr Übungen

/*
1. gesucht sind alle Artikel die über 13 gramm wiegen
2. gesucht sind alle Lieferanten, die kein b im namen tragen
3. gesucht sind alle Lieferungen, die zwischen dem 06.08. und dem 21.08.1990 
   getätigt wurden
4. gesucht sind alle Schrauben die nicht blau oder grün sind
5. gesucht sind alle Artikel die mit dem Buchstaben e enden
6. gesucht sind alle Artikel die ein c an zweiter stelle tragen
7. gesucht sind alle Artikel die mehr als 15 gramm wiegen, oder deren lagermenge
   größer als 600 ist
*/

--1. gesucht sind alle Artikel die über 13 gramm wiegen
SELECT * FROM Artikel
WHERE gewicht >13;

-- oder
SELECT * FROM Artikel
WHERE gewicht >=14;

--2. gesucht sind alle Lieferanten, die kein b im namen tragen
SELECT * FROM lieferant
WHERE lname NOT LIKE '%b%';

--3. gesucht sind alle Lieferungen, die zwischen dem 06.08. und dem 21.08.1990 getätigt wurden
SELECT * FROM lieferung
WHERE ldatum BETWEEN '06.08.1990' AND '21.08.1990';

--4. gesucht sind alle Schrauben die nicht blau oder grün sind
SELECT * FROM artikel
WHERE aname= 'Schraube' AND farbe NOT IN('blau','grün');

-- oder
SELECT * FROM artikel
WHERE aname= 'Schraube' AND farbe !='blau' AND farbe!='grün';

--5. gesucht sind alle Artikel die mit dem Buchstaben e enden
SELECT * FROM artikel
WHERE aname LIKE '%e';

--6. gesucht sind alle Artikel die ein c an zweiter stelle tragen
SELECT * FROM artikel 
WHERE aname LIKE '_c%';

--7. gesucht sind alle Artikel die mehr als 15 gramm wiegen, oder deren lagermenge größer als 600 ist
SELECT * FROM artikel
WHERE gewicht > 15 OR amenge > 600;

----------------------------------------------------------------------------------

-- Sortieren der Ergebnismenge mit ORDER BY

-- ASC  aufsteigend
-- DESC absteigend

SELECT aname, farbe, astadt FROM artikel;

SELECT aname, farbe, astadt FROM artikel
ORDER BY aname DESC;

-- sortieren nach Spaltennamen
SELECT aname as 'Artikelname', farbe as 'Artikelfarbe', astadt AS 'Lagerort'
FROM artikel 
ORDER BY 'Artikelname' ASC;


SELECT aname, farbe, astadt FROM artikel
ORDER BY farbe DESC;

--------------------------------------------------------------------------
-- Auflisten der TOP n Werte

-- gesucht sind die drei Lieferungen, mit den höchsten liefermengen
SELECT TOP(3) lnr, lmenge, ldatum FROM lieferung
ORDER BY lmenge DESC;

-- gesucht sind die drei Lieferanten mit dem niedrigsten Status
SELECT TOP(3) lnr, lname, status FROM lieferant
ORDER BY status ASC;

--------------------------------------------------------------------------------

-- einfache CASE Funktion

-- vergleicht einen Ausdruck mit mehreren einfachen Ausdrücken um das
-- Ergebnis zu bestimmen

SELECT anr, aname, astadt,amenge, CASE 
							WHEN amenge BETWEEN 0 AND 400 THEN 'nachbestellen'
							WHEN amenge BETWEEN 401 AND 1000 THEN 'ausreichend'
							ELSE 'Lager voll'
							END as 'Bewertung'
FROM artikel;



SELECT lnr, anr, lmenge, CASE 
						WHEN lmenge BETWEEN 0 and 100 THEN 'da hätte mehr draufgepasst'
						WHEN lmenge BETWEEN 101 AND 300 THEN 'gut ausgelastet'
						ELSE 'Anzeige ist raus!'
						END AS 'Liefernotiz'
FROM lieferung;

