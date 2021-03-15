# Practice SQL from Codecademy for review.

CREATE TABLE friends (
  id INTEGER,
  name TEXT,
  birthday DATE
);

INSERT INTO friends (id, name, birthday)
VALUES (1, 'Ororo Munroe', '1940-05-30');

INSERT INTO friends (id, name, birthday)
VALUES (2, 'Mike Mike', '1950-05-30'),
       (3, 'Joe Joe', '1960-06-30');

ALTER TABLE friends
ADD COLUMN email TEXT;

UPDATE friends
SET email = 'storm@codecademy.com'
WHERE id=1;

SELECT * FROM friends;

-----------------------------------------

SELECT imdb_rating AS 'IMDb'
FROM movies;

SELECT name,
  CASE
    WHEN genre='romance' THEN 'Chill'
    WHEN genre='comedy' THEN 'Chill'
    ELSE 'Intense'
  END AS 'Mood'
FROM movies;

SELECT price,
  ROUND(AVG(downloads)),
  COUNT(*)
FROM fake_apps
GROUP BY price
HAVING COUNT(*) > 10;

SELECT CASE
   WHEN url LIKE '%github.com%' THEN 'GitHub'
   WHEN url LIKE '%medium.com%' THEN 'Medium'
   WHEN url LIKE '%nytimes.com%' THEN 'New York Times'
   ELSE 'Other'
  END AS 'Source',
  COUNT(*)
FROM hacker_news
GROUP BY 1;

SELECT strftime('%H', timestamp) as 'Hour', 
   ROUND(AVG(score), 1) as 'Average Score',
   COUNT(*) as 'Stories'
FROM hacker_news
WHERE timestamp IS NOT NULL
GROUP BY 1
ORDER BY 1;

-----------------------------------------

SELECT *
FROM table1
UNION
SELECT *
FROM table2;

WITH previous_query AS (
  SELECT customer_id,
    COUNT(subscription_id) AS 'subscriptions'
  FROM orders
  GROUP BY customer_id
  )
SELECT customers.customer_name, previous_query.subscriptions
FROM previous_query
JOIN customers
ON previous_query.customer_id=customers.customer_id;

