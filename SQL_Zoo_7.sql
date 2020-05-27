-- 1. List the films where the yr is 1962 [Show id, title]

SELECT id, title
 FROM movie
 WHERE yr=1962

-- 2. Give year of 'Citizen Kane'.

SELECT yr
 FROM movie
 WHERE title = 'Citizen Kane'

-- 3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.

SELECT id, title, yr
 FROM movie
 WHERE title like 'Star Trek%'

-- 4. What id number does the actor 'Glenn Close' have?

SELECT id
 FROM actor
 WHERE name = 'Glenn Close'

-- 5. What is the id of the film 'Casablanca'

SELECT id
 FROM movie
 WHERE title like 'Casablanca'

-- 6. Obtain the cast list for 'Casablanca'.

SELECT a.name
 FROM movie m, actor a, casting c
 WHERE a.id = c.actorid and m.id = c.movieid and m.title like 'Casablanca'

-- 7. Obtain the cast list for the film 'Alien'

SELECT a.name
 FROM movie m, actor a, casting c
 WHERE a.id = c.actorid and m.id = c.movieid and m.title like 'Alien'

-- 8. List the films in which 'Harrison Ford' has appeared

SELECT m.title
 FROM movie m, actor a, casting c
 WHERE a.id = c.actorid and m.id = c.movieid and a.name like 'Harrison Ford'

-- 9. List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]

SELECT m.title
 FROM movie m, actor a, casting c
 WHERE a.id = c.actorid and m.id = c.movieid and a.name like 'Harrison Ford' and c.ord <> 1

-- 10. List the films together with the leading star for all 1962 films.

SELECT m.title, a.name
 FROM movie m, actor a, casting c
 WHERE a.id = c.actorid and m.id = c.movieid and yr = 1962 and c.ord = 1

-- 11. Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 1

-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.

select m.title, a.name
from movie m, actor a, casting c
 WHERE a.id = c.actorid and m.id = c.movieid and c.ord = 1 and c.movieid IN (
SELECT movieid FROM casting
WHERE actorid IN (
  SELECT id FROM actor
  WHERE name='Julie Andrews'))

-- 13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.

SELECT DISTINCT name FROM actor
JOIN casting ON(actor.id = casting.actorid)
WHERE (SELECT COUNT(ord) FROM casting
WHERE casting.actorid = actor.id AND ord = 1) >= 15
ORDER BY name;

-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

SELECT m.title, COUNT(c.actorid) FROM movie m, casting c
WHERE id = movieid and yr = 1978
GROUP BY m.title
ORDER BY -COUNT(c.actorid), m.title;

-- 15. List all the people who have worked with 'Art Garfunkel'.

SELECT DISTINCT name FROM actor a, casting c
where id = actorid
and movieid IN(SELECT ca.movieid
FROM actor ac, casting ca
where actorid=id and name = 'Art Garfunkel') AND a.name != 'Art Garfunkel';
