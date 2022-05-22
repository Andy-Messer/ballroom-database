-- Задача:
--    Вывести количество соревнований каждого уровня,
--    среднюю стоимость зрительского билета,
--    средняя стоимость которого меньше 900.
--
-- GROUP BY + HAVING
------------------------------------------------------------------------------------------------------------------------

SELECT c.competition_lvl,
       COUNT(c.competition_lvl) AS Qty_tournaments,
       AVG(c.viewer_cost_amt)   AS Avg_price_for_viewer
FROM ballroom_database.competition as c
GROUP BY c.competition_lvl
HAVING AVG(c.viewer_cost_amt) < 900;