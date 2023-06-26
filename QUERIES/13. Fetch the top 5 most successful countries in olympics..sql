-- 13. Fetch the top 5 most successful countries in olympics. 
-- Success is defined by no of medals won.

With top as
( SELECT nr.region as region, Count(1) as total_medals
 FROM public.olympic_history nh
 JOIN public.olympic_history_noc_regions nr ON nr.noc = nh.noc
  WHERE nh.medal <> 'NA'
 GROUP BY nr.region
 ORDER BY total_medals DESC
),
ranking as
( SELECT *,dense_rank() OVER (ORDER BY total_medals DESC) as rnk
 FROM top
)
SELECt region, total_medals, rnk
FROM Ranking
WHERe rnk <=5