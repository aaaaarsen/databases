CREATE DATABASE lab1;

CREATE TABLE users(
    id INT PRIMARY KEY ,
    firstname VARCHAR(50),
    lastname VARCHAR(50)
);

ALTER TABLE users
ADD is_admin INT;

ALTER TABLE users
ALTER COLUMN is_admin TYPE BOOLEAN
USING is_admin::boolean;

ALTER TABLE users
ALTER COLUMN is_admin SET DEFAULT FALSE;

CREATE TABLE tasks(
    id SERIAL,
    name VARCHAR(50),
    user_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE tasks;

\c postgres;

DROP DATABASE "lab1";