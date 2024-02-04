create proc make_exam_proc
(@ins_id int, @c_id int, @type bit,
@year date, @allownace nvarchar(max),
@startTime datetime, @endTime datetime)
as
begin
	if @ins_id = (select instructorID from Course where c_id = @c_id)
	begin
		insert into Exam
		values (@type, @year, @allownace, @startTime, @endTime, @c_id, @ins_id)

		print 'to chose questions by selecting number of questions of each type and ' 
		+ 'the system selects the questions random '
		+ 'exec chose_Q_random_proc'
		print 'to manually chose and view questions exec chose_Q_manual_proc'

	end
	else
		print 'Can only make exam for your course'
end
--declare @eid int = (select IDENT_CURRENT('Exam'))

-- make random exam
go
create or alter proc chose_Q_random_proc
(@exam_id int,@c_id int,
@NMCQ int, @NTF int, @NTXT int, 
@MCQ_degree int, @TF_degree int, @TXT_degree int)
as
begin
		if @exam_id in (select e_id from Exam)
		begin
			declare @MCQ_count as int = 
			(select count(id)
			from question
			group by type
			having type = 'MCQ')

			declare @TF_count as int = 
			(select count(id)
			from question
			group by type
			having type = 'TF')

			declare @TXT_count as int = 
			(select count(id)
			from question
			group by type
			having type = 'TXT')

			if (@MCQ_count >= @NMCQ and @TF_count >= @NTF and @TXT_count >= @NTXT)
			begin
				if ((@NMCQ * @MCQ_degree) + (@NTF * @TF_degree) + (@NTXT * @TXT_degree))
				< (select maxDegree from Course where c_id = @c_id)
				begin
					if @NMCQ > 0
					begin
						insert into questionExam
							select top(@NMCQ) id, @exam_id, @MCQ_degree
							from question
							where type = 'MCQ'
							order by NEWID()
					end
					if @NTF > 0
					begin
						insert into questionExam
							select top(@NTF) id, @exam_id, @TF_degree
							from question
							where type = 'TF'
							order by NEWID()
					end
					if @NTXT > 0
					begin
						insert into questionExam
							select top(@NMCQ) id, @exam_id, @TXT_degree
							from question
							where type = 'TXT'
							order by NEWID()
					end
					select * from questionExam
				end
				else
					print 'sum of degree must be lower than max degree in course'
			end
			else 
				print 'chose lower number of questions'
		end
		else
		print 'make exam first'
end


-- display questions to chose from
go
create or alter proc disp_questions_proc

as 
begin
	select * from question
end


-- create manual exam
go 
create or alter proc make_exam_manual_proc(
@exam_id int, @c_id int,
@Question_id_string nvarchar(max), 
@question_degree_string nvarchar(max))
as
begin
	if @exam_id in (select e_id from Exam)
	begin
		declare @value_question table (id int) 
		insert into @value_question select cast(value as int) from string_split(@Question_id_string, ',')
		if (select max(id) from @value_question) < (select max(ID) from question)
		begin
			declare @maxdegree int = (select maxDegree from Course where c_id = @c_id)
			declare @value_degree table (degree int)
			insert into @value_degree select cast(value as int) from string_split(@question_degree_string, ',')
			declare @sumdegree int = (select sum(degree) from @value_degree)
			if @sumdegree < @maxdegree
			begin
				insert into questionExam
					select
					 i.id, @exam_id, d.degree
					from
					(select id,ROW_NUMBER() OVER (ORDER BY id) AS rn from @value_question) as i
					full outer join 
					(select degree, ROW_NUMBER() OVER (ORDER BY degree) AS rn from @value_degree) as d
					on i.rn = d.rn
			end
			else 
				print 'cant make max degrees bigger than max degree for course'
		end
		else
		print 'chose ids from question table'
	end
	else
	print 'make exam first'
end

go
--Instructor can select students that can do specific exam

create or alter proc select_students_for_exam_proc @student_id int, @exam_id int
as
begin
    if not exists (select 1 from Student where id = @student_id)
    begin
        print 'Student does not exist';
        return;
    end

    if not exists (select 1 from Exam where e_id = @exam_id)
    begin
        print 'Exam does not exist';
        return;
    end

    if exists (select 1 from examStudent where studentID = @student_id and  examID= @exam_id)
    begin
        print 'Student already assigned to this exam';
        return;
    end

    -- add student to the exam
    insert into examStudent (studentID, examID) values (@student_id, @exam_id);
    print 'Student added to exam successfully';
end;

-- calculate score for each question

go 
create or alter procedure check_answer__calc_score_proc 
    @exam_id int, 
    @student_id int
as
begin
    update es
    set es.score = case 
                        when es.answer = q.questionanswer then qe.degree 
                        else 0 
                    end
    from 
        examstudent es
    join 
        question q on es.question_id = q.id
    join 
        questionexam qe on qe.questionid = q.id
    where 
        es.examid = @exam_id and es.studentid = @student_id;
end;


-- calculate final score for student in exam
go
create or alter proc calc_final_result_for_student 
	@exam_id int,
	@student_id int
as
begin
	select s.name , es.examID, sum(es.score) AS final_score
	from examStudent es
	join Student s
	on s.id = es.studentID
	where es.examID = @exam_id and es.studentID = @student_id
	group by s.name , es.examID
end;