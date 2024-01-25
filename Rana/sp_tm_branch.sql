use [Examination]
go

/*
-- Training manager can add and edit:
Branches, 
tracks 
intake.
*/

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


-- add proc

go
create proc add_branch_proc
(@name nvarchar(max))
as
begin
	insert into [dbo].[Branch]
	values (@name);
end

go
create proc add_intake_proc
(@name nvarchar(max), @branch_name nvarchar(max))
as
begin
	insert into [dbo].[Intake]
	values (@name, (select id from Branch where name = @branch_name));
end



-- edit proc

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

-- add specific track in one branch
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


-- display all
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

