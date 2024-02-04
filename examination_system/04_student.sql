
--Students can see the exam and do it only on the specified time.

create or alter procedure CheckExamAccess_proc
    @examId int,
    @studentId int
as
begin
    declare @currentDateTime datetime = getdate();
    declare @startDateTime datetime;
    declare @endDateTime datetime;

    select @startDateTime = startTime, @endDateTime = endTime from Exam where e_id = @examId;

    if @currentDateTime >= @startDateTime and @currentDateTime <= @endDateTime
    begin
		
		if exists (select 1 from examStudent where examID = @examId and studentID = @studentId)
		begin

			select 'You can access the exam';          -- Allow student to access the exam

			select q.questionText 
			from question q
			inner join questionExam qe
			on q.ID = qe.questionID
			where qe.examID= @examId;

		end
		else
		begin
			select 'You do not have access to this exam';       -- Deny access to the exam
		end
    end
    else
    begin
        select 'The exam is not available at this time';               -- Deny access to the exam
	end;
end;

-- store student answer
go
create or alter procedure StoreStudentAnswer_proc
    @studentId int,
    @examId int,
    @questionId int,
    @answerText nvarchar(max)
as
begin
    if exists (select 1 from examStudent where examID = @examId and studentID = @studentId)
    begin
        if exists (select 1 from questionExam where examID = @examId and questionID = @questionId)
        begin
            -- store the student's answer
            insert into [dbo].[examStudent] (studentID, examID, question_id, answer)
            values (@studentId, @examId, @questionId, @answerText);

            select 'Your answer has been stored' as message;
        end
        else 
        begin
            select 'The question does not belong to this exam' as message;
        end
    end
    else
    begin
        select 'You do not have access to this exam' as message;
    end
end;