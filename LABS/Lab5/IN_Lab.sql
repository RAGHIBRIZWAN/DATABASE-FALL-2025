-- IN LAB
select * from employees;
select * from departments;

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
