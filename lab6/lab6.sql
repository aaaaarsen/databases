--Task1
CREATE DATABASE lab6;
--Task2
CREATE TABLE locations(
    location_id SERIAL PRIMARY KEY ,
    street_address VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(50),
    state_province VARCHAR(12)
);
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY ,
    department_name VARCHAR(50) UNIQUE ,
    budget INTEGER,
    location_id INTEGER REFERENCES locations
);
CREATE TABLE employees(
    employee_id SERIAL PRIMARY KEY ,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    salary INTEGER,
    department_id INTEGER REFERENCES departments
);
INSERT INTO locations (street_address, postal_code, city, state_province) VALUES
('Tole Bi 59', '12345', 'Almaty', 'AL'),
('Islama K 71', '67890', 'Almaty', 'Al'),
('789', '11223', 'Moskow', 'MK');
INSERT INTO departments (department_name, budget, location_id) VALUES
('HR', 50000, 1),
('Finance', 200000, 2),
('Marketing', 75000, 3);
INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id) VALUES
('Arsen', 'Raiymbek', 'arsen@example.com', '555-1234', 60000, 1),
('Anara', 'Armankyzy', 'anara@example.com', '555-5678', 75000, 2),
('Bekzhan', 'Raiymbek', 'beka@example.com', '555-6789', 50000, 3); -- Employee without department






-- Task 3
SELECT employees.first_name, employees.last_name, employees.department_id, departments.department_id
FROM employees
JOIN departments on employees.department_id = departments.department_id;

--Task 4
SELECT employees.first_name, employees.last_name, employees.department_id, departments.department_id
FROM employees
JOIN departments on employees.department_id = departments.department_id
WHERE employees.department_id IN(1,3);

--Task 5
SELECT employees.first_name, employees.last_name, employees.department_id,departments.department_name, locations.city, locations.state_province
FROM employees
JOIN departments on employees.department_id = departments.department_id
JOIN locations on departments.location_id = locations.location_id;

--Task 6
SELECT departments.department_id, departments.department_name, employees.first_name, employees.last_name FROM departments
LEFT JOIN employees  on departments.department_id = employees.department_id;


--Task 7
SELECT employees.first_name, employees.last_name, departments.department_id, departments.department_name FROM employees
LEFT JOIN departments on employees.department_id = departments.department_id;