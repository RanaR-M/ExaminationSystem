use [Examination]

-- add few branches

exec dbo.disp_branch_proc

exec dbo.add_branch_proc 'Smart Village'
exec dbo.add_branch_proc 'Assuit'
exec dbo.add_branch_proc 'Ismailia'
exec dbo.add_branch_proc 'Menofia'
exec dbo.add_branch_proc 'Alexandria'
exec dbo.add_branch_proc 'Aswan'
exec dbo.add_branch_proc 'Mansoura'
exec dbo.add_branch_proc 'Minya'

exec dbo.disp_branch_proc

-- add intake

exec dbo.disp_intake_proc

exec dbo.add_intake_proc 'one', 'Smart Village'
exec dbo.add_intake_proc 'two', 'Smart Village'
exec dbo.add_intake_proc 'three', 'Smart Village'
exec dbo.add_intake_proc 'four', 'Smart Village'
exec dbo.add_intake_proc 'five', 'Smart Village'

exec dbo.add_intake_proc '2020Q1', 'Assuit'
exec dbo.add_intake_proc '2020Q2', 'Assuit'
exec dbo.add_intake_proc '2021Q1', 'Assuit'
exec dbo.add_intake_proc '2021Q2', 'Assuit'
exec dbo.add_intake_proc '2022Q1', 'Assuit'
exec dbo.add_intake_proc '2022Q2', 'Assuit'
exec dbo.add_intake_proc '2022Q2', 'Assuit'
exec dbo.add_intake_proc '2023Q1', 'Assuit'
exec dbo.add_intake_proc '2023Q2', 'Assuit'

exec dbo.add_intake_proc '2020Q1', 'Ismailia'
exec dbo.add_intake_proc '2020Q2', 'Ismailia'
exec dbo.add_intake_proc '2021Q1', 'Ismailia'
exec dbo.add_intake_proc '2021Q2', 'Ismailia'
exec dbo.add_intake_proc '2022Q1', 'Ismailia'
exec dbo.add_intake_proc '2022Q2', 'Ismailia'
exec dbo.add_intake_proc '2022Q2', 'Ismailia'
exec dbo.add_intake_proc '2023Q1', 'Ismailia'
exec dbo.add_intake_proc '2023Q2', 'Ismailia'

exec dbo.add_intake_proc '2020Q1', 'Menofia'
exec dbo.add_intake_proc '2020Q2', 'Menofia'
exec dbo.add_intake_proc '2021Q1', 'Menofia'
exec dbo.add_intake_proc '2021Q2', 'Menofia'
exec dbo.add_intake_proc '2022Q1', 'Menofia'
exec dbo.add_intake_proc '2022Q2', 'Menofia'
exec dbo.add_intake_proc '2022Q2', 'Menofia'
exec dbo.add_intake_proc '2023Q1', 'Menofia'
exec dbo.add_intake_proc '2023Q2', 'Menofia'

exec dbo.add_intake_proc '2020Q1', 'Alexandria'
exec dbo.add_intake_proc '2020Q2', 'Alexandria'
exec dbo.add_intake_proc '2021Q1', 'Alexandria'
exec dbo.add_intake_proc '2021Q2', 'Alexandria'
exec dbo.add_intake_proc '2022Q1', 'Alexandria'
exec dbo.add_intake_proc '2022Q2', 'Alexandria'
exec dbo.add_intake_proc '2022Q2', 'Alexandria'
exec dbo.add_intake_proc '2023Q1', 'Alexandria'
exec dbo.add_intake_proc '2023Q2', 'Alexandria'

exec dbo.add_intake_proc '2020Q1', 'Aswan'
exec dbo.add_intake_proc '2020Q2', 'Aswan'
exec dbo.add_intake_proc '2021Q1', 'Aswan'
exec dbo.add_intake_proc '2021Q2', 'Aswan'
exec dbo.add_intake_proc '2022Q1', 'Aswan'
exec dbo.add_intake_proc '2022Q2', 'Aswan'
exec dbo.add_intake_proc '2022Q2', 'Aswan'
exec dbo.add_intake_proc '2023Q1', 'Aswan'
exec dbo.add_intake_proc '2023Q2', 'Aswan'

exec dbo.add_intake_proc '2020Q1', 'Mansoura'
exec dbo.add_intake_proc '2020Q2', 'Mansoura'
exec dbo.add_intake_proc '2021Q1', 'Mansoura'
exec dbo.add_intake_proc '2021Q2', 'Mansoura'
exec dbo.add_intake_proc '2022Q1', 'Mansoura'
exec dbo.add_intake_proc '2022Q2', 'Mansoura'
exec dbo.add_intake_proc '2022Q2', 'Mansoura'
exec dbo.add_intake_proc '2023Q1', 'Mansoura'
exec dbo.add_intake_proc '2023Q2', 'Mansoura'

exec dbo.add_intake_proc '2020Q1', 'Minya'
exec dbo.add_intake_proc '2020Q2', 'Minya'
exec dbo.add_intake_proc '2021Q1', 'Minya'
exec dbo.add_intake_proc '2021Q2', 'Minya'
exec dbo.add_intake_proc '2022Q1', 'Minya'
exec dbo.add_intake_proc '2022Q2', 'Minya'
exec dbo.add_intake_proc '2022Q2', 'Minya'
exec dbo.add_intake_proc '2023Q1', 'Minya'
exec dbo.add_intake_proc '2023Q2', 'Minya'

exec dbo.disp_intake_proc 

-- add track

exec add_track_branch_proc 'OS','one', 'Smart Village'
exec add_track_branch_proc 'SD','two', 'Smart Village'
exec add_track_branch_proc 'DS','three', 'Smart Village'
exec add_track_branch_proc 'DS','four', 'Smart Village'
exec add_track_branch_proc 'DA','five', 'Smart Village'

exec add_track_branch_proc '.net','2020Q1', 'Assuit'
exec add_track_branch_proc 'python','2020Q2', 'Assuit'

exec add_track_branch_proc '.net','2021Q1', 'Ismailia'
exec add_track_branch_proc 'python','2021Q2', 'Ismailia'

exec add_track_branch_proc '.net','2022Q1', 'Menofia'
exec add_track_branch_proc 'python','2022Q2', 'Menofia'

exec add_track_branch_proc '.net','2022Q1', 'Alexandria'

exec add_track_branch_proc '.net','2022Q1', 'Aswan'

exec add_track_branch_proc '.net','2022Q1', 'Mansoura'


exec add_track_branch_proc '.net','2022Q1', 'Minya'
exec add_track_branch_proc 'BI','2022Q2', 'Minya'

exec add_track_branch_proc 'BI','2023Q1', 'Minya'
exec add_track_branch_proc 'BI','2023Q2', 'Minya'

exec add_track_branch_proc 'python', '2023Q2', 'Minya'
exec add_track_branch_proc '.net', '2023Q2', 'Minya'
exec add_track_branch_proc 'web', '2023Q2', 'Minya'


-- display all

exec dbo.disp_all_proc

