USE ab_i_04_tovabbigyak;

SELECT * FROM ugynokok;

SELECT * FROM ingatlanok;

SELECT * FROM tipusok;

/* 1. feladat: Listázza ki azoknak a nem budapesti ingatlanoknak a helységnevét, szobaszámát, árát és a
képviselő ügynök nevét, amelyek garázzsal rendelkeznek vagy Házrész típusúak! A listát rendezze ár
szerint csökkenő sorrendbe! */
SELECT ingatlanok.helyseg
     , ingatlanok.szobaszam
     , ingatlanok.ar
     , ugynokok.ugynok_nev
FROM ingatlanok
INNER JOIN ab_i_04_tovabbigyak.ugynokok on ingatlanok.fk_ugynokID = ugynok_ID
WHERE helyseg <> 'Budapest'
  AND (fk_tipusID = 3 OR garazs = 1)
ORDER BY ar DESC;
-- Házrész = tipus_id 3 --> ezen lehetne még dolgozni

/* 2. feladat: Jelenítse azoknak az ügynököknek a nevét és telefonszámát, akikhez nem kapcsolódik
ingatlan! */
SELECT ugynokok.ugynok_nev
     , ugynokok.telefon
FROM ugynokok
LEFT JOIN ab_i_04_tovabbigyak.ingatlanok i on ugynokok.ugynok_ID = i.fk_ugynokID
GROUP BY ugynokok.ugynok_nev, ugynokok.telefon
HAVING COUNT(i.ingatlan_ID) = 0;

/* 3. feladat: Városonként (helységenként) számlálja meg, hány olyan ingatlan van, amelynek ára 10 és 14
millió Ft között van! A lista a megszámlált érték szerint csökkenő sorrendben jelenjen meg! */
SELECT helyseg
     , COUNT(ingatlan_ID)
FROM ingatlanok
WHERE ar BETWEEN 10 AND 14
GROUP BY helyseg
ORDER BY COUNT(ingatlan_ID) DESC;

/* 4. feladat: Listázza ki átlagár szerinti sorrendben azoknak az ingatlantípusoknak a nevét és az adott
típushoz tartozó ingatlanok átlagos árát, amelyeknek átlagára 17.5 MFt-nál kisebb! */
SELECT t.tipus_nev
     , AVG(ar)
FROM ingatlanok
INNER JOIN ab_i_04_tovabbigyak.tipusok t on ingatlanok.fk_tipusID = t.tipus_ID
GROUP BY t.tipus_nev
HAVING AVG(ar) < 17.5;

/* 5. feladat: Listázza ki minden városból a legdrágább ingatlan helységnevét és árát! A listában csak az
első 20 találat legyen látható! */
SELECT helyseg
     , MAX(ingatlanok.ar)
FROM ingatlanok
GROUP BY helyseg
ORDER BY MAX(ingatlanok.ar) DESC
LIMIT 20;
-- itt a LIMIT 20 nem fog érvényesülni mert csak 5 Város szerepel az eredmény listában

/* 6. feladat: Készítsen megyek néven egy olyan táblát, amelynek három mezője van: (1) a megye_ID mező
legyen automatikus számozású, INT típusú elsődleges kulcs; (2) a megye_nev legfeljebb 30 karakteres
szövegeket megengedő mező; (3) az indul_datum legyen dátum típusú! A létrehozáshoz szükséges
SQL-parancsot vagy a tábla szerkezeti nézetének képernyőképét mentse a word-dokumentumba! */
CREATE TABLE IF NOT EXISTS megyek ( megye_id INT AUTO_INCREMENT
                                  , megye_nev VARCHAR(30)
                                  , indul_datum DATE
                                  , PRIMARY KEY (megye_id));

SHOW TABLES; -- ezzel csak ellenőrzöm, hogy elkészült e a tábla
SELECT * FROM megyek; -- és hogy üres

/* 7. feladat: Bővítse az ingatlanok táblát olyan fk_megyeID nevű, INT típusú új mezővel, amelybe csak
olyan idegenkulcs-érték beszúrható, amely a megyek táblában már szerepel kulcsértékként! A
létrehozáshoz használt SQL-parancso(ka)t mentse a word-dokumentumba! */
ALTER TABLE ingatlanok
    ADD COLUMN fk_megyeID INT,
    ADD KEY (fk_megyeID),
    ADD CONSTRAINT `ingatlanok_ibfk_3` FOREIGN KEY (fk_megyeID) REFERENCES megyek (megye_id);

/* 8. feladat: Készítsen törlő lekérdezést, amellyel törölheti az ingatlanok táblából azokat az ingatlanokat,
amelyek 1.000.000 Ft-nál olcsóbbak vagy Ajkán találhatóak! A törlő parancsot mentse a worddokumentumba! */
SELECT ingatlan_ID
FROM ingatlanok
WHERE ar < 1 OR helyseg = 'Ajka';
-- ez csak egy előzetes ellenőrzés amivel megnézem milyen rekordok kerülnek törlésre.

DELETE
FROM ingatlanok
       WHERE ar < 1 OR helyseg = 'Ajka';