create database libraryManagEment;

use libraryManagEment;

-- Table: tbl_publisher
CREATE TABLE tbl_publisher (
    publisher_PublisherName VARCHAR(255) PRIMARY KEY,
    publisher_PublisherAddress TEXT,
    publisher_PublisherPhone VARCHAR(15)
);

select * from tbl_publisher;

-- Table: tbl_book
CREATE TABLE tbl_book (
    book_BookID INT PRIMARY KEY,
    book_Title VARCHAR(255),
    book_PublisherName VARCHAR(255),
    FOREIGN KEY (book_PublisherName) REFERENCES tbl_publisher(publisher_PublisherName)
);
select * from tbl_book;

-- Table: tbl_book_authors
CREATE TABLE tbl_book_authors (
    book_authors_AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    book_authors_BookID INT,
    book_authors_AuthorName VARCHAR(255),
    FOREIGN KEY (book_authors_BookID) REFERENCES tbl_book(book_BookID)
);
select * from tbl_book_authors;

-- Table: tbl_library_branch
CREATE TABLE tbl_library_branch (
    library_branch_BranchID  INT auto_increment PRIMARY KEY ,
    library_branch_BranchName VARCHAR(255),
    library_branch_BranchAddress TEXT
);
select * from tbl_library_branch;

-- Table: tbl_book_copies
CREATE TABLE tbl_book_copies (
    book_copies_CopiesID INT AUTO_INCREMENT PRIMARY KEY,
    book_copies_BookID INT,
    book_copies_BranchID INT,
    book_copies_No_Of_Copies INT,
    FOREIGN KEY (book_copies_BookID) REFERENCES tbl_book(book_BookID),
    FOREIGN KEY (book_copies_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID)
);

select * from tbl_book_copies;
-- drop table tbl_book_copies;
-- Table: tbl_borrower
CREATE TABLE tbl_borrower (
    borrower_CardNo INT PRIMARY KEY,
    borrower_BorrowerName VARCHAR(255),
    borrower_BorrowerAddress TEXT,
    borrower_BorrowerPhone VARCHAR(15)
);

select * from tbl_borrower;


-- Table: tbl_book_loans
CREATE TABLE tbl_book_loans (
    book_loans_LoansID INT  auto_increment primary KEY ,
    book_loans_BookID INT,
    book_loans_BranchID INT,
    book_loans_CardNo INT,
    book_loans_DateOut DATE,
    book_loans_DueDate DATE,
    FOREIGN KEY (book_loans_BookID) REFERENCES tbl_book(book_BookID),
    FOREIGN KEY (book_loans_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID),
    FOREIGN KEY (book_loans_CardNo) REFERENCES tbl_borrower(borrower_CardNo)
);

select * from tbl_book_loans;



-- How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?-- 

DELIMITER $$

CREATE PROCEDURE GetBookCopies (
    IN p_bookTitle VARCHAR(255),
    IN p_branchName VARCHAR(255)
)

BEGIN
    SELECT tbc.book_copies_No_Of_Copies
    FROM tbl_book tbk
    JOIN tbl_book_copies tbc 
        ON tbk.book_BookID = tbc.book_copies_BookID
    JOIN tbl_library_branch tlb 
        ON tbc.book_copies_BranchID = tlb.library_branch_BranchID
    WHERE tbk.book_Title = p_bookTitle
      AND tlb.library_branch_BranchName = p_branchName;
END $$

DELIMITER ;

CALL GetBookCopies('The Lost Tribe', 'Sharpstown');


-- How many copies of the book titled "The Lost Tribe" are owned by each library branch?

-- 1st Method
select * from tbl_book as tbk 
inner join tbl_book_copies as tbc
on tbk.book_BookID=tbc.book_copies_BookID
inner join tbl_library_branch as tlb
on tbc.book_copies_BranchID=tlb.library_branch_BranchID
where book_Title="The Lost Tribe";


-- 2nd Method
Delimiter $$

create procedure bookTitle(
in p_bookTitle varchar(255)
)

begin
select *
from tbl_book as tbk
inner join
tbl_book_copies as tbc
on 
tbk.book_BookID=tbc.book_copies_BookID
inner join 
tbl_library_branch as tlb
on 
tbc.book_copies_BranchID=tlb.library_branch_BranchID
where book_Title=p_bookTitle;
end $$

Delimiter ;

call bookTitle("The Lost Tribe");



-- Retrieve the names of all borrowers who do not have any books checked out.(who haven't taken any books)
select b.borrower_BorrowerName, b.borrower_BorrowerAddress
from tbl_borrower as b
left join tbl_book_loans as l
  on b.borrower_CardNo = l.book_loans_CardNo
where l.book_loans_CardNo is null;


-- For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, 
-- retrieve the book title, the borrower's name, and the borrower's address. 
select bt.book_Title,tbor.borrower_BorrowerName,tbor.borrower_BorrowerAddress,tbll.book_loans_DueDate
from tbl_library_branch as tlb
inner join tbl_book_loans as tbll 
on tlb.library_branch_BranchID=tbll.book_loans_BranchID
inner join tbl_borrower as tbor
on tbor.borrower_CardNo=tbll.book_loans_CardNo
inner join tbl_Book as bt
on bt.book_BookID=tbll.book_loans_BookID
where library_branch_BranchName="Sharpstown" and book_loans_DueDate="2/3/18";


-- For each library branch, retrieve the branch name and the total number of books loaned out from that branch.

select tbranch.library_branch_BranchName,count(*) as no_of_books
from tbl_library_branch as tbranch
inner join tbl_book_loans as tloan
on tbranch.library_branch_BranchID=tloan.book_loans_BranchID
group by tbranch.library_branch_BranchName;

-- Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.
select tbow.borrower_BorrowerName,tbow.borrower_BorrowerAddress,count(*) as no_of_books
from tbl_borrower as tbow
inner join tbl_book_loans as tloan
on tbow.borrower_CardNo=tloan.book_loans_CardNo
group by borrower_CardNo 
having no_of_books>5 ;


-- For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".

select tbk.book_Title,tbcop.book_copies_No_Of_Copies
from tbl_book_authors as tba
inner join tbl_book as tbk
on tba.book_authors_BookID=tbk.book_BookID
inner join tbl_book_copies as tbcop
on tbcop.book_copies_BookID=tbk.book_BookID
inner join tbl_library_branch as tbranch
on tbranch.library_branch_BranchID=tbcop.book_copies_BranchID
where book_authors_AuthorName="Stephen King" and library_branch_BranchName="Central";