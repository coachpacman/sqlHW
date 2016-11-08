/* #1. Select all columns and rows from the movies table */

SELECT * FROM movies;

/* #2. Select only the title and id of the first 10 rows */

SELECT title, movieid
FROM movies
WHERE movieid < 11;


/* #3. Find the movie with the id of 485 */

SELECT title, movieid
FROM movies
WHERE movieid = '485';


/* #4. Find the id (only that column) of the movie Made in America (1993) */

SELECT movieid
FROM movies
WHERE title = 'Made in America (1993)';

/* #5. Find the first 10 sorted alphabetically */

SELECT title, movieid
FROM movies
WHERE movieid < 10
ORDER by title ASC;

/* #6. Find all movies from 2002 */

SELECT title, movieid
FROM movies
WHERE title like '%2002%';

/* #7. Find out what year the Godfather came out */

SELECT title, movieid
FROM movies
WHERE title like '%Godfather%'
GROUP BY movieid;


/* #8. Without using joins find all the comedies */

SELECT movieid, title, genres
FROM movies
WHERE genres like '%Comedy%';

/* #9. Find all comedies in the year 2000 */

SELECT movieid, title, genres
FROM movies
WHERE genres like '%Comedy%' AND title like '%(2000)%';

/* #10. Find any movies that are about death and are a comedy */

SELECT movieid, title, genres
FROM movies
WHERE title like '%Death%' AND genres like '%Comedy%';

/* #11. Find any movies from either 2001 or 2002 with a title containing super */

SELECT movieid, title, genres
FROM movies
WHERE (title like '%(2001)%' OR title like '%(2002)%') AND title like '%Super%';

/* #12. Find all the ratings for the movie Godfather, show just the title and the rating */

SELECT movies.title, ratings.rating
FROM movies
INNER JOIN ratings
ON movies.movieid = ratings.movieid
WHERE movies.title like '%Godfather%';

/* #13. Order the previous objective by newest to oldest */

SELECT movies.title, ratings.rating
FROM movies
INNER JOIN ratings
ON movies.movieid = ratings.movieid
WHERE movies.title like '%Godfather%'
ORDER BY movies.movieid DESC;

/* #14. Find the comedies from 2005 and get the title and imdbid from the links table */

SELECT movies.movieid, movies.title, movies.genres, links.imdbid
FROM movies
INNER JOIN links
  ON movies.movieid = links.movieid
WHERE movies.title LIKE '%(2005)%' AND movies.genres LIKE '%Comedy%';


/* #15. Find all movies that have no ratings */
SELECT movies.movieid, movies.title, movies.genres, ratings.rating
FROM movies
LEFT JOIN ratings
  ON movies.movieid = ratings.movieid
WHERE ratings.rating IS NULL;

/* #16. Find all fantasy movies using the many to many join between movies and genres through movie_genre table. */
SELECT m.movieid AS Movies_movieId, m.title, m.genres AS Movies_genres,m_g.movieid, genre_id
FROM movies m
JOIN movie_genre m_g
	ON m.movieid = m_g.movieid
JOIN genre g
	ON g.id = m_g.genre_id
WHERE m.genres LIKE '%Fantasy%';

/* #17. Use concat and research about internet movie database to produce a valid url from the imdbid */

SELECT movies.title, CONCAT('http://www.imdb.com/title/tt0', links.imdbid, '/?ref_=fn_al_tt_1'), links.imdbid, links.tmdbid
FROM movies
LEFT JOIN links
  ON movies.movieid = links.movieid
WHERE links.imdbid IS NOT NULL;


/* #18. Use concat and research about the movie database to produce a valid url from tmdbid */

select m.title, 'https://www.themoviedb.org/movie/' || l.tmdbid || '-' || replace(
			left(
				m.title, char_length(m.title) - 7
			),
			' ',
			'-'
		) as url, l.tmdbid
from movies m
join links l on m.movieid = l.movieid;

/* #19. Get the ratings for The Usual Suspects and convert the timestamp into a human readable date time */

SELECT movies.title, movies.movieid, ratings.rating, to_timestamp(ratings.timestamp)
FROM movies
LEFT JOIN ratings
	ON movies.movieid = ratings.movieid
WHERE movies.title LIKE '%Usual%';

/* #20. Using SQL normalize the tags in the tags table. Make them lowercased and replace the spaces with - */

SELECT lower(
					 replace(
							 tag,
							 ' ',
							 '-'
					 )
			 ) as "normalized tags"
FROM tags;

/* #21. The movie_genre table was produced by a sql query that could match a movie to the appropriate rows in genre without the use of the join table. Reproduce that query. */
SELECT *, g.id AS genre_id
FROM movies m
JOIN genre g 
	ON m.genres LIKE CONCAT('%', g.genres, '%');
