# SQL


### Practice 1 - Create database
some description

```sql
CREATE DATABASE db01;
-- CREATE SCHEMA and CREATE DATABASE are synonyms in MySQL,
-- but for example in Oracle BD schema can be used to represent a part of the database.
```
It can be useful to use a `REPLACE` statement before creating the database:
```sql
DROP DATABASE IF EXISTS db_name;
CREATE DATABASE db_name ...;
```

While creating the database we can add additional specifications like `CHARACTER SET` and `COLLATE`, if these are left out, the server defaults are used.:
```sql
CREATE DATABASE czech_names 
  CHARACTER SET = 'keybcs2'
  COLLATE = 'keybcs2_bin';
```
or add a `COMMENT` value to describe the database in detail:
```sql
CREATE DATABASE hungarian_names
    COMMENT 'List all officially usable names in Hungary';
```

# Előadás 2025-10-11
Papp-Szigeti 
- Check moodle - ide lesznek feltéve az anyagok
- Gyakorlat 60 pont / min 35 pontot kell elérni
- Elméleti 40 pont / min 15 pontot kell elérni
- Moodle-el 5 pontot lehet pluszban elérni
- Komm: Teams-en keresztül

XAMP alkalmazás használata (Apache)
MySql server (de valójában MariaDB)
- relációs adatbázis
- hierarchikus adatbázis (file rendszer : NTFS; FAT; ...)

Knightlab / SQL Murder Mystery - egy SQL syntax alapú játék

## Tananyag
### Adatmodellezés
- UML diagram
- AFD - adatfolyam diagram
- ERD - entity relationship diagram

Logikai adatbázis-terv
Fizikai terv

Adatbázis optimalizálás

