# DB elméleti felkészülés
https://e-learning.nje.hu/mod/page/view.php?id=19931


[DDL, DQL, DML, DCL and TCL](image.png)

## DDL - Data Definition Language

### CREATE
```sql
CREATE DATABASE adatbázisnév;
```      

```sql
CREATE TABLE táblanév(
        mezőnév1 mezőtípus1 [megszorítás1],
        mezőnév2 mezőtípus2 [megszorítás2],
        ...,
        [táblamegszorítások]
      );
```


### DROP
`DROP DATABASE adatbázisnév;`

### ALTER
```sql
ALTER DATABASE adatbázisnév;
```

```sql
ALTER TABLE táblanév
      [ADD (újmező-leírás1[, újmező-leírás2[, ...]])]
      [MODIFY (mezőváltozás1[, mezőváltozás2[, ...]])]
      [DROP (mező1[, mező2[, ...]])];
```


### TRUNCATE

### Primary Key

```sql
FOREIGN KEY(UserID) REFERENCES Users(UserID) ON DELETE CASCADE
```
A Users táblából törölhetők lesznek olyan felhasználók, akiknek van bejegyzése a Posts táblában, de ekkor a hozzá kapcsolódó posztok is törlődnek.
```sql
FOREIGN KEY(UserID) REFERENCES Users(UserID) ON DELETE SET NULL
```
A Users táblából törölhetők lesznek olyan felhasználók, akiknek van bejegyzése a Posts táblában, de ekkor a hozzá kapcsolódó posztoknál az idegen kulcs értéke NULL lesz. (Így a posztokat ki tudjuk írni, és a szerző helyett megjeleníthetjük pl. a Törölt szerző szöveget.)

### Indexing
```sql
CREATE [UNIQUE] INDEX indexnév ON táblanév(oszloplista);

CREATE INDEX idx_ename ON Employees(Name);
CREATE INDEX idx_namedep ON Employees(Name, DepartmentID);
```

### Views
```sql
CREATE VIEW nézettáblanév [(oszlopnévlista)] AS SELECT alkérdés;
```

```sql
    CREATE VIEW PostList AS
      SELECT Username, Date, Post
      FROM users u, posts p
      WHERE u.UserID = p.UserID 
      ORDER BY Date DESC;
```

## DML - Data Manipulation Language

### INSERT
```sql
INSERT INTO táblanév [(oszloplista)] VALUES (értéklista);
```

```sql
INSERT INTO táblanév [(oszloplista)] SELECT alkérdés;
```


### UPDATE
```sql
    UPDATE táblanév
      SET mezőnév = kifejezés[, ... , mezőnév = kifejezés]
      [WHERE feltétel];
```

### DELETE
```sql
DELETE FROM táblanév [WHERE feltétel];
```

## TCL - Transaction Control Language

### COMMIT
```sql

```

### SAVEPOINT
```sql

```

### ROLLBACK
```sql

```

## DQL - Data Query Language

### SELECT
```sql
    SELECT [DISTINCT] * | mezőlista | kifejezések
      FROM táblanév
      [WHERE feltétel]
      [ORDER BY rendezés];
```

```sql
    SELECT Name, Population
      FROM country
      WHERE Continent = 'Europe'
      ORDER BY Name;
```

```sql
    SELECT Name, Population
      FROM country
      WHERE Continent = 'Europe'
        AND Population <= 10000000
        AND (Name LIKE 'F%' OR Name LIKE '%a')
      ORDER BY Population DESC;
```

### Descartes multiplication
```sql
    SELECT *
      FROM country, city;
```
Ha a SELECT parancs FROM záradákában két tábla nevét vesszővel elválasztva soroljuk fel, akkor a két tábla Descartes-szorzatát állítjuk elő. A Descartes-szorzatban 

- az egyik tábla minden rekordját párba állítjuk a másik tábla minden rekordjával (az új tábla sorainak száma a két tábla sorai számának szorzata lesz),
- az első tábla mezői után a másik tábla mezői kerülnek (természetesen a SELECT szó mellett korlátozhatjuk a megjelenő mezőit), a SELECT * használata esetén tehát a mezők száma összeadódik,
- ha a két táblában van azonos nevű mező, akkor táblanév.mezőnév formát kötelező használni (bármely záradékban említjük is a mező nevét).

### Natural Join 
A két mező egyenlőségét a WHERE záradékban írhatjuk elő:
```sql
    SELECT *
      FROM country, city
      WHERE country.Code = city.CountryCode;
```
Mivel Code nevű mező a két tábla közül csak a country táblában van, CountryCode pedig csak a city táblában, ezért nem lenne szükséges a táblanevek kiírása a WHERE záradékban.

Ha a feladatban nem az összes mezőt szeretnénk megjeleníteni, csak az ország nevét és a város nevét, akkor Name mezők elé (mivel mindkét táblában szerepel ilyen nevű mező) ki kell írni a táblanevet is.
```sql
    SELECT country.Name, city.Name
      FROM country, city
      WHERE Code = CountryCode;
```

### INNER JOIN
```sql
... FROM tábla1 INNER JOIN tábla2 ON [tábla1.]mező1 = [tábla2.]mező2 ...
```

