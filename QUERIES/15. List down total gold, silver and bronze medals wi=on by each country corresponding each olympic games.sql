--15. List down total gold, silver and bronze medals 
-- won by each country corresponding to each olympic games.



SELECT SUBSTRING(Game_Country,1,POSITION(' - ' in Game_Country)-1) as games
,SUBSTRING(Game_Country,POSITION(' - ' in Game_Country)+3) as Country
,Coalesce(gold,0) as gold
,Coalesce(Silver,0) as silver
,Coalesce(bronze,0) as bronze
FROM CROSSTAB('
SELECT CONCAT( nh.games,'' - '',nr.region) as games_Country_won , medal, count(1) as medals
FROM public.olympic_history nh
JOIN public.olympic_history_noc_regions nr ON nh.noc = nr.noc
WHERE medal <> ''NA''
GROUP BY games_Country_won,medal
ORDER BY games_Country_won,medal',
			 'Values (''Bronze''),(''Gold''),(''Silver'')') 
as result(Game_Country VARCHAR, Bronze BIGINT, Gold BIGINT, Silver BIGINT)

