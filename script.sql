CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT
);

INSERT INTO employees (id, name, salary) VALUES
(1, 'Alice', 400),
(2, 'Bob', 400),
(3, 'Charlie', 300),
(4, 'David', 200),
(5, 'Eva', 100);

-- Q1 find avg salary
SELECT avg(salary)
from employees;

SELECT name, salary from employees where salary > (SELECT avg(salary)
from employees);

-- Q2
-- Find departments with more than 5 employees.
select department_id, count(*) as employee_count
from employees group by department_id HAVING count(*) > 5;

-- Q3
SELECT name, salary, avg(salary) over(PARTITION by department_id) as department_avg_salary
from employees;

-- Q4
select distinct salary
from employees order by salary desc offset 1 limit 1;

select max(salary)
from employees where salary < (SELECT max(salary) from employees);
employees

select salary from (
SELECT salary, DENSE_RANK() over(order by salary desc) as ranking
from employees) rank where ranking = 2;

CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Insert customers
INSERT INTO customers (id, name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David'),
(5, 'Eva');

-- Insert orders
INSERT INTO orders (id, customer_id) VALUES
(1, 1),
(2, 1),
(3, 3),
(4, 5);

-- Q5 Find customers who never placed an order.
SELECT DISTINCT customer_id
from orders;

-- use sub query
select *
from customers where id not in (
	SELECT DISTINCT customer_id
from orders
);

-- use join
SELECT c.id, c.name
from customers c left join orders o on c.id = o.customer_id where o.customer_id is null;

select now();
select CURRENT_DATE;
select * from orders where created_at >= now() - interval('7 days');
select date_trunc('month', now());
SELECT EXTRACT(YEAR from now())

-- current month: where date_trunc('month', created_at) = date_trunc('month', now())

SELECT DATE_TRUNC('month', created_at),
       COUNT(*)
FROM orders
GROUP BY DATE_TRUNC('month', created_at);

