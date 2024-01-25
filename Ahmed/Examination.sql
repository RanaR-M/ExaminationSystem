create database Examination;
----------------------------
go 
use [Examination]
go

create table Branch(
	id int primary key identity(1,1),
	[name] nvarchar(max) not null
);


create table Intake(
	id int primary key identity(1,1),
	[name] nvarchar(max) not null,
	branch_id int
);


create table Track(
	id int primary key identity(1,1),
	[name] nvarchar(max) not null,
	intake_id int
);


create table Student(
	id int primary key identity(1,1),
	[name] nvarchar(max) not null,
	univeristy nvarchar(max) not null,
	Phone char(11) not null,
	gradDate date not null,
	track_id int 
);


create table Instructor(
	ins_id int primary key identity(1,1),
	[name] nvarchar(max) not null
);


create table Course(
	c_id int primary key identity(1,1),
	[name] nvarchar(max) not null,
	[desc] nvarchar(max) not null,
	minDegree int not null,
	maxDegree int not null,
	instructorID int 
);


create table studentCourse(
	studentID int,
	courseID int
	primary key(studentID,courseID)
);


create table Exam(
	e_id int primary key identity(1,1),
	[type] bit not null,       --exam or corrective
	[year] date not null,
	allowance nvarchar(max) not null,
	startTime datetime not null,
	endTime datetime not null,
	course_id int, 
	instructor_id int
);


create table question
(
	ID int primary key,
	[type] nchar(3), -- TF, MCQ, TXT
	questionText nvarchar(max),
	questionAnswer nvarchar(max) not null
);


create table questionExam
(
	questionID int,
	examID int,
	degree int not null,
	primary key(questionID,examID)
);


create table examStudent
(
	examID int,
	studentID int,
	question_id int,
	primary key(examID,studentID),
	answer nvarchar(max),
	score int
);


----------------
--Relations


alter table Intake 
add constraint intake_branch
foreign key (branch_id)
references Branch(id);


alter table Track 
add constraint track_intake
foreign key (intake_id)
references Intake(id);


alter table Student 
add constraint student_track
foreign key (track_id)
references Track(id);


alter table Course 
add constraint instructor_course
foreign key (instructorID)
references Instructor(ins_id);


alter table studentCourse 
add constraint studentCourse_student
foreign key (studentID)
references Student(id);


alter table studentCourse 
add constraint studentCourse_course
foreign key (courseID)
references Course(c_id);


alter table Exam 
add constraint exam_course
foreign key (course_id)
references Course(c_id);


alter table Exam 
add constraint exam_instructor
foreign key (instructor_id)
references Instructor(ins_id);


alter table questionExam 
add constraint questionExam_question
foreign key (questionID)
references question(ID);


alter table questionExam 
add constraint questionExam_exam
foreign key (examID)
references Exam(e_id);


alter table examStudent 
add constraint examStudent_exam
foreign key (examID)
references Exam(e_id);


alter table examStudent 
add constraint examStudent_student
foreign key (examID)
references Student(id);


--add relation 
alter table examStudent 
add constraint examStudent_question
foreign key (question_id)
references question(ID);





