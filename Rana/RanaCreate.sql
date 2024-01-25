
-- creating tables

create table question
(
	ID int primary key,
	type nchar(3), -- TF, MCQ, TXT
	questionText nvarchar(max),
	questionAnswer nvarchar(max)
);


create table questionExam
(
	questionID int,
	examID int,
	degree int
);

create table examStudent
(
	examID int,
	studentID int
);

create table studentAnswer
(
	questionID int,
	studentID int,
	examID int,
	answer nvarchar(max),
	score int
)


-----------------------------------------------