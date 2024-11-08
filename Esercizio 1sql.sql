/* MUSEI (NomeM, Citta)
ARTISTI (NomeA, Nazionalita)
OPERE (Codice, Titolo, NomeM*, NomeA*)
PERSONAGGI (Personaggio, Codice*) */

-- scrivere la interrogazioni SQL che restituiscono le seguenti informazioni:

/*1 - Il Codice ed il titolo delle opere di Tiziano conservate alla "National Gallery"*/
	SELECT OPERE.Codice, OPERE.Titolo
	FROM OPERE
	JOIN ARTISTI ON OPERE.NomeA = ARTISTI.NomeA
	JOIN MUSEI ON OPERE.NomeM = MUSEI.NomeM
	WHERE ARTISTI.NomeA = 'Tiziano'
		AND MUSEI.NomeM = 'National Gallery';
		
/*2 - Il Nome dell'artista ed il titolo delle opere conservate alla "Galleria degli Uffizi" o alla "National Gallery"*/
	SELECT ARTISTI.NomeA, OPERE.Titolo
	FROM OPERE
	JOIN ARTISTI ON OPERE.NomeA = ARTISTI.NomeA
	JOIN MUSEI ON OPERE.NomeM = MUSEI.NomeM
	WHERE MUSEI.NomeM = "Galleria degli Uffizi"
		OR MUSEI.NomeM = "National Gallery";
		
/*3 - Il nome dell'artista ed il titolo delle opere conservate nei musei di Firenze*/
	SELECT ARTISTI.NomeA, OPERE.Titolo
	FROM OPERE
	JOIN ARTISTI ON OPERE.NomeA = ARTISTI.NomeA
	JOIN MUSEI ON OPERE.NomeM = MUSEI.NomeM
	WHERE MUSEI.Citta = "Firenze";
	
/*4 - Le cittá in cui sono conservate le opere di Caravaggio*/
	SELECT DISTINCT MUSEI.Citta
	FROM OPERE
	JOIN MUSEI ON OPERE.NomeM = MUSEI.NomeM
	WHERE OPERE.NomeA = 'Caravaggio';
	
/*5 - Il Codice e il titolo delle di Tiziano conservate nei musei fi Londra*/
	SELECT OPERE.Codice, OPERE.titolo
	FROM OPERE
	JOIN ARTISTI ON OPERE.NomeA = ARTISTI.NomeA
	JOIN MUSEI ON OPERE.NomeM = MUSEI.NomeM
	WHERE ARTISTI.NomeA = "Tiziano"
		AND Musei.Citta = "Londra";
		
/*6 - Il Nome dell'artista ed il titolo delle opere di artisti spagnoli conservate nei musei di Firenze*/
	SELECT ARTISTI.NomeA, OPERE.Titolo
	FROM OPERE
	JOIN ARTISTI ON OPERE.NomeA = ARTISTI.NomeA
	JOIN MUSEI ON OPERE.NomeM = MUSEI.NomeM
	WHERE ARTISTI.Nazionalita = 'Spagnola'
		AND MUSEI.Citta = 'Firenze';
		
/*7 - Il Codice ed il titolo delle opere di artisti italiani conservate nei musei di Londra in cui é rappresentata la madonna*/
	SELECT OPERE.Codice, OPERE.Titolo
	FROM OPERE
	JOIN ARTISTI ON OPERE.NomeA = ARTISTI.NomeA
	JOIN MUSEI ON OPERE.NomeM = MUSEI.NomeM
	JOIN PERSONAGGI ON OPERE.Codice = PERSONAGGI.Codice
	WHERE ARTISTI.Nazionalita = 'Italiana'
		AND MUSEI.Citta = 'Londra'
		AND PERSONAGGI.Personaggio = 'Madonna';
		
