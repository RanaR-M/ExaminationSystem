/*  System should store courses information (Course name, description, Max degree, Min Degree),
instructors’ information, and students’ information, each instructor can teach one or more course,
and each course may be teacher by one instructor in each class (Instructor may be changed for
other class in other year).  */

use Examination;


--select * from [dbo].[Course]

--select * from [dbo].[Instructor]

--select * from [dbo].[Student]

--select * from [dbo].[question]


--- instructor  (creating tasks)

create proc add_instructor_proc @name nvarchar(max)
as
begin
	insert into [dbo].[Instructor]
	values (@name);
end;



create proc delete_instructor_proc @id int
as
begin
	delete from [dbo].[Instructor]
	where ins_id = @id;
end;



create proc edit_instructor_proc @old_name nvarchar(max), @new_name nvarchar(max)
as
begin
	update [dbo].[Instructor]
	set name = @new_name
	where name = @old_name;
end;



create proc disp_instructor_proc
as
begin
	select * from [dbo].[Instructor];
end;



--- instructor  (add data)    &&& test


exec [dbo].[add_instructor_proc] 'ahmed'
exec [dbo].[add_instructor_proc] 'ali'
exec [dbo].[add_instructor_proc] 'khaled'
exec [dbo].[add_instructor_proc] 'abdo'
exec [dbo].[add_instructor_proc] 'saeed'
exec [dbo].[add_instructor_proc] 'mostafa'
exec [dbo].[add_instructor_proc] 'moaaz'
exec [dbo].[add_instructor_proc] 'taha'


exec [dbo].[disp_instructor_proc]

exec [dbo].[edit_instructor_proc] 'taha' , 'rami'

exec [dbo].[delete_instructor_proc] 16


-------------------------------------------------------------------------------------------

--- Course  (creating tasks)

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



create proc delete_course_proc @course_id int
as
begin
    delete from Course
    where c_id = @course_id;
end;



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




create function get_course_info_by_name_fun(@course_name nvarchar(max))
returns table
as
return (
    select [name], [desc], minDegree, maxDegree
    from Course
    where [name] = @course_name
);




create proc disp_course_proc
as
begin
	select * from [dbo].[Course];
end;


--- Course  (add data)    &&& test

exec add_course_proc 'SQL', 'Basic database concepts', 0, 100, 9;
exec add_course_proc 'Python', 'Fundamentals of programming', 0, 100, 10;
exec add_course_proc 'Power BI', 'Building interactive dashboards', 0, 100, 11;
exec add_course_proc 'Data Science Fundamentals', 'Introduction to data analysis', 0, 100, 12;
exec add_course_proc 'Network Security', 'Securing computer networks', 0, 100, 9;
exec add_course_proc 'Data Mining', 'Overview of statistics and AI techniques', 0, 100, 10;


exec delete_course_proc 5;

exec edit_course_proc 'SQL' , 'fundamentals of database concepts', 0, 100, 9


exec disp_course_proc;


select * from [dbo].[get_course_info_by_name_fun]('SQL');

------------------------------------------------------------------------------------------------------------------------------
----- studentCourse  (creating tasks)

--create trigger add_student_course_trg
--on student
--after insert
--as
--begin
--    declare @StudentID int;
--    select @StudentID = inserted.StudentID from inserted;

--    -- Logic to determine the course to add the student to based on specific criteria
--    declare @CourseID int;
--    select @CourseID = CourseID from course where FieldOfStudy = (select FieldOfStudy from student where StudentID = @StudentID);

--    if @CourseID is not null
--    begin
--        insert into studentCourse (StudentID, CourseID)
--        values (@StudentID, @CourseID);
--    end;
--end;
