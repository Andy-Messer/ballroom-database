-- Задача:
--   Для Регины Абрамовой посчитать, как долго она не стояла в паре(в днях), начиная с '2020-11-02' по '2022-12-30',
--   построить топ перерывов по длительности.

-- <func>(...) OVER(...): все 3 типа функций
------------------------------------------------------------------------------------------------------------------------
WITH dancer_info as (SELECT dc.couple_id, dc.dancing_date_valid_from, dc.dancing_date_valid_to
                     FROM (ballroom_database.dancer as d
                         JOIN ballroom_database.couple as c ON c.dancer_second_partner_id = d.dancer_id) as dc
                     WHERE dc.dancer_name = 'Регина Абрамова'),
     t1 as (SELECT couple_id, LAG(dancer_info.dancing_date_valid_to) OVER (ORDER BY couple_id) as last_dancing_date
            FROM dancer_info),
     t2 as (SELECT couple_id, dancer_info.dancing_date_valid_from
            FROM dancer_info),
     breaks as (SELECT CASE
                           WHEN last_dancing_date is null THEN NULL
                           ELSE t2.dancing_date_valid_from - t1.last_dancing_date END as amt_of_days,
                       t2.dancing_date_valid_from                                     as time_info_valid_to
                FROM t1
                         JOIN t2 ON t1.couple_id = t2.couple_id),
     clear_breaks as (SELECT * FROM breaks WHERE breaks IS NOT NULL)
SELECT ROW_NUMBER() OVER (ORDER BY amt_of_days) as top,
       amt_of_days,
       SUM(amt_of_days) OVER (ORDER BY amt_of_days) sum_days_in_break,
       time_info_valid_to
FROM clear_breaks;


