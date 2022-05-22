-- Данное представление позволяет провести анализ обезличенных данных о танцорах клуба

CREATE VIEW ballroom_database.protected_dancer_info AS
SELECT md5(dancer_name)                                                                       AS dancer_name,
       dancer_age_category,
       'xxx' || RIGHT(dancer_email, LENGTH(dancer_email) - POSITION('@' IN dancer_email) + 1) AS dancer_email,
       dancer_class_standard,
       dancer_class_latin,
       dancer_points_standard,
       dancer_points_latin
FROM ballroom_database.dancer;

-- Данное представление позволяет провести анализ обезличенных данных о тренерах клуба

CREATE VIEW ballroom_database.protected_coach_info AS
SELECT md5(coach_name)                                                                     AS coach_name,
       judge_category,
       'xxx' || RIGHT(coach_email, LENGTH(coach_email) - POSITION('@' IN coach_email) + 1) AS coach_email,
       coach_rating,
       dirty_judging_points
FROM ballroom_database.coach;


-- Данное представление позволяет узнать список пар с id пары и именами партнёров
CREATE VIEW ballroom_database.couples_names AS
SELECT couple_id, first_partner, dancer.dancer_name AS second_partner
FROM (SELECT couple_id, dancer.dancer_name AS first_partner, couple.dancer_second_partner_id
      FROM ballroom_database.couple
               INNER JOIN ballroom_database.dancer
                          ON couple.dancer_first_partner_id = dancer.dancer_id) as first_partner_name
         INNER JOIN ballroom_database.dancer ON first_partner_name.dancer_second_partner_id = dancer.dancer_id;


-- Данное представление позволяет узнать полный список соревнований, в каждом участвовала пара, их ФИО,
-- уровень соравнования, локация соревнования, танец, число очков и место

CREATE VIEW ballroom_database.competition_info AS
SELECT competition.competition_name,
       competition.location,
       competition.competition_lvl,
       scores.couple_id,
       first_partner,
       second_partner,
       dance,
       points,
       place
FROM ballroom_database.couples_names
         JOIN ballroom_database.scores ON couples_names.couple_id = scores.couple_id
         JOIN ballroom_database.competition_category
              ON scores.competition_category_id = competition_category.competition_category_id
         JOIN ballroom_database.competition ON competition_category.competition_id = competition.competition_id;


-- Данное представление позволяет узнать рейтинг тренеров по количеству тренируемых пар танцоров и их очкам,
-- которые они заработали, чтобы выплатить, например, премию.

CREATE VIEW ballroom_database.coach_bonus AS
SELECT coach_name, SUM(points) AS points, COUNT(*) AS couples_number, club_id
FROM (SELECT couple_id, SUM(points) AS points
      FROM ballroom_database.competition_info
      GROUP BY couple_id) as couples_points
         JOIN ballroom_database.couple_x_coach ON couples_points.couple_id = couple_x_coach.couple_id
         JOIN ballroom_database.coach ON couple_x_coach.coach_id = coach.coach_id
GROUP BY coach.coach_id, coach.coach_name
ORDER BY points DESC, couples_number DESC;

-- Данное представление позволяет узнать статистику каждого клуба: название, локацию,
-- число тренеров, число тренируемых пар и рейтинг.

CREATE VIEW ballroom_database.club_statistics AS
SELECT club_name, location, coaches_number, couples_number, club_rating
FROM (SELECT club_id, COUNT(*) as coaches_number, SUM(couples_number) AS couples_number
FROM ballroom_database.coach_bonus
GROUP BY club_id) as coaches_x_club
JOIN ballroom_database.club ON coaches_x_club.club_id = club.club_id
ORDER BY club_rating DESC;

