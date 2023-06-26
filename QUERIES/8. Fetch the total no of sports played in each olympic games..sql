-- 8. Fetch the total no of sports played in each olympic games.
SELECT games, count(distinct sport) as ssis
FROM public.olympic_history
GROUP BY games
ORDER BY ssis desc,games

