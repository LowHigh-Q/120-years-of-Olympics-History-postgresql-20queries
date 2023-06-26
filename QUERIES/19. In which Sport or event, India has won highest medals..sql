-- 19. In which Sport/event, India has won highest medals.

WITH tab1 as 
(SELECT  sport, count(medal) as total_medals
FROM public.olympic_history nh
JOIN public.olympic_history_noc_regions nr ON nr.noc = nh.noc
WHERE team = 'India' and medal <> 'NA'
GROUP BY sport 
ORDER BY total_medals DESC
)
SElECT FIRST_VALUE(sport) over(ORDER BY total_medals DESC)
, FIRST_VALUE(total_medals) over(ORDER BY total_medals DESC) 
FROM tab1
limit 1