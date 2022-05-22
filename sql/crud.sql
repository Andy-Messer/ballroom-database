-- C -- Create <-> INSERT

INSERT INTO ballroom_database.dancer
VALUES (101, 'Степан Тополь', 182, 76, 18, 'nkAAVxn@gmail.com', 'Молодежь', 'M', 'A', 13, 10);
INSERT INTO ballroom_database.dancer
VALUES (102, 'Нелли Травникова', 173, 57, 18, 'JbtIdbp@gmail.com', 'Молодежь', 'A', 'S', 7, 11);

INSERT INTO ballroom_database.club
VALUES (12, 'Звездочка', 500, 'Самара');

INSERT INTO ballroom_database.couple
VALUES (55, 101, 102, 12, '2021-12-18', '9999-12-31');

INSERT INTO ballroom_database.coach
VALUES (21, 12, 'yEgWxTX@gmail.com', 'Евгений Окуневский', 'Вторая', 35, 14);

INSERT INTO ballroom_database.competition
VALUES (11, 'Летние ритмы', 'Самара', 'Международные', 1350.0, 1700.0);

INSERT INTO ballroom_database.competition_category
VALUES (12, 11, 'Молодежь', 'A', 'Latin');

INSERT INTO ballroom_database.registered_couples
VALUES (12, 55);

INSERT INTO ballroom_database.couple_x_coach
VALUES (55, 21, 'Standard');

INSERT INTO ballroom_database.scores
VALUES (12, 55, 'S', 8, 40);

INSERT INTO ballroom_database.judging_panel
VALUES (12, 3);

-- R -- Read <-> SELECT

SELECT *
FROM ballroom_database.dancer as d
WHERE d.dancer_age < 23
  AND d.dancer_class_latin = 'A';

SELECT AVG(viewer_cost_amt)
FROM ballroom_database.competition as c
WHERE c.location = 'Москва';

-- U -- Update <-> UPDATE

UPDATE ballroom_database.dancer as d
SET dancer_name = 'Вася Пупкин'
WHERE d.dancer_id = 101;

UPDATE ballroom_database.dancer as d
SET dancer_class_latin = 'E'
WHERE d.dancer_name = 'Вася Пупкин';

-- D -- Delete <-> DELETE
DELETE
FROM ballroom_database.judging_panel as j
WHERE j.competition_category_id = 12
  AND j.judge_id = 3;

DELETE
FROM ballroom_database.scores as sc
WHERE sc.competition_category_id = 12
  AND sc.couple_id = 55;

DELETE
FROM ballroom_database.couple_x_coach as cxc
WHERE cxc.couple_id = 55
  AND cxc.coach_id = 21;

DELETE
FROM ballroom_database.registered_couples as r
WHERE r.competition_category_id = 12
  AND r.couple_id = 55;

DELETE
FROM ballroom_database.competition_category as c
WHERE c.competition_category_id = 12;

DELETE
FROM ballroom_database.coach as c
WHERE c.coach_id = 21;

DELETE
FROM ballroom_database.couple as c
WHERE couple_id = 55;

DELETE
FROM ballroom_database.club as c
WHERE c.club_id = 12;




DELETE
FROM ballroom_database.competition as c
WHERE c.competition_id = 11;

DELETE
FROM ballroom_database.dancer as d
WHERE d.dancer_id = 101;

DELETE
FROM ballroom_database.dancer as d
WHERE d.dancer_id = 102;

