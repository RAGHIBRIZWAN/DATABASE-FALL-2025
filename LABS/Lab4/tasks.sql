CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(100) NOT NULL
);

CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(100) NOT NULL,
    Dept_ID INT,
    GPA DECIMAL(3,2),
    Fee_Paid DECIMAL(12,2),
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);

CREATE TABLE Course (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(100) NOT NULL,
    Dept_ID INT,
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);

CREATE TABLE Enrollment (
    Student_ID INT,
    Course_ID INT,
    PRIMARY KEY (Student_ID, Course_ID),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

CREATE TABLE Faculty (
    Faculty_ID INT PRIMARY KEY,
    Faculty_Name VARCHAR(100) NOT NULL,
    Dept_ID INT,
    Salary DECIMAL(12,2),
    Joining_Date DATE,
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);

CREATE TABLE FacultyCourse (
    Faculty_ID INT,
    Course_ID INT,
    PRIMARY KEY (Faculty_ID, Course_ID),
    FOREIGN KEY (Faculty_ID) REFERENCES Faculty(Faculty_ID),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

CREATE TABLE HighFee_Students (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(100),
    Dept_ID INT,
    GPA DECIMAL(3,2),
    Fee_Paid DECIMAL(12,2)
);

CREATE TABLE Retired_Faculty (
    Faculty_ID INT PRIMARY KEY,
    Faculty_Name VARCHAR(100),
    Dept_ID INT,
    Salary DECIMAL(12,2),
    Joining_Date DATE
);

CREATE TABLE Unassigned_Faculty (
    Faculty_ID INT PRIMARY KEY,
    Faculty_Name VARCHAR(100),
    Dept_ID INT,
    Salary DECIMAL(12,2),
    Joining_Date DATE
);

INSERT INTO Department (Dept_ID, Dept_Name) VALUES(4, 'BBA');

INSERT INTO Student (Student_ID, Student_Name, Dept_ID, GPA, Fee_Paid) VALUES
(109, 'Omar', 4, 3.30, 550000);

INSERT INTO Course (Course_ID, Course_Name, Dept_ID) VALUES
(206, 'Data Science', 1);

INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (101, 201);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (101, 202);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (101, 206);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (101, 203);

INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (102, 201);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (102, 206);

INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (103, 203);

INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (104, 204);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (104, 202);

INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (105, 201);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (105, 202);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (105, 206);

INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (106, 205);

INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (107, 203);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (107, 201);

INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (108, 204);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (108, 206);

INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (109, 205);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (109, 206);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (109, 201);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (109, 202);

DELETE FROM Faculty where Faculty_ID IN(301,302,303,304,305,306,307);

INSERT INTO Faculty (Faculty_ID, Faculty_Name, Dept_ID, Salary, Joining_Date)
VALUES (307, 'Dr. Asif', 3, 85000, TO_DATE('2013-08-22','YYYY-MM-DD'));

INSERT INTO FacultyCourse (Faculty_ID, Course_ID) VALUES (301, 201);  -- Dr. Ahsan teaches Database Systems
INSERT INTO FacultyCourse (Faculty_ID, Course_ID) VALUES (301, 206);  -- Dr. Ahsan teaches Data Science
INSERT INTO FacultyCourse (Faculty_ID, Course_ID) VALUES (303, 203);  -- Dr. Imran teaches Networking
INSERT INTO FacultyCourse (Faculty_ID, Course_ID) VALUES (304, 204);  -- Dr. Kamran teaches Circuit Analysis
INSERT INTO FacultyCourse (Faculty_ID, Course_ID) VALUES (305, 205);  -- Prof. Amna teaches Business Management

select * from facultyCourse;

select * from faculty;

-- IN LAB
-- Q1
select d.dept_id,d.dept_name,(select count(*) from student s where s.dept_id = d.dept_id) as Student_Count from department d;
-- Q2
select d.dept_name from department d inner join student s on d.DEPT_ID = s.DEPT_ID group by d.dept_name HAVING AVG(s.GPA) >= 3.0;
-- Q3
select co.Course_Name,AVG(s.Fee_Paid) as avg_fees from Course co inner join enrollment e on co.course_id = e.course_id
inner join Student s ON e.Student_ID = s.Student_ID group by co.COURSE_NAME;
-- Q4
select d.Dept_id,d.Dept_name,(select count(*) from faculty s where s.dept_id = d.dept_id) as Student_Count from department d;
-- Q5
select faculty_name from faculty where salary > (select AVG(salary) from faculty);
-- Q6
select * from student;
select Student_Name,GPA from student where GPA > ANY(select GPA from student s inner join department d on d.dept_id = s.dept_id where d.dept_name = 'CS');
-- Q7
select * from (select * from student ORDER BY GPA DESC) where ROWNUM <= 5;
-- Q8
SELECT DISTINCT s.Student_ID, s.Student_Name
FROM Student s
WHERE s.Student_Name != 'Ali'
  AND NOT EXISTS (
    SELECT e1.Course_ID
    FROM Enrollment e1
    INNER JOIN Student s1 ON e1.Student_ID = s1.Student_ID
    WHERE s1.Student_Name = 'Ali'
    
    MINUS
    
    SELECT e2.Course_ID
    FROM Enrollment e2
    WHERE e2.Student_ID = s.Student_ID
  ); -- Can't Understand it. So done it by ChatGPT.
-- Q9
select d.Dept_name,(select SUM(s.FEE_PAID) from student s where s.Dept_id = d.Dept_id) from Department;
-- Q10
select distinct co.course_name from course co inner join student s on co.dept_id = s.dept_id where s.gpa>3.5;

-- POST LAB
-- Q11
select d.dept_name,SUM(s.fee_paid) from department d inner join student s on d.dept_id = s.dept_id group by d.dept_name having SUM(FEE_PAID) > 1000000;
-- Q12
select d.Dept_Name from Department d inner join Faculty f on d.Dept_ID = f.Dept_ID where f.Salary > 100000
group by d.Dept_Name having count(f.Faculty_ID) > 5;
-- Q13
select AVG(GPA) from student;
delete from Student where GPA < ALL(select AVG(GPA) from Student);
-- Q14
DELETE FROM course WHERE course_id NOT IN (SELECT DISTINCT e.course_id FROM enrollment e WHERE e.course_id IS NOT NULL);
-- Q15
insert into HighFee_Students (Student_ID, Student_Name, Dept_ID, GPA, Fee_Paid) select Student_ID, Student_Name, Dept_ID, GPA, Fee_Paid 
from Student where Fee_Paid > (select AVG(Fee_Paid) from Student);
--Q16
select * from faculty;
insert into Retired_Faculty (Faculty_ID, Faculty_Name, Dept_ID, Salary, Joining_Date) select Faculty_ID, Faculty_Name, Dept_ID, Salary, Joining_Date
from Faculty where Joining_Date < TO_DATE('2010,01,01','YYYY,MM,DD');
-- Q17
select dept_name from (select d.dept_name from department d inner join student s on d.dept_id = s.dept_id group by d.dept_name order by SUM(s.fee_paid) DESC) 
where ROWNUM <= 1; 
-- Q18
select course_name from (select co.course_name from course co inner join enrollment e on co.COURSE_ID = e.COURSE_ID group by co.course_name
order by count(e.student_id) desc) where ROWNUM <= 3;
-- Q19
select * from student;
select * from enrollment;
select s.student_name from student s inner join enrollment e on s.student_id = e.student_id group by s.student_name,s.gpa having count(e.course_id) > 3
and s.gpa > (select AVG(GPA) from student);
-- Q20
insert into Unassigned_Faculty (Faculty_ID, Faculty_Name, Dept_ID, Salary, Joining_Date) select f.Faculty_ID, f.Faculty_Name, f.Dept_ID, f.Salary, f.Joining_Date
from Faculty f where f.Faculty_ID NOT IN (select Faculty_ID from Course where Faculty_ID IS NOT NULL);
