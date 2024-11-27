CREATE DATABASE lab9;

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    position VARCHAR(50),
    salary DECIMAL(10, 2)
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

INSERT INTO employees (name, position, salary) VALUES
('Arsen', 'Manager', 70000),
('Beka', 'Developer', 50000),
('Anara', 'Designer', 45000);

INSERT INTO products (name, category, price) VALUES
('Laptop', 'Electronics', 1200.00),
('Headphones', 'Electronics', 150.00),
('Desk', 'Furniture', 200.00),
('Chair', 'Furniture', 100.00);



--1
CREATE OR REPLACE FUNCTION increase_value(param INTEGER)
RETURNS INTEGER AS $$
BEGIN
    RETURN param + 10;
END; $$
LANGUAGE plpgsql;


select increase_value(15);

-- 2.
CREATE OR REPLACE FUNCTION compare_numbers(num1 INTEGER, num2 INTEGER)
RETURNS TEXT AS $$
BEGIN
    IF num1 > num2 THEN
        RETURN 'Greater';
    ELSIF num1 = num2 THEN
        RETURN 'Equal';
    ELSE
        RETURN 'Lesser';
    END IF;
END; $$
LANGUAGE plpgsql;


select compare_numbers(10,5);
select compare_numbers(5,10);

-- 3.
CREATE OR REPLACE FUNCTION number_series(n INTEGER)
RETURNS TEXT AS $$
DECLARE
    result TEXT := '';
    i INTEGER := 1;
BEGIN
    WHILE i <= n LOOP
        result := result || i || ' ';
        i := i + 1;
    END LOOP;
    RETURN result;
END; $$
LANGUAGE plpgsql;

select number_series(7);


-- 4.
CREATE OR REPLACE FUNCTION find_employee(emp_name TEXT)
RETURNS TABLE (id INTEGER, name TEXT, salary NUMERIC) AS $$
BEGIN
    RETURN QUERY SELECT employees.id AS id, employees.name AS name, employees.salary AS salary FROM employees WHERE employees.name = emp_name;
END; $$
LANGUAGE plpgsql;


select * from find_employee('Arsen');
-- 5.
CREATE OR REPLACE FUNCTION list_products(category_name TEXT)
RETURNS TABLE (product_id INTEGER, product_name TEXT, price NUMERIC) AS $$
BEGIN
    RETURN QUERY SELECT id, name, price FROM products WHERE category = category_name;
END; $$
LANGUAGE plpgsql;

-- 6.
CREATE OR REPLACE FUNCTION calculate_bonus(salary NUMERIC)
RETURNS NUMERIC AS $$
BEGIN
    RETURN salary * 0.1;
END; $$
LANGUAGE plpgsql;

select calculate_bonus(50000);

CREATE OR REPLACE FUNCTION update_salary(emp_id INTEGER)
RETURNS VOID AS $$
DECLARE
    current_salary NUMERIC;
    bonus NUMERIC;
BEGIN
    SELECT salary INTO current_salary FROM employees WHERE id = emp_id;
    bonus := calculate_bonus(current_salary);
    UPDATE employees SET salary = salary + bonus WHERE id = emp_id;
END; $$
LANGUAGE plpgsql;

select update_salary(1);

-- 7.
CREATE OR REPLACE FUNCTION complex_calculation(
    num1 INTEGER, num2 INTEGER, str1 TEXT
)
RETURNS TEXT AS $$
DECLARE
    numeric_result INTEGER;
    string_result TEXT;
BEGIN
    numeric_result := num1 * num2;

    string_result := CONCAT('Processed: ', str1);

    RETURN CONCAT(string_result, ', Numeric Result: ', numeric_result);
END; $$
LANGUAGE plpgsql;

select complex_calculation(10,5,'Example');