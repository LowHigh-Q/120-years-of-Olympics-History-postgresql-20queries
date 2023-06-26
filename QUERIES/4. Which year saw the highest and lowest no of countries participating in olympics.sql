-- 4. Which year saw the highest and lowest no of countries participating in olympics
With all_countries as
(select games, nr.region
              from olympic_history oh
              join olympic_history_noc_regions nr ON nr.noc=oh.noc
              group by games, nr.region),
tota_contries as
(
	select games, count(1) as total_contries
	from all_countries
	group by games
)
Select concat(first_value(games) over (order by total_contries)
, ' - '
,first_value(total_contries) over (order by total_contries)) as lowest_countries
,concat(first_value(games) over (order by total_contries desc)
, ' - '
,first_value(total_contries) over (order by total_contries desc)) as highest_countries
FROM tota_contries limit 1
