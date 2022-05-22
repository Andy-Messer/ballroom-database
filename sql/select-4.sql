-- Задача:
--    Вывести антитоп судей, по очкам грязного судейства, в формате:
--    Ранг судьи, имя Фамилия, категория, кол-во очков грязного судейства.

-- <func>(...) OVER(...): ORDER BY
------------------------------------------------------------------------------------------------------------------------
SELECT RANK() OVER (ORDER BY c.dirty_judging_points), c.coach_name, c.judge_category, c.dirty_judging_points
FROM ballroom_database.coach as c;