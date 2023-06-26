--14. List down total gold, silver and bronze medals won by each country.


SELECT country
, coalesce(gold,0) as gold
, coalesce(silver,0) as silver
, coalesce(bronze,0) as bronze
FROM CROSSTAB('SELECT nr.region as country,medal, count(1) as total_medals
FROM public.olympic_history nh
jOIN public.olympic_history_noc_regions nr ON nr.noc = nh.noc
WHERE  medal <> ''NA''
GRoup By Country,medal
ORDER BY country,medal'
			  ,'values (''Bronze''),(''Gold''),(''Silver'')'
			 )
as result(country VARCHAR, bronze BIGINT, gold BIGINT, Silver BIGINT)
ORDER BY gold desc, silver desc, bronze desc;