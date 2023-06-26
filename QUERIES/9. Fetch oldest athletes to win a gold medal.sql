-- 9. Fetch oldest athletes to win a gold medal
    with temp as
            (select name,sex, age
              ,team,games,city,sport, event, medal
            from olympic_history
			where age <> 'NA'),
        ranking as
            (select *, rank() over(order by age desc) as rnk
            from temp
            where medal='Gold')
    select *
    from ranking
    where rnk = 1;
