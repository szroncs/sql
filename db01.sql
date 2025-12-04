CREATE DATABASE db01;
-- CREATE SCHEMA and CREATE DATABASE are synonyms in MySQL,
-- but for example in Oracle BD schema can be used to represent a part of the database.

USE db01;

CREATE TABLE users (
    Userid INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(20) NOT NULL,
    Password TEXT NOT NULL,
    Name VARCHAR(100),
    LastLogin DATETIME,
    ClassID VARCHAR(3),
    Email VARCHAR(100) NOT NULL
);

INSERT INTO
    users (
        Username,
        Password,
        Name,
        LastLogin,
        ClassID,
        Email
    )
VALUES (
        '',
        'test.elek',
        'Káposzta',
        'Teszt Elek',
        '2025-09-04',
        '106'
    ),
    (
        '',
        'krokod.ilus',
        'Valami',
        'Krokod Ilus',
        '2025-09-06',
        '107'
    );

SELECT user FROM mysql.user;