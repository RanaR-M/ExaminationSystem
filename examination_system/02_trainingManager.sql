use [Examination]
go


-- display proc
create proc disp_branch_proc
as
begin
	select * from [dbo].[Branch];
end

go
create proc disp_track_proc
as
begin
	select * from [dbo].[Track];
end

go
create proc disp_intake_proc
as
begin
	select * from [dbo].[Intake];
end

-- display all branches with their intakes and tracks
go
create proc disp_all_proc
as
begin
	select b.id 'branch id',b.name 'branch name', 
	i.id 'intake id', i.name 'intake name',
	t.intake_id 'track id', t.name 'track name'
	from Branch b
	join intake i
	on i.branch_id = b.id
	join track t
	on t.intake_id = i.id  
end



-- add proc 
go
create proc add_branch_proc
(@name nvarchar(max))
as
begin
	insert into [dbo].[Branch]
	values (@name);
end

-- add intake based on branch name 
-- then search for this name and use the id for the FK
go
create proc add_intake_proc
(@name nvarchar(max), @branch_name nvarchar(max))
as
begin
	insert into [dbo].[Intake]
	values (@name, (select id from Branch where name = @branch_name));
end

-- add intake based on branch, intake names
-- then search for their names and use the ids for the FKs

go
create proc add_track_branch_proc
(@name nvarchar(max), @intake_name nvarchar(max), @branch_name nvarchar(max))
as 
begin
	insert into [dbo].[Track]
	values(
	@name, 
	(select i.id from Intake i join Branch b on b.id = i.branch_id 
	where b.name = @branch_name and i.name = @intake_name)
	)
end



-- edit proc

-- edit based on names
go
create proc edit_branch_name_proc
(@oldname nvarchar(max), @newname nvarchar(max))
as
begin
	update [dbo].[Branch]
	set name = @newname
	where name = @oldname;
end

go
create proc edit_intake_name_proc 
(@oldname nvarchar(max), @newname varchar(max), @branch_name nvarchar(max))
as 
begin
	update 	[dbo].[Intake]
	set name = @newname
	where name = @oldname and branch_id = (select id from Branch where name = @branch_name)
end

go
create proc edit_track_name_proc
(@oldname nvarchar(max), @newname nvarchar(max), @intake_name nvarchar(max), @branch_name nvarchar(max))
as
begin
	update [dbo].[Track]
	set name = @newname
	where name = @oldname and intake_id = (select id from Intake where name = @intake_name and
	branch_id = (select id from Branch where name = @branch_name))
end



-- student procs

-- disp students
create proc disp_student_proc
as
begin
	select * from [dbo].[Student];
end


-- add student
go
create proc add_student_proc
(
@name nvarchar(max), @uni nvarchar(max), @phone char(11),
@gradDate date, 
@track_name nvarchar(max), @intake_name nvarchar(max), @branch_name nvarchar(max)
)
as
begin
	insert into [dbo].[Student]
	values (@name, @uni, @phone, @gradDate, 
	(
	select t.id
	from Track t
	join Intake i
	on i.id = t.intake_id
	join Branch b
	on b.id = i.branch_id
	where t.name = @track_name and i.name = @intake_name and b.name = @branch_name
	));
end


-- delete student
go
create or alter proc delete_student_proc
(@name nvarchar(max), 
@track_name nvarchar(max), @intake_name nvarchar(max), @branch_name nvarchar(max))
as 
begin
	delete from [dbo].[Student]
	where name = @name and track_id = 
	(
	select t.id
	from Track t
	join Intake i
	on i.id = t.intake_id
	join Branch b
	on b.id = i.branch_id
	where t.name = @track_name and i.name = @intake_name and b.name = @branch_name
	);
end


-- instructor procs

go

create proc add_instructor_proc @name nvarchar(max)
as
begin
	insert into [dbo].[Instructor]
	values (@name);
	PRINT 'Instructor Inserted: ' + @name + ' is inserted.';
end;

go

create proc delete_instructor_proc 
@ins_id int,
@name nvarchar(max)
as
begin
    IF EXISTS (SELECT ins_id FROM [Instructor] WHERE ins_id = @ins_id AND name = @name)
    BEGIN
        DELETE FROM [Instructor] WHERE ins_id = @ins_id AND name = @name;
        PRINT 'Instructor with ins_id ' + CAST(@ins_id AS NVARCHAR(10)) + ' is deleted';

    END
    ELSE
        PRINT 'Instructor with ins_id ' + CAST(@ins_id AS NVARCHAR(10)) + ' does not exist';
