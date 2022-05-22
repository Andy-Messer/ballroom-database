CREATE TRIGGER trigger_rating
    AFTER INSERT
    ON ballroom_database.scores
    FOR EACH ROW
EXECUTE PROCEDURE ballroom_database.update_rating();

-- Проверяем, что триггер работает - действительно, у 1 пары рейтинг по стандарту обновился на 4.

INSERT INTO ballroom_database.scores
VALUES (2, 1, 'Q', 92, 2);

INSERT INTO ballroom_database.registered_couples
VALUES (2, 1);

CREATE TRIGGER trigger_rating
    AFTER UPDATE
    ON ballroom_database.dancer
    FOR EACH ROW
EXECUTE PROCEDURE ballroom_database.update_category();

-- Проверяем, что триггер работает - действительно, у 46 пары партнер перешёл на
-- следующую категорию в латине, а рейтинг обнулился

INSERT INTO ballroom_database.scores
VALUES (3, 46, 'Q', 105, 1);

INSERT INTO ballroom_database.registered_couples
VALUES (3, 46);