-- 16. Identify which country won the most gold, most silver and most bronze medals in
--each olympic?
SELECT * From olympic_history;

WITH temp as (
SELECT SUBSTRING(Games_Country,1,POSITION('-' IN Games_country)-1 )AS games
, SUBSTRING(Games_Country,POSITION('-' IN Games_country)+1 )AS Country
, Coalesce(gold,0) as Gold
, Coalesce(Silver,0) as Silver
, Coalesce(Bronze,0) as Bronze
FROM crosstab('SELECT CONCAT(Games, ''-'', nr.region) as Games_Country, medal, count(1) as total_medals
FROM olympic_history oh
join olympic_history_noc_regions nr on nr.noc = oh.noc
WHERE medal <> ''NA'' 
GROUP BY games, Games_Country, medal
Order BY games, Games_Country, medal;',
'values (''Bronze''),(''Silver''), (''Gold'')')
as result(Games_Country VARCHAR, Bronze BIGINT, Silver BIGINT, Gold BIGINT)
ORDER BY Games_Country
	) 
	
	SELECT distinct games
	,CONCAT(first_value(Country) over(partition by games order by gold desc) , ' - '
		   ,first_value(gold) over(partition by games order by gold desc)) as max_gold
	,CONCAT(first_value(Country) over(partition by games order by SILVER desc) , ' - '
		   ,first_value(SILVER) over(partition by games order by SILVER desc)) as max_silver
	,CONCAT(first_value(Country) over(partition by games order by Bronze desc) , ' - '
		   ,first_value(Bronze) over(partition by games order by Bronze desc)) as max_bronze
	FROM Temp
	order by games;