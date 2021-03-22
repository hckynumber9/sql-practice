-- https://sqlzoo.net/wiki/Window_functions

-- Window functions: LAG, LEAD, RANK, NTILE

-- 1.
SELECT lastName, party, votes
  FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY votes DESC

-- 2. RANK function
SELECT party, votes,
       RANK() OVER (ORDER BY votes DESC) as posn
  FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY party

-- 3. PARTITION
SELECT yr, party, votes,
      RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as posn
FROM ge
WHERE constituency = 'S14000021'
ORDER BY party, yr

-- 4.
SELECT constituency, party, votes,
       RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) 
       as posn
FROM ge
WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
  AND yr  = 2017
ORDER BY posn, constituency

-- 5.
SELECT constituency, party 
FROM (SELECT constituency, party, votes,
       RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) 
       as posn
      FROM ge
      WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
            AND yr  = 2017
      ) winners
WHERE winners.posn=1

-- 6.
SELECT party, COUNT(*) 
FROM (
      SELECT constituency, party, votes,
             RANK() OVER (PARTITION BY constituency ORDER BY votes 
             DESC) as posn
      FROM ge
      WHERE constituency LIKE 'S%'
            AND yr  = 2017
     ) rk
WHERE rk.posn=1
GROUP BY rk.party

--------------------------------------
-- Window LAG (https://sqlzoo.net/wiki/Window_LAG)

-- 1.
SELECT name, DAY(whn),
       confirmed, deaths, recovered
FROM covid
WHERE name = 'Spain'
AND MONTH(whn) = 3
ORDER BY whn

-- 2.
SELECT name, DAY(whn), confirmed,
       LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) as dbf
FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3
ORDER BY whn

-- 3.
SELECT name, DAY(whn),
       confirmed - (LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)) as new
FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3
ORDER BY whn

-- 4.
SELECT name, DATE_FORMAT(whn,'%Y-%m-%d'), 
       confirmed - (LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)) as new
FROM covid
WHERE name = 'Italy'
AND WEEKDAY(whn) = 0
ORDER BY whn

-- 5.
SELECT tw.name, DATE_FORMAT(tw.whn,'%Y-%m-%d'), 
 tw.confirmed - lw.confirmed as new
FROM covid tw 
LEFT JOIN covid lw 
ON DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn
  AND tw.name=lw.name
WHERE tw.name = 'Italy'
  AND WEEKDAY(tw.whn) = 0
ORDER BY tw.whn

-- 6.
SELECT name, confirmed,
       RANK() OVER (ORDER BY confirmed DESC) rc, 
       deaths,
       RANK() OVER (ORDER BY deaths DESC) rd
FROM covid
WHERE whn = '2020-04-20'
ORDER BY confirmed DESC

-- 7.
SELECT world.name, 
       round(100000*confirmed/population, 0) AS infect,
       RANK() OVER (ORDER BY confirmed/population) AS rank
FROM covid 
JOIN world 
ON covid.name=world.name
WHERE whn = '2020-04-20' AND population > 10000000
ORDER BY population DESC

-- 8. (Still not correct)
SELECT name, DATE_FORMAT(whn+1,'%Y-%m-%d'), 
       MAX(new) FROM (SELECT name, whn, confirmed - (LAG(confirmed, 1) OVER (PARTITION BY 
             name ORDER BY whn)) as new
      FROM covid 
    ) covid2
WHERE covid2.new >= 1000
GROUP BY name
ORDER BY 2