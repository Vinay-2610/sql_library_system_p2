select * from books;
select * from branch;
select * from employees;
select * from issued_status;
select * from return_status;
select * from members;

--project problems

-- Create a New Book Record  "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;

-- update member_address 
update members
set member_address='123 Main St'
where member_id='C101';

-- delete row from issued_status
DELETE FROM issued_status
WHERE   issued_id =   'IS121';

--Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
SELECT * FROM ISSUED_STATUS
WHERE ISSUED_EMP_ID='101'

--List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.
SELECT
    issued_emp_id,
    COUNT(*)
FROM issued_status
GROUP BY 1
HAVING COUNT(*) > 1

-- CREATE CTAS( CREATE TABLE AS SELECT)
CREATE TABLE book_issued_cnt AS
SELECT b.isbn, b.book_title, COUNT(ist.issued_id) AS issue_count
FROM issued_status as ist
JOIN books as b
ON ist.issued_book_isbn = b.isbn
GROUP BY b.isbn, b.book_title;

--DATA ANALYSIS

-- 1. Count the number of books available in the 'History' category.
SELECT COUNT(*) AS history_books FROM books WHERE category = 'History';

-- 2. List all members who have issued books after '2024-03-20'.
SELECT DISTINCT m.member_name
FROM members m
JOIN issued_status i ON m.member_id = i.issued_member_id
WHERE i.issued_date > '2024-03-20';

-- 3. Show employee details whose salary is above 50,000.
SELECT emp_id, emp_name, position, salary FROM employees WHERE salary > 50000;

-- 4. List all books issued by member 'C110'.
SELECT issued_book_name
FROM issued_status
WHERE issued_member_id = 'C110';

-- 5.List all employees along with their branch addresses.
SELECT e.emp_name, e.position, b.branch_address
FROM employees e
JOIN branch b ON e.branch_id = b.branch_id;

--6.Show the most frequently issued book(s).
SELECT issued_book_name, COUNT(*) AS issue_count
FROM issued_status
GROUP BY issued_book_name
ORDER BY issue_count DESC
LIMIT 1;