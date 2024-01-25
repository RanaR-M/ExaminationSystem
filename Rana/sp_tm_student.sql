use [Examination]
go

/*
Training manager can 
add students, and
define their personal data, 
intake, branch, and track.
*/

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
create proc delete_student_proc
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