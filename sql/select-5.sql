-- Задача:
--    Вывести топ пар, по каждому из танцев по Латине независимо от категории,
--    в которой участвовала пара, в формате: место, номер категории, номер пары, танец.

-- <func>(...) OVER(...): PARTITION BY + ORDER BY
------------------------------------------------------------------------------------------------------------------------

SELECT RANK() OVER (PARTITION BY info.dance ORDER BY info.place), info.competition_category_id, info.couple_id, info.dance
FROM (SELECT s.dance, s.place, cat.dances_category, s.couple_id, s.competition_category_id FROM ballroom_database.scores as s JOIN ballroom_database.competition_category as cat
      ON cat.competition_category_id = s.competition_category_id) as info
WHERE info.dances_category = 'Latin';
