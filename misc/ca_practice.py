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