Kettőnél több tábla összekapcsolása esetén először két (tartalmilag kapcsolódó) tábla JOIN műveletét végezzük el zárójelben, majd ehhez a zárójelhez - mint ideiglenes táblához - kapcsoljuk JOIN művelettel a következő táblát. Ha további tábla összekapcsolására is szükség van, akkor az eddigieket ismét zárójelbe tesszük, és ehhez JOIN-oljuk az újabb táblát.
```sql
    SELECT country.Name, city.Name, Language
      FROM (country INNER JOIN city ON Code = city.CountryCode)
        INNER JOIN countrylanguage ON Code = countrylanguage.CountryCode
      WHERE country.Name LIKE 'Al%' AND IsOfficial = 'T';
```

### LEFT JOIN
```sql
... FROM tábla1 LEFT JOIN tábla2 ON [tábla1.]mező1 = [tábla2.]mező2 ...
```
Az összekapcsolás minden rekordot tartalmaz, amit az INNER JOIN, de emellett a tábla1 tábla azon rekordjait is, amelyekhez a tábla2-ben nincs kapcsolódó rekord (RIGHT JOIN esetén a tábla2 olyan rekordjait, amelyhez a tábla1-ben nincs kapcsolódó rekord), az tábla2 mezői ilyenkor NULL értékkel jelennek meg.

### Aliases
```sql
    SELECT Name AS CountryName, Population / SurfaceArea AS PopDensity
      FROM country;
```
```sql
    SELECT ci.Name CityName, co.Name CountryName
      FROM country co INNER JOIN city ci ON co.Code = ci.CountryCode
      WHERE ci.Name LIKE 'B%'
      ORDER BY ci.Name, co.Name;
```

```sql
    SELECT c1.Name, c1.CountryCode, c2.CountryCode
      FROM city c1, city c2
      WHERE c1.Name = c2.Name
        AND c1.CountryCode < c2.CountryCode
      ORDER BY c1.Name;
```

### Grouping and aggregation

- AVG
- SUM
- COUNT
- MIN
- MAX
```sql
    SELECT COUNT(Code)
      FROM country
      GROUP BY Continent;
```

```sql
    SELECT Continent, COUNT(DISTINCT Name) AS CountOfCountries
      FROM country INNER JOIN countrylanguage ON Code = CountryCode
      WHERE Language IN ('English', 'Spanish') AND IsOfficial = 'T'
      GROUP BY Continent;
```


### Query execution order

```sql
SELECT department_name, employee_count
    FROM employees E
    JOIN departments D ON E.department_id = D.id
    WHERE E.salary > 50000
    GROUP BY D.id
    HAVING COUNT(E.id) > 5
    ORDER BY employee_count DESC
    LIMIT 10 OFFSET 5;   
```

## DCL - Data Control Language

### GRANT
```sql

```

### REVOKE
```sql

```
## Stored procedures
```sql
  CREATE PROCEDURE CountryPop(IN Con VARCHAR(30) CHARSET utf8, IN n INT) ... 
  BEGIN
    SELECT Name, Population
    FROM county
    WHERE Continent = Con
    ORDER BY Population DESC
    LIMIT n;
  END;
```

```sql
    BEGIN 
      SET @langcnt := 0;
      SELECT COUNT(*) INTO @langcnt
        FROM country INNER JOIN countrylanguage ON Code = CountryCode
        WHERE IsOfficial = 'T' AND Code = Cod;
      RETURN @langcnt;
    END;
```

## Triggers
```sql
    CREATE TRIGGER triggernév
      trigger_time trigger_event ON táblanév|nézetnév
      FOR EACH ROW
      [additional_parameters]
      trigger_body
```
- A trigger_time azt határozza meg, hogy a triggerindító eseményhez képes mikor fusson le a trigger, értéke BEFORE | AFTER | INSTEAD OF (előtte, utána, helyette - az utóbbit nem minden DBMS valósítja meg, a nézettábla-műveletek helyett lefutó triggert definiál.
- A trigger_event az eseményt (műveletet) határozza meg, a leggyakrabban használt, DML-triggerek esetén DELETE | UPDATE | INSERT.
- A táblanév paraméter adja meg, hogy melyik tábla eseményére induljon el a trigger (nézettábla csak akkor lehetséges, ha az INSTEAD OF típusú triggerek is léteznek).
- Ha a FOR EACH ROW kulcskifejezés szerepel, akkor ún. sorszintű triggert hozunk létre, amelynek törzse minden olyan rekordra lefut, amelyet a triggerindító esemény érintett (pl. egy UPDATE parancs esetén minden megváltozott rekordra), így tehát lehetséges, hogy a törsz egyszer sem fut le.
- Ha a FOR EACH ROW nem szerepel, akkor ún. utasításszintű trigger hozunk létre, amelynek törzse pontosan egyszer fut le (függetlenül az érintett rekordok számától).
- A további paraméterek nyelvjárástól függően sokfélék lehetnek (pl. meghatározhatják, hogy más triggerhez képest mikor fusson le a definiált trigger, vagy tovább szűkíthetik, hogy a sorszintű trigger csak milyen feltételeket teljesítő rekordokra fusson le).


## Data modeling





