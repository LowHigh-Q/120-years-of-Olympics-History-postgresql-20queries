--16. Identify which country won the
--most gold, most silver and most bronze medals in each olympic games.

-- WINDOW FUNCTION IS USED "" PARTITION "" MAINLY

WITH temp as
    	(SELECT substring(games, 1, position(' - ' in games) - 1) as games
    	 	, substring(games, position(' - ' in games) + 3) as country
            , coalesce(gold, 0) as gold
            , coalesce(silver, 0) as silver
            , coalesce(bronze, 0) as bronze
    	FROM CROSSTAB('SELECT concat(games, '' - '', nr.region) as games
    					, medal
    				  	, count(1) as total_medals
    				  FROM olympic_history oh
    				  JOIN olympic_history_noc_regions nr ON nr.noc = oh.noc
    				  where medal <> ''NA''
    				  GROUP BY games,nr.region,medal
    				  order BY games,medal',
                  'values (''Bronze''), (''Gold''), (''Silver'')')
    			   AS FINAL_RESULT(games text, bronze bigint, gold bigint, silver bigint))
				   
		SELECT DISTINCT games,concat(first_value(country)over (partition by games order by gold desc)
									 ,' - '
									 ,first_value(gold) over (partition by games order by gold desc)) as max_gold
									 
									 ,concat(first_value(country)over (partition by games order by Silver desc)
									 ,' - '
									 ,first_value(gold) over (partition by games order by silver desc)) as max_silver
									 
									 ,concat(first_value(country)over (partition by games order by Bronze desc)
									 ,' - '
									 ,first_value(gold) over (partition by games order by Bronze desc)) as max_Bronze
									 
		FROM temp
		ORDER BY games