# 1. List the films where the yr is 1962 [Show id, title]
SELECT id, title
FROM movie
WHERE yr=1962

# 2. Give year of 'Citizen Kane'.
SELECT yr
FROM movie
WHERE title='Citizen Kane'

# 3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY 3

# 4. What id number does the actor 'Glenn Close' have?
SELECT id
FROM actor
WHERE name='Glenn Close'

# 5. What is the id of the film 'Casablanca'
SELECT id
FROM movie
WHERE title='Casablanca'

# 6. Obtain the cast list for 'Casablanca'.
SELECT a.name 
FROM actor a
JOIN casting c
ON a.id=c.actorid
WHERE c.movieid=27

# 7. Obtain the cast list for the film 'Alien'
SELECT a.name
FROM actor a
JOIN casting c
ON a.id=c.actorid
JOIN movie m
ON m.id=c.movieid
WHERE m.title='Alien'

# 8. List the films in which 'Harrison Ford' has appeared
SELECT m.title
FROM movie m
JOIN casting c
ON m.id=c.movieid
JOIN actor a
ON c.actorid=a.id
WHERE a.name='Harrison Ford'

# 9. List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
SELECT m.title
FROM movie m
JOIN casting c
ON m.id=c.movieid
JOIN actor a
ON c.actorid=a.id
WHERE a.name='Harrison Ford'
  AND c.ord!=1
    
# 10. List the films together with the leading star for all 1962 films.
SELECT m.title, a.name
FROM movie m
JOIN casting c
ON m.id=c.movieid
JOIN actor a
ON c.actorid=a.id
WHERE m.yr=1962
  AND c.ord=1
    
# 11. Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT m.yr, COUNT(m.title)
FROM movie m
JOIN casting c
ON m.id=c.movieid
JOIN actor a
ON c.actorid=a.id
WHERE a.name='Rock Hudson'
GROUP BY m.yr
HAVING COUNT(m.title) > 1

# 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT m.title, a.name
FROM movie m
JOIN casting c
ON m.id=c.movieid
JOIN actor a
ON a.id=c.actorid
WHERE c.movieid IN (SELECT c.movieid 
                    FROM casting c
                    JOIN actor a
                    ON a.id=c.actorid
                    WHERE a.name='Julie Andrews')
  AND c.ord=1
    
# 13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
SELECT DISTINCT a.name
FROM actor a
JOIN casting c
ON a.id=c.actorid
WHERE c.actorid IN  
  (SELECT actorid
   FROM casting
   WHERE ord=1
   GROUP BY actorid
   HAVING COUNT(actorid) >= 15)
ORDER BY 1

# 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT m.title, COUNT(c.actorid)
FROM movie m
JOIN casting c
ON m.id=c.movieid
WHERE m.yr=1978
GROUP BY c.movieid, m.title
ORDER BY 2 DESC, 1

# 15. List all the people who have worked with 'Art Garfunkel'.
SELECT a.name
FROM actor a
JOIN casting c
ON a.id=c.actorid
WHERE a.name!='Art Garfunkel'
  AND c.movieid IN
    (SELECT c.movieid
     FROM casting c
     JOIN actor a
     ON c.actorid=a.id
     WHERE a.name='Art Garfunkel')