-- 10. Find the Ratio of male and female athletes participated in all olympic games.

With t1 as
( SELECT Sex, count(1) as cnt
 FROM public.olympic_history
 GROUP BY SEX
),
t2 as
( SELecT cnt,row_number() over(ORDER BY cnt desc) as rn
 FROM t1
),
first as
( SELECT cnt from t2 where rn=1
)
,
second as
( SELECT cnt from t2 where rn=2
)
SELECT  CONCAT('1 : ', round(first.cnt::decimal/second.cnt,2))
FROM first,second
