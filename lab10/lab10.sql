CREATE DATABASE lab10;

--Tables:
--1
CREATE TABLE Books(
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INTEGER NOT NULL
);
--2
CREATE TABLE Customers2(
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(255) not null,
    email varchar(255) not null
);
--3
CREATE TABLE Orders2(
    order_id serial primary key,
    book_id integer not null,
    customer_id integer not null,
    order_date date not null,
    quantity integer not null,
    foreign key (book_id) references books (book_id),
    foreign key (customer_id) references Customers2(customer_id)
);


--Sample Data

INSERT INTO Books(book_id, title, author, price, quantity)
VALUES
(1, 'Database 101', 'A.Smith', 40.00, 10),
(2, 'Learn SQL', 'B. Johnson', 35.00, 15),
(3, 'Advanced DB', 'C. Lee', 50.00, 5);

INSERT INTO Customers2(customer_id, name, email)
VALUES (101, 'John Doe', 'johndoe@example.com'),
       (102, 'Jane Doe', 'janedoe@example.com');

--task 1
BEGIN;
INSERT INTO Orders2(book_id, customer_id, order_date, quantity)
VALUES (1, 101, CURRENT_DATE, 2);
UPDATE Books SET quantity = quantity - 2 WHERE book_id = 1;
COMMIT;

--task 2
DO $$
BEGIN
    IF(SELECT quantity FROM Books WHERE book_id = 3) < 10 THEN
        RAISE NOTICE 'Incomplete quantity for book_id 3';
        ROLLBACK;
    ELSE
        INSERT INTO Orders2(order_id, book_id, customer_id, order_date, quantity)
        VALUES (2, 3, 102, current_date, 10);

        UPDATE Books SET quantity = quantity- 10 WHERE book_id = 3;
        COMMIT;
    END IF;
END $$;
SELECT * FROM Books;
SELECT * FROM orders;

-- task 3

--session one
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
UPDATE Books SET price = 38.00 WHERE book_id = 2;
COMMIT ;

--session two
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT price FROM Books WHERE book_id = 2;

SELECT price FROM Books WHERE book_id = 2;

COMMIT;

-- task 4

BEGIN;
UPDATE Customers2 SET email = 'johndoe123@kbtu.kz' WHERE customer_id = 101;
COMMIT;

SELECT * FROM Customers2 WHERE customer_id = 101;