-- 20. Break down all olympic games where India won medal 
--for Hockey and how many medals in each olympic games

SELECT team, sport, games, count(medal) as total_medals
FROM public.olympic_history
WHERE medal <> 'NA' and team = 'India' and Sport = 'Hockey'
GROUP BY team, sport, games
Order By total_medals desc