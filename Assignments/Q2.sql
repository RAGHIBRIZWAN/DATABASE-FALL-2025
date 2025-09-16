--ASSIGNMENT 1
-- Q2
-- 1
create table Members(
    MemberID int primary key,
    Name varchar(30) NOT NULL,
    Email varchar(30) UNIQUE NOT NULL,
    JoinDate DATE default CURRENT_DATE,
    constraint chk_email check (Email like '%@gmail.com')
);

create table Books(
    BookID int primary key,
    Title varchar(30) UNIQUE NOT NULL,
    AUTHOR varchar(30) NOT NULL,
    CopiesAvailable int NOT NULL,
    constraint chk_copies check (CopiesAvailable >= 0)
);

create table IssuedBooks(
    IssueID int primary key,
    MemberID int NOT NULL,
    BookID int NOT NULL,
    IssueDate DATE default CURRENT_DATE,
    ReturnDate DATE,
    constraint fk_member foreign key(MemberID) REFERENCES Members(MemberID),
    constraint fk_book foreign key(BookID) REFERENCES Books(BookID),
    constraint chk_return check (ReturnDate >= IssueDate)
);

-- 3 a
insert into members values(1,'Raghib','raghib@gmail.com',TO_DATE('2005,06,30','YYYY,MM,DD'));
insert into members values(2,'Fahad','fahad@gmail.com',TO_DATE('2008,08,14','YYYY,MM,DD'));
insert into members values(3,'Umar','umar@gmail.com',TO_DATE('2010,05,2','YYYY,MM,DD'));
insert into members values(4,'Talha','talha@gmail.com',TO_DATE('2012,01,28','YYYY,MM,DD'));
select * from members;

insert into books values(101,'Harry Potter','ABC',5);
insert into books values(102,'John Wick','DEF',8);
insert into books values(103,'Knight And Day','GHI',2);
insert into books values(104,'Pursuit Of Happiness','JKL',10);
select * from books;

-- 3 b
INSERT INTO IssuedBooks (IssueID, MemberID, BookID) VALUES (1001, 1, 101);

update Books set CopiesAvailable = CopiesAvailable - 1 where BookID = 101;

INSERT INTO IssuedBooks (IssueID, MemberID, BookID) VALUES (1002, 2, 103);

update Books set CopiesAvailable = CopiesAvailable - 1 where BookID = 103;

INSERT INTO IssuedBooks (IssueID, MemberID, BookID) VALUES (1003, 1, 102);

update Books set CopiesAvailable = CopiesAvailable - 1 where BookID = 102;

INSERT INTO IssuedBooks (IssueID, MemberID, BookID, ReturnDate) VALUES (1004, 3, 103,TO_DATE('2025,10,5','YYYY,MM,DD'));

update Books set CopiesAvailable = CopiesAvailable - 1 where BookID = 103;

-- 3 c
select m.Name, b.Title from Members m inner join IssuedBooks i on m.MemberID = i.MemberID inner join Books b on i.BookID = b.BookID;

-- 4
-- a. Key Constraint Violation - Duplicate MemberID
insert into members values(1,'Duplicate 1','Duplicate1@gmail.com',TO_DATE('2025,09,17','YYYY,MM,DD'));

-- b. Referential Integrity Violation - Non-existent MemberID
insert into IssuedBooks (IssueID, MemberID, BookID) VALUES (1005, 100, 101);

-- c. Check Constraint Violation - Negative CopiesAvailable
update Books set CopiesAvailable = -2 where BookID = 101;

-- 6
-- a
select * from members where MemberID NOT IN(select MemberID from IssuedBooks i where i.IssueDate is NOT NULL);

-- b
select Title from Books where CopiesAvailable = (select MAX(CopiesAvailable) from Books);

-- c
select m.Name from Members m inner join IssuedBooks i on m.MemberID = i.MemberID Group By m.Name,i.MemberID having
COUNT(i.MemberID) = (select MAX(Count(MemberID)) from IssuedBooks group by memberID);

-- d
select Title from Books where BookID NOT IN(select BookID from IssuedBooks where BookID is NOT NULL);

-- e
select m.Name from Members m inner join IssuedBooks i on m.MemberID = i.MemberID where i.ReturnDate is NULL and i.IssueDate < (CURRENT_DATE - 30);
