
--training manager permissions:

grant exec on [dbo].[add_branch_proc] to [training manager];
grant exec on [dbo].[add_intake_proc] to [training manager];
grant exec on [dbo].[add_student_proc] to [training manager];
grant exec on [dbo].[Add_Student_To_Course_PROC] to [training manager];
grant exec on [dbo].[add_track_branch_proc] to [training manager];
grant exec on [dbo].[add_track_proc] to [training manager];
grant exec on [dbo].[edit_branch_name_proc] to [training manager];
grant exec on [dbo].[edit_track_name_proc] to [training manager];
grant exec on [dbo].[insert_all_student] to [training manager];



--instructor permissions:
grant exec on [dbo].[select_students_for_exam_proc] to [instructor];
grant exec on [dbo].[chose_Q_random_proc] to [instructor];
grant exec on [dbo].[make_exam_manual_proc] to [instructor];
grant exec on [dbo].[make_exam_proc] to [instructor];
grant exec on [dbo].[disp_questions_proc] to [instructor];
grant exec on [dbo].[check_answer__calc_score_proc] to [instructor];
grant exec on [dbo].[calc_final_result_for_student] to [instructor];


--student permissions:

grant exec on [dbo].[CheckExamAccess_proc] to [student];
grant exec on [dbo].[StoreStudentAnswer_proc] to [student];