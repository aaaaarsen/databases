-- 1
CREATE DATABASE lab4;
-- 2
CREATE TABLE warehouse(
    code SERIAL PRIMARY KEY ,
    location VARCHAR(255),
    capacity INT
);
CREATE TABLE boxes(
    code CHAR(4),
    contents VARCHAR(255),
    value INT,
    warehouse INT
);
--3
INSERT INTO warehouse(location, capacity)
VALUES('Chicago', 3),
      ('Chicago', 4),
      ('New_York', 7),
      ('Los_Angeles', 2),
      ('San_Francisco', 8);


INSERT INTO boxes(code, contents, value, warehouse)
VALUES ('0MN7', 'Rocks', 180, 3),
       ('4N8P', 'Rocks', 250,1),
       ('4RT3', 'Scissors', 190, 4),
       ('7G3H', 'Rocks', 200,1),
       ('8JN6', 'Papers',75,1),
       ('8Y6U', 'Papers', 50,3),
       ('9J6F', 'Papers',175,2),
       ('LL08', 'Rocks', 140,4),
       ('P0H6', 'Scissors', 125,1),
       ('P2T6', 'Scissors', 150,2),
       ('TU55', 'Papers', 90,5);

-- 4
SELECT * FROM warehouse;
-- 5
SELECT * FROM boxes WHERE value>150;
-- 6
SELECT DISTINCT contents FROM boxes;
-- 7
SELECT warehouse, COUNT(code) AS number_of_boxes FROM boxes GROUP BY warehouse;
-- 8
SELECT warehouse, COUNT(code) AS number_of_boxes FROM boxes WHERE warehouse>2 GROUP BY warehouse;
-- 9
INSERT INTO warehouse(location, capacity)
VALUES ('New_York', 3);
-- 10
INSERT INTO boxes(code, contents, value, warehouse)
VALUES ('H5RT', 'Papers', 200,2);
-- 11
UPDATE boxes SET value = value*0.75 WHERE warehouse = (SELECT warehouse FROM boxes ORDER BY warehouse DESC LIMIT 1 OFFSET 2);
SELECT * FROM boxes ORDER BY warehouse DESC ;
-- 12
DELETE FROM boxes WHERE value<150;
-- 13
DELETE FROM boxes WHERE warehouse = 3 RETURNING *;


