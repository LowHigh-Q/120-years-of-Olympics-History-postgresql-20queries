-- 12. Fetch the top 5 athletes who have won the most medals (gold/silver/bronze).
WITH Athlete as
(SELECT name
,team
, count(1) as total_medals
FROM public.olympic_history
WHERE MEDAL <> 'NA'
GROUP BY name,team
ORDER BY total_medals DESC),
ranking as
(SELECT *
 ,dense_rank() over (ORDER BY total_medals DESC) as rnk
 FROM Athlete
)
SELECT name
,team
, total_medals
FROM ranking
WHERE rnk <=5