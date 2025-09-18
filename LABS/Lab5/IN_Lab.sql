CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

-- Create Employees table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INT,
    manager_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES Employees(employee_id) -- Self-referencing for managers
);

-- Create Projects table
CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100)
);

-- Create Employee-Project Assignment table (many-to-many relationship)
CREATE TABLE Employee_Project_Assignment (
    employee_id INT,
    project_id INT,
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

-- Create Students table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100)
);

-- Create Courses table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100)
);

-- Create Enrollments table (many-to-many relationship between students and courses)
CREATE TABLE Enrollments (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Create Teachers table
CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY,
    teacher_name VARCHAR(100)
);

-- Create Subjects table
CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(100),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);

-- Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);

-- Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Insert data into Departments
INSERT INTO Departments (department_id, department_name) VALUES (1, 'HR');
INSERT INTO Departments (department_id, department_name) VALUES (2, 'IT');
INSERT INTO Departments (department_id, department_name) VALUES (3, 'Finance');
INSERT INTO Departments (department_id, department_name) VALUES (4, 'Marketing');

-- Insert data into Employees
INSERT INTO Employees (employee_id, employee_name, department_id, manager_id) VALUES (1, 'Alice', 1, NULL);
INSERT INTO Employees (employee_id, employee_name, department_id, manager_id) VALUES (2, 'Bob', 2, 1);
INSERT INTO Employees (employee_id, employee_name, department_id, manager_id) VALUES (3, 'Charlie', 3, 1);
INSERT INTO Employees (employee_id, employee_name, department_id, manager_id) VALUES (4, 'David', 2, 2);
INSERT INTO Employees (employee_id, employee_name, department_id, manager_id) VALUES (5, 'Eve', 4, 1);

-- Insert data into Projects
INSERT INTO Projects (project_id, project_name) VALUES (1, 'Project X');
INSERT INTO Projects (project_id, project_name) VALUES (2, 'Project Y');
INSERT INTO Projects (project_id, project_name) VALUES (3, 'Project Z');

-- Insert data into Employee_Project_Assignment
INSERT INTO Employee_Project_Assignment (employee_id, project_id) VALUES (1, 1);
INSERT INTO Employee_Project_Assignment (employee_id, project_id) VALUES (2, 2);
INSERT INTO Employee_Project_Assignment (employee_id, project_id) VALUES (3, 3);
INSERT INTO Employee_Project_Assignment (employee_id, project_id) VALUES (4, 1);

-- Insert data into Students
INSERT INTO Students (student_id, student_name) VALUES (1, 'John');
INSERT INTO Students (student_id, student_name) VALUES (2, 'Jane');
INSERT INTO Students (student_id, student_name) VALUES (3, 'Mark');
INSERT INTO Students (student_id, student_name) VALUES (4, 'Sarah');

-- Insert data into Courses
INSERT INTO Courses (course_id, course_name) VALUES (1, 'Database Systems');
INSERT INTO Courses (course_id, course_name) VALUES (2, 'Operating Systems');
INSERT INTO Courses (course_id, course_name) VALUES (3, 'Machine Learning');

-- Insert data into Enrollments
INSERT INTO Enrollments (student_id, course_id) VALUES (1, 1);
INSERT INTO Enrollments (student_id, course_id) VALUES (1, 2);
INSERT INTO Enrollments (student_id, course_id) VALUES (2, 3);
INSERT INTO Enrollments (student_id, course_id) VALUES (3, 1);
INSERT INTO Enrollments (student_id, course_id) VALUES (4, 2);

-- Insert data into Teachers
INSERT INTO Teachers (teacher_id, teacher_name) VALUES (1, 'Prof. Smith');
INSERT INTO Teachers (teacher_id, teacher_name) VALUES (2, 'Prof. Johnson');
INSERT INTO Teachers (teacher_id, teacher_name) VALUES (3, 'Prof. Lee');

-- Insert data into Subjects
INSERT INTO Subjects (subject_id, subject_name, teacher_id) VALUES (1, 'Databases', 1);
INSERT INTO Subjects (subject_id, subject_name, teacher_id) VALUES (2, 'OS Fundamentals', 2);
INSERT INTO Subjects (subject_id, subject_name, teacher_id) VALUES (3, 'ML Basics', 3);

-- Insert data into Customers
INSERT INTO Customers (customer_id, customer_name) VALUES (1, 'Acme Corp');
INSERT INTO Customers (customer_id, customer_name) VALUES (2, 'Tech Innovations');
INSERT INTO Customers (customer_id, customer_name) VALUES (3, 'Green Farms');

-- Insert data into Orders
INSERT INTO Orders (order_id, customer_id, order_date) VALUES (1, 1, TO_DATE('2025-09-10', 'YYYY-MM-DD'));
INSERT INTO Orders (order_id, customer_id, order_date) VALUES (2, 2, TO_DATE('2025-09-12', 'YYYY-MM-DD'));
INSERT INTO Orders (order_id, customer_id, order_date) VALUES (3, 1, TO_DATE('2025-09-15', 'YYYY-MM-DD'));

-- IN LAB
select * from employees;
select * from departments;
--select * from employees;

-- Q1
select e.employee_name, d.department_name from employees e cross join departments d;
-- Q2
select e.employee_name, d.department_name from employees e right join departments d on e.department_id = d.department_id;
-- Q3
select e.employee_name,d.employee_name from employees e inner join employees d on e.manager_id = d.employee_id;
-- Q4
select e.employee_name from EMPLOYEES e left join EMPLOYEE_PROJECT_ASSIGNMENT epa on e.EMPLOYEE_ID = epa.EMPLOYEE_ID where epa.employee_id IS NULL;
-- Q5
select s.student_name,co.COURSE_NAME from students s inner join ENROLLMENTS e on s.STUDENT_ID = e.STUDENT_ID inner join COURSES co 
on e.COURSE_ID = co.COURSE_ID;
-- Q6
select cu.customer_name,o.order_id from CUSTOMERS cu left join Orders o on cu.CUSTOMER_ID = o.CUSTOMER_ID;
-- Q7
select e.employee_name, d.department_name from employees e right join departments d on e.department_id = d.department_id;
-- Q8
select t.*,s.* from Teachers t cross join Subjects s;
-- Q9
select d.department_name,COUNT(e.employee_id) from Departments d inner join Employees e on d.department_id = e.department_id group by d.Department_name;
-- Q10
select s.student_name,sub.subject_name,t.teacher_name from students s inner join enrollments e on s.STUDENT_ID = e.STUDENT_ID
inner join subjects sub on e.COURSE_ID = sub.SUBJECT_ID inner join Teachers t on sub.TEACHER_ID = t.TEACHER_ID;
