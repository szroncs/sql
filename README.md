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