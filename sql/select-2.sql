-- Задача:
--    Вывести топ-5 номера пар в категории Молодежь С класс Латина,
--    в соревновании 'Весенний бал Терпсихоры', по танцy Самба (S).
--
-- ORDER BY
------------------------------------------------------------------------------------------------------------------------

SELECT "s*".couple_id, "s*".place
FROM (SELECT *
      FROM ballroom_database.scores as s
      WHERE s.competition_category_id = (SELECT cat.competition_category_id
                                         FROM ballroom_database.competition_category as cat
                                         WHERE cat.competition_id =
                                               (SELECT competition_id
                                                FROM ballroom_database.competition as c
                                                WHERE c.competition_name = 'Весенний бал Терпсихоры')
                                           AND cat.dancers_class = 'C'
                                           AND cat.age_category = 'Молодежь'
                                           AND cat.dances_category = 'Latin')
      ORDER BY place) as "s*"
WHERE "s*".dance = 'S'
LIMIT 5;