end;

go

create proc edit_instructor_proc 
@old_name nvarchar(max), @new_name nvarchar(max), @id int
as
begin
    IF EXISTS (SELECT @id FROM [Instructor] WHERE ins_id= @id and [name] = @old_name)
    BEGIN
        UPDATE [Instructor]
        SET [Name] = @new_name
           WHERE ins_id = @ID and [name] = @old_name;

        PRINT 'Instructor: ' + @new_name + ' is updated';
    END
    ELSE
        PRINT 'Instructor does not exist';
end;

go

create proc disp_instructor_proc
as
begin
	select * from [dbo].[Instructor];
end;




--- Course  (creating tasks)
go
create proc add_course_proc
    @course_name nvarchar(max),
    @description nvarchar(max),
    @min_degree int,
	@max_degree int,
	@instructor_id int
as
begin
    insert into Course
    values (@course_name, @description, @min_degree, @max_degree, @instructor_id);
end;


go
create proc delete_course_proc @course_id int
as
begin
    delete from Course
    where c_id = @course_id;
end;


go
create proc edit_course_proc
    @course_name nvarchar(max),
    @description nvarchar(max),
    @min_degree int,
	@max_degree int,
	@instructor_id int
as
begin
    update Course
    set [name] = @course_name,
        [desc] = @description,
		minDegree = @min_degree,
        maxDegree = @max_degree,
		instructorID = @instructor_id
    where name = @course_name;
end;

-- takes course name and returns all the info

go
create function get_course_info_by_name_fun(@course_name nvarchar(max))
returns table
as
return (
    select [name], [desc], minDegree, maxDegree
    from Course
    where [name] = @course_name
);

-- takes instructor id and displays the courses info they teach

go
create or alter function get_instructor_courses_name_id_func(@ins_id int, @name nvarchar(max))
returns table
as
return
(
	select ins.[name] 'instructor name' , co.[name] 'course name', [desc], minDegree, maxDegree
	from Course co
	join Instructor ins
	on ins.ins_id = co.instructorID
	where ins.name = @name
);

go
create proc disp_course_proc
as
begin
	select * from [dbo].[Course];
end;


-- views for easier insertion for courses to students

--- this is all for 2023Q2 ONLY
go
create or alter view courses_for_BI
as
select
c_id, c.name, t.id
from Course c, Track t 
where c_id in (1,2,3,4,6) and t.id = 43;


go
create or alter view courses_for_python
as 
select 
c_id, c.name, t.id
from Course c, Track t 
where c_id in (1,2,4) and t.id = 45;


go
create or alter view courses_for_dot_net
as 
select 
c_id, c.name, t.id
from Course c, Track t 
where c_id in (1,7) and t.id = 46;


go
create or alter view courses_for_web
as 
select 
c_id, t.id
from Course c, Track t  
where c_id in (7) and t.id = 47;


-- exec to add all courses at once

go
create or alter proc insert_course_student_BI_proc
as
begin
	insert into studentCourse (studentID, courseID)
		select s.id, c_id
		from 
		Student s
		join courses_for_BI cBI
		on cBI.id = s.track_id	
end

go
create or alter proc insert_course_student_py_proc
as
begin
	insert into studentCourse (studentID, courseID)
		select s.id, c_id
		from 
		Student s
		join courses_for_python cPY
		on cPY.id = s.track_id
end

go
create or alter proc insert_course_student_dot_proc
as
begin
	insert into studentCourse (studentID, courseID)
		select s.id, c_id
		from 
		Student s
		join courses_for_dot_net cDOT
		on cDOT.id = s.track_id
end

go
create or alter proc insert_course_student_web_proc
as
begin
	insert into studentCourse (studentID, courseID)
		select s.id, c_id
		from 
		Student s
		join courses_for_web cWEB
		on cWEB.id = s.track_id
end

go 
create or alter proc insert_all_student
as
begin
	exec insert_course_student_BI_proc
	exec insert_course_student_py_proc
	exec insert_course_student_dot_proc
	exec insert_course_student_web_proc
end


go 
create function view_student_courses_func ()
returns table
as
return 
(
	select s.name 'Student name', c.name 'Course name'
	from
	Student s
	join studentCourse sc
	on sc.studentID = s.id
	join Course c
	on sc.courseID = c.c_id
)
go
