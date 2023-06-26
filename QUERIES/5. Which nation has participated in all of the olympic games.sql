-- 5. Which nation has participated in all of the olympic games
with total_part as
(
SELECT nr.region as Country, count(distinct games) as total_particifated_games
FROM public.olympic_history nh
JOIN public.olympic_history_noc_regions nr ON nh.noc = nr.noc
GROUP BY nr.region
),
total_count as
(
SELECT count(DISTINCT games ) as total
FROM olympic_history
)
SELECT tp.*
FROM total_part as tp
JOIN total_count tc ON tp.total_particifated_games = tc.total
