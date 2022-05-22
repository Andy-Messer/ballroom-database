-- Часто нам нужно найти человека по его ФИО (или название соревнования/клуба),
-- но у нас они расположены не в алфавитном порядке.
-- Воспользуемся индексами для оптимизации нашей базы данных.
-- Работаем в UPPERCASE, чтобы поиск был регистронезависимым.

CREATE INDEX ON ballroom_database.dancer (upper(dancer_name));
CREATE INDEX ON ballroom_database.coach (upper(coach_name));
CREATE INDEX ON ballroom_database.club (upper(club_name));
CREATE INDEX ON ballroom_database.competition (upper(competition_name));

-- Иногда мы смотрим на все соревнования какой-то пары, поэтому необходим индекс по id пары.

CREATE INDEX ON ballroom_database.scores (couple_id);
CREATE INDEX ON ballroom_database.registered_couples (couple_id);

-- Иногда мы смотрим на соревнования, где сидела конкретная судья, поэтому необходим индекс по id судьи.

CREATE INDEX ON ballroom_database.judging_panel (judge_id);

-- А иногда мы ищем все пары у конкретного тренера, поэтому необходим индекс по id тренера.
CREATE INDEX ON ballroom_database.couple_x_coach (coach_id);
