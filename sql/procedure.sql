-- Триггер-функция для триггера trigger_rating
-- Обновляет рейтинг танцоров в определенной категории при добавлении новых участий в соревнованиях,
-- при условии, что пара заняла 1 - 5 места (прибавляется от 5 до 1 очка соответственно).

CREATE OR REPLACE FUNCTION ballroom_database.update_rating() RETURNS TRIGGER AS
$$
BEGIN
    IF ((SELECT dances_category
         FROM ballroom_database.competition_category
         WHERE competition_category_id = NEW.competition_category_id
         LIMIT 1) = 'Latin') THEN
        UPDATE ballroom_database.dancer
        SET dancer_points_latin = dancer_points_latin + (6 - NEW.place)
        WHERE NEW.place <= 5
          AND (dancer_id = (SELECT dancer_first_partner_id
                            FROM ballroom_database.couple
                            WHERE couple.couple_id = NEW.couple_id
                            LIMIT 1) OR dancer_id = (SELECT dancer_second_partner_id
                                                     FROM ballroom_database.couple
                                                     WHERE couple.couple_id = NEW.couple_id
                                                     LIMIT 1));
    ELSE
        UPDATE ballroom_database.dancer
        SET dancer_points_standard = dancer_points_standard + (6 - NEW.place)
        WHERE NEW.place <= 5
          AND (dancer_id = (SELECT dancer_first_partner_id
                            FROM ballroom_database.couple
                            WHERE couple.couple_id = NEW.couple_id
                            LIMIT 1) OR dancer_id = (SELECT dancer_second_partner_id
                                                     FROM ballroom_database.couple
                                                     WHERE couple.couple_id = NEW.couple_id
                                                     LIMIT 1));
    END IF;
    RETURN old;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ballroom_database.next_category(old_category VARCHAR(1)) RETURNS VARCHAR(1) AS
$$
DECLARE
    new_category VARCHAR(1);
BEGIN
    IF (old_category = 'E') THEN
        new_category = 'D';
    ELSIF (old_category = 'D') THEN
        new_category = 'C';
    ELSIF (old_category = 'C') THEN
        new_category = 'B';
    ELSIF (old_category = 'B') THEN
        new_category = 'A';
    ELSIF (old_category = 'A') THEN
        new_category = 'S';
    ELSIF (old_category = 'S') THEN
        new_category = 'M';
    ELSIF (old_category = 'M') THEN
        new_category = 'M';
    END IF;

    RETURN new_category;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION ballroom_database.update_category() RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.dancer_points_latin >= 17 THEN
        UPDATE ballroom_database.dancer
        SET dancer_points_latin = 0,
            dancer_class_latin  = (SELECT ballroom_database.next_category(dancer_class_latin))
        WHERE dancer_id = NEW.dancer_id;
    END IF;
    IF NEW.dancer_points_standard >= 17 THEN
        UPDATE ballroom_database.dancer
        SET dancer_points_standard = 0,
            dancer_class_standard  = (SELECT ballroom_database.next_category(dancer_class_standard))
        WHERE dancer_id = NEW.dancer_id;
    END IF;
    RETURN old;
END;
$$ LANGUAGE plpgsql;