/*8 - Per ciascun museo di Londra, il numero di opere di artisti italiani ivi conservate*/
	SELECT MUSEI.NomeM, COUNT(OPERE.Codice) AS NumeroOpere
	FROM OPERE
	JOIN ARTISTI ON OPERE.NomeA = ARTISTI.NomeA
	JOIN MUSEI ON OPERE.NomeM = MUSEI.NomeM
	WHERE ARTISTI.Nazionalita = 'Italiana'
		AND MUSEI.Citta = 'Londra'
	GROUP BY MUSEI.NomeM;
	
/*9 - Il nome dei musei di londra che non conservabo opere di Tiziano*/
	SELECT DISTINCT MUSEI.NomeM
	FROM MUSEI
	WHERE MUSEI.Citta = 'Londra'
		AND NOT EXISTS (
			SELECT 1
			FROM OPERE
			WHERE OPERE.NomeM = MUSEI.NomeM
				AND OPERE.NomeA = 'Tiziano'
		);
		
/*10 - Il nome dei musei di londra che conservano solo opere di Tiziano*/
	SELECT DISTINCT MUSEI.NomeM
	FROM MUSEI
	JOIN OPERE ON MUSEI.NomeM = OPERE.NomeM
	WHERE MUSEI.Citta = 'Londra'
	GROUP BY MUSEI.NomeM
	HAVING COUNT(DISTINCT OPERE.NomeA) = 1
		AND MIN(OPERE.NomeA) = 'Tiziano';
		
/*11 - Per ciascun artista, il nome dell'artista ed il numero di sue opere conservate alla "Galleria Degli Uffizi"*/
	SELECT ARTISTI.NomeA, COUNT(OPERE.Codice) AS NumeroOpere
	FROM OPERE
	JOIN ARTISTI ON OPERE.NomeA = ARTISTI.NomeA
	WHERE OPERE.NomeM = 'Galleria degli Uffizi'
	GROUP BY ARTISTI.NomeA;
	
/*12 - I musei che conservano almeno 20 opere di artisti italiani*/
	SELECT MUSEI.NomeM, COUNT(OPERE.Codice) AS NumeroOpere
	FROM OPERE
	JOIN ARTISTI ON OPERE.NomeA = ARTISTI.NomeA
	JOIN MUSEI ON OPERE.NomeM = MUSEI.NomeM
	WHERE ARTISTI.Nazionalita = 'Italiana'
	GROUP BY MUSEI.NomeM
	HAVING COUNT(OPERE.Codice) >= 20;

/*13 - Per le opere di artisti italiani che non hanno personaggi, il titolo dell'opera ed il nome dell'artista*/
	SELECT OPERE.Titolo, ARTISTI.NomeA
	FROM OPERE
	JOIN ARTISTI ON OPERE.NomeA = ARTISTI.NomeA
	LEFT JOIN PERSONAGGI ON OPERE.Codice = PERSONAGGI.Codice
	WHERE ARTISTI.Nazionalita = 'Italiana'
		AND PERSONAGGI.Codice IS NULL;
		
/*14 - Il nome dei musei di Londra che non conservano artisti italiani, tranne Tiziano*/
	SELECT DISTINCT MUSEI.NomeM
	FROM MUSEI
	JOIN OPERE ON MUSEI.NomeM = OPERE.NomeM
	JOIN ARTISTI ON OPERE.NomeA = ARTISTI.NomeA
	WHERE MUSEI.Citta = 'Londra'
	GROUP BY MUSEI.NomeM
	HAVING COUNT(DISTINCT CASE WHEN ARTISTI.Nazionalita = 'Italiana' AND ARTISTI.NomeA <> 'Tiziano' THEN ARTISTI.NomeA END) = 0;
	
/*15 - Per ogni museo, il numero di opere divise per la nazionalitá dell'artista*/
	SELECT MUSEI.NomeM, ARTISTI.Nazionalita, COUNT(OPERE.Codice) AS NumeroOpere
	FROM OPERE
	JOIN ARTISTI ON OPERE.NomeA = ARTISTI.NomeA
	JOIN MUSEI ON OPERE.NomeM = MUSEI.NomeM
	GROUP BY MUSEI.NomeM, ARTISTI.Nazionalita;