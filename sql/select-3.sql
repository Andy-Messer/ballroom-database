-- Задача:
--    Вывести сводную таблицу с названиями соревнований,
--    уровнем соревнований, ценой зрительского билета
--    и средней ценой зрительского билета для этого уровня соревнований.

-- <func>(...) OVER(...): PARTITION BY
------------------------------------------------------------------------------------------------------------------------
SELECT co.competition_name,
       co.competition_lvl,
       co.viewer_cost_amt,
       AVG(co.viewer_cost_amt) OVER (PARTITION BY co.competition_lvl)
FROM ballroom_database.competition as co;