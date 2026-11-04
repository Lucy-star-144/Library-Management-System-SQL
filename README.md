# Library Management System – SQL Project

## 1. Project Overview

The Library Management System is a relational database project developed using MySQL. The project manages library-related information, including books, publishers, authors, library branches, borrowers, book copies, and book loans.

The objective of this project is to design a structured relational database and use SQL queries, joins, aggregate functions, filtering, and stored procedures to retrieve meaningful information and answer common library management questions.

## 2. Project Objectives

- Design a relational database for managing library operations.
- Create tables with appropriate primary keys and foreign key constraints.
- Establish relationships between books, publishers, authors, branches, and borrowers.
- Retrieve book availability across different library branches.
- Identify borrowers who have not borrowed any books.
- Retrieve loan details based on branch and due date.
- Calculate the number of books loaned from each branch.
- Identify borrowers who have checked out more than five books.
- Retrieve book copy information based on author and branch.

## 3. Technologies Used

- **Database:** MySQL
- **Language:** SQL
- **Concepts:** DDL, DML, Primary Keys, Foreign Keys, INNER JOIN, LEFT JOIN, GROUP BY, HAVING, Aggregate Functions, Stored Procedures.

## 4. Database Design

Database name: `libraryManagement`

The project consists of seven tables.

| Table | Description |
|---|---|
| `tbl_publisher` | Stores publisher details. |
| `tbl_book` | Stores book information and publisher references. |
| `tbl_book_authors` | Stores author information associated with books. |
| `tbl_library_branch` | Stores library branch details. |
| `tbl_book_copies` | Stores the number of copies available at each branch. |
| `tbl_borrower` | Stores borrower information. |
| `tbl_book_loans` | Stores book loan and due-date information. |

## 5. Table Relationships

- A publisher can publish multiple books.
- A book can have multiple authors.
- A library branch can maintain copies of multiple books.
- A book can have copies across multiple library branches.
- A borrower can have multiple book loan records.
- Each book loan is associated with a book, a library branch, and a borrower.

### Database Relationship Summary

- `tbl_publisher` → `tbl_book`
- `tbl_book` → `tbl_book_authors`
- `tbl_book` → `tbl_book_copies`
- `tbl_library_branch` → `tbl_book_copies`
- `tbl_library_branch` → `tbl_book_loans`
- `tbl_book` → `tbl_book_loans`
- `tbl_borrower` → `tbl_book_loans`

## 6. SQL Implementation and Business Requirements

### Requirement 1: Retrieve the number of copies of a specific book at a particular library branch.

**Business Question:** How many copies of the book titled "The Lost Tribe" are owned by the Sharpstown branch?

**SQL Concepts Used:**
- INNER JOIN
- WHERE clause
- Stored Procedure

A stored procedure named `GetBookCopies` accepts the book title and branch name as input parameters and retrieves the corresponding number of copies.

### Requirement 2: Retrieve the number of copies of a specific book at every library branch.

**Business Question:** How many copies of "The Lost Tribe" are owned by each library branch?

**SQL Concepts Used:**
- INNER JOIN
- WHERE clause

Two approaches were implemented:
1. A direct SQL query.
2. A stored procedure named `bookTitle` that accepts the book title as an input parameter.

### Requirement 3: Identify borrowers who have not checked out any books.

**Business Question:** Retrieve the names and addresses of all borrowers who have never borrowed a book.

**SQL Concepts Used:**
- LEFT JOIN
- NULL filtering

A LEFT JOIN is used to retain all borrowers, including those without matching loan records. Filtering for NULL loan records identifies borrowers who have not borrowed any books.

### Requirement 4: Retrieve books loaned from Sharpstown with a specific due date.

**Business Question:** For each book loaned from the Sharpstown branch with a due date of February 3, 2018, retrieve the book title, borrower's name, and address.

**SQL Concepts Used:**
- Multiple INNER JOINs
- WHERE clause
- Date filtering

The query joins the library branch, book loans, borrower, and book tables to retrieve the required information.

### Requirement 5: Calculate the total number of books loaned from each library branch.

**Business Question:** Retrieve each library branch name and the total number of books loaned from that branch.

**SQL Concepts Used:**
- INNER JOIN
- COUNT()
- GROUP BY

The query groups loan records by branch and counts the loan records for each branch.

### Requirement 6: Identify borrowers who have checked out more than five books.

**Business Question:** Retrieve the names, addresses, and number of books checked out for borrowers who have more than five books checked out.

**SQL Concepts Used:**
- INNER JOIN
- COUNT()
- GROUP BY
- HAVING

The query groups loan records by borrower and uses the HAVING clause to filter borrowers with more than five loan records.

### Requirement 7: Retrieve book titles and copy counts for a specific author at a particular branch.

**Business Question:** For every book authored by Stephen King, retrieve the book title and the number of copies available at the Central branch.

**SQL Concepts Used:**
- Multiple INNER JOINs
- WHERE clause
- Relational table relationships

The query connects the authors, books, book copies, and library branches tables to retrieve the required information.

## 7. SQL Concepts Demonstrated

| SQL Concept | Application |
|---|---|
| CREATE DATABASE | Creating the library database. |
| CREATE TABLE | Defining the database structure. |
| PRIMARY KEY | Uniquely identifying records. |
| FOREIGN KEY | Establishing relationships between tables. |
| AUTO_INCREMENT | Automatically generating IDs. |
| INNER JOIN | Retrieving matching records across tables. |
| LEFT JOIN | Identifying borrowers without loan records. |
| WHERE | Filtering records based on conditions. |
| COUNT() | Counting book loans and records. |
| GROUP BY | Grouping records by branch or borrower. |
| HAVING | Filtering aggregated results. |
| Stored Procedures | Creating reusable queries with input parameters. |

## 8. How to Run the Project

1. Install and open MySQL Workbench or another MySQL-compatible SQL environment.
2. Open the project SQL script.
3. Execute the database creation statement.
4. Execute the table creation statements in the correct order.
5. Ensure the required data has been inserted into the tables.
6. Execute the SELECT queries to retrieve the required results.
7. Create and execute the stored procedures using the `DELIMITER` statements.
8. Use the `CALL` statement to execute the stored procedures.

## 9. Project Outcome

The project demonstrates the design and implementation of a relational database for a library management system.

It provides practical experience in database creation, establishing table relationships, retrieving information through joins, performing grouped calculations, filtering aggregated results, and creating reusable stored procedures.

The project strengthens foundational SQL skills and demonstrates how relational databases can be used to manage and retrieve structured information in a real-world library environment.
