-- 7. Which Sports were just played only once in the olympics.
WITH t1 as
(SELECT distinct Games, Sport
FROM public.olympic_history
 ORDER BY games 
),
t2 as 
(
	SELECT sport, count(1) as total_no
	FROM t1
	GRoup BY sport
)
SELECT tt.* 
FROM t2 tt
Join t1 t ON t.sport = tt.sport
Where total_no = 1
order by sport



  