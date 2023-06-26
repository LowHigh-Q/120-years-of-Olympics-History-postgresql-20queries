-- 6. Identify the sport which was played in all summer olympics.

WITH t1 as
( SELECT count(distinct games) as total_games
 FROM public.olympic_history
 WHERE Season = 'Summer'
),
t2 as
(
	Select distinct games, sport
	FROM public.olympic_history
	WHERE Season = 'Summer'
	ORDER By Games
),
t3 as
( SELECT sport, count(1) as total_no_of_games
 FROM t2
 GROUP BY sport
)
SELECt Sport FROM t3
JOIN t1 ON t1.total_games = t3.total_no_of_games