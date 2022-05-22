-- Создание таблиц

-- Создание схемы базы данных бальных танцев
CREATE SCHEMA IF NOT EXISTS ballroom_database;

-- Информация о танцоре
CREATE TABLE IF NOT EXISTS ballroom_database.dancer
(
    dancer_id              SERIAL PRIMARY KEY,
    dancer_name            VARCHAR(255) NOT NULL,
    dancer_growth          INTEGER,
    dancer_weight          INTEGER,
    dancer_age             INTEGER      NOT NULL,
    dancer_email           VARCHAR(255),
    dancer_age_category    VARCHAR(127) NOT NULL,
    dancer_class_standard  VARCHAR(1)   NOT NULL,
    dancer_class_latin     VARCHAR(1)   NOT NULL,
    dancer_points_standard INTEGER      NOT NULL,
    dancer_points_latin    INTEGER      NOT NULL
);

-- Информация о клубе
CREATE TABLE IF NOT EXISTS ballroom_database.club
(
    club_id     SERIAL       NOT NULL,
    club_name   VARCHAR(255) NOT NULL,
    club_rating FLOAT        NOT NULL,
    location    VARCHAR(255) NOT NULL,
    PRIMARY KEY (club_id)
);

-- Информация о паре
CREATE TABLE IF NOT EXISTS ballroom_database.couple
(
    couple_id                SERIAL PRIMARY KEY,
    dancer_first_partner_id  SERIAL NOT NULL,
    dancer_second_partner_id SERIAL NOT NULL,
    club_id                  SERIAL NOT NULL,
    dancing_date_valid_from  DATE   NOT NULL,
    dancing_date_valid_to    DATE   NOT NULL,
    FOREIGN KEY (dancer_first_partner_id)
        REFERENCES ballroom_database.dancer (dancer_id),
    FOREIGN KEY (dancer_second_partner_id)
        REFERENCES ballroom_database.dancer (dancer_id),
    FOREIGN KEY (club_id)
        REFERENCES ballroom_database.club (club_id)
);

-- Информация о тренере
CREATE TABLE IF NOT EXISTS ballroom_database.coach
(
    coach_id             SERIAL       NOT NULL,
    club_id              SERIAL       NOT NULL,
    coach_email          VARCHAR(255) NOT NULL,
    coach_name           VARCHAR(255) NOT NULL,
    judge_category       VARCHAR(255) NOT NULL,
    coach_rating         FLOAT        NOT NULL,
    dirty_judging_points INTEGER      NOT NULL,
    PRIMARY KEY (coach_id),
    FOREIGN KEY (club_id) REFERENCES ballroom_database.club (club_id)
);

-- Информация о соревновании
CREATE TABLE IF NOT EXISTS ballroom_database.competition
(
    competition_id       SERIAL       NOT NULL,
    competition_name     VARCHAR(255) NOT NULL,
    location             VARCHAR(255) NOT NULL,
    competition_lvl      VARCHAR(255) NOT NULL,
    viewer_cost_amt      FLOAT        NOT NULL,
    participant_cost_amt FLOAT        NOT NULL,
    PRIMARY KEY (competition_id)
);

-- Информация о категории в соревновании
CREATE TABLE IF NOT EXISTS ballroom_database.competition_category
(
    competition_category_id SERIAL PRIMARY KEY NOT NULL,
    competition_id          SERIAL             NOT NULL,
    age_category            VARCHAR(255)       NOT NULL,
    dancers_class           VARCHAR(1)         NOT NULL,
    dances_category         VARCHAR(255)       NOT NULL,
    FOREIGN KEY (competition_id) REFERENCES ballroom_database.competition (competition_id)
);


-- Список зарегестрированных пар на категорию
CREATE TABLE IF NOT EXISTS ballroom_database.registered_couples
(
    competition_category_id SERIAL NOT NULL,
    couple_id               SERIAL NOT NULL,
    FOREIGN KEY (competition_category_id) REFERENCES ballroom_database.competition_category (competition_category_id),
    FOREIGN KEY (couple_id) REFERENCES ballroom_database.couple (couple_id)
);

-- Таблица связка "Пара-тренер"
CREATE TABLE IF NOT EXISTS ballroom_database.couple_x_coach
(
    couple_id SERIAL       NOT NULL,
    coach_id  SERIAL       NOT NULL,
    category  VARCHAR(127) NOT NULL,
    FOREIGN KEY (coach_id) REFERENCES ballroom_database.coach (coach_id),
    FOREIGN KEY (couple_id) REFERENCES ballroom_database.couple (couple_id)
);

-- Результат категории в соревновании
CREATE TABLE IF NOT EXISTS ballroom_database.scores
(
    competition_category_id SERIAL       NOT NULL,
    couple_id               SERIAL       NOT NULL,
    dance                   VARCHAR(255) NOT NULL,
    points                  INTEGER      NOT NULL,
    place                   INTEGER,
    FOREIGN KEY (competition_category_id) REFERENCES ballroom_database.competition_category (competition_category_id),
    FOREIGN KEY (couple_id) REFERENCES ballroom_database.couple (couple_id)
);

-- Судейская панель
CREATE TABLE IF NOT EXISTS ballroom_database.judging_panel
(
    competition_category_id SERIAL NOT NULL,
    judge_id                SERIAL NOT NULL,
    FOREIGN KEY (judge_id) REFERENCES ballroom_database.coach (coach_id),
    FOREIGN KEY (competition_category_id) REFERENCES ballroom_database.competition_category (competition_category_id)
);
