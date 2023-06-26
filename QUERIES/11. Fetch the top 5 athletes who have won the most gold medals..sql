--11. Fetch the top 5 athletes who have won the most gold medals.
WITH athlete as 
(
	SELECT name
	,team, Count(1) as total_gold
	FROM olympic_history
	WHERE medal = 'Gold'
	GROUP BY name,team
	ORDER BY total_gold DESC
),
ranking as
( SELECT *, dense_rank() over (ORDER BY total_gold DESC ) as drnk
 FROM athlete
)
SELECT name,team, total_gold
FROM ranking
WHERE drnk <=5
