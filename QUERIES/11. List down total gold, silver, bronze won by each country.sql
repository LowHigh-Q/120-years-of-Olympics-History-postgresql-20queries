--11. List down total gold, silver, bronze won by each country
SELECT nr.region as Country, medal, count(1) as total_medals
FROM olympic_history oh
join olympic_history_noc_regions nr on nr.noc = oh.noc
WHERE medal <> 'NA'
GROUP BY Country, medal
Order BY Country, medal;

-- "Botswana"	"Silver"	1
-- "Bermuda"	"Bronze"	1
-- Use crosstab to convert to columsn to rows
-- in order to use cross use [CREATE EXTENSION tablefuc;]

-- CREATE EXTENSION tablefunc;

SELECT Country
, Coalesce(gold,0) as Gold
, Coalesce(Silver,0) as Silver
, Coalesce(Bronze,0) as Bronze
FROM crosstab('SELECT nr.region as Country, medal, count(1) as total_medals
FROM olympic_history oh
join olympic_history_noc_regions nr on nr.noc = oh.noc
WHERE medal <> ''NA'' 
GROUP BY Country, medal
Order BY Country, medal;',
'values (''Bronze''),(''Silver''), (''Gold'')')
as result(Country VARCHAR, Bronze BIGINT, Silver BIGINT, Gold BIGINT)
ORDER BY Gold DESC, Silver DESC, Bronze DESC;

-- ,
-- 'values (''Bronze''),(''Gold''),(''Silver'')')

-- rules: 1. pass it as string
-- 2. Can only have 3 columns 
--  i. Main column
--  ii. For Ordering
--  iii. aggregaters 
-- also need to specify the result