-- #1 Get the average rating for a movie
SELECT m.title, avg(r.rating) AS movie_rating
FROM ratings r
JOIN movies m
	ON m.movieid = r.movieid
GROUP BY m.title;

-- #2 Get the total ratings for a movie
SELECT m.title, count(r.rating) as countOfRatings
FROM movies m
JOIN ratings r
	ON m.movieid = r.movieid
GROUP BY m.title
ORDER BY countOfRatings DESC;

-- #3 Get the total movies for a genre

SELECT g.genres, count(g.genres)
FROM genre g
JOIN movies m
	ON m.genres LIKE concat('%', g.genres, '%')
GROUP BY g.genres
ORDER BY count DESC;

-- #4 Get the average rating for a user
SELECT userid, avg(rating) AS average_rating
FROM ratings
GROUP BY userid
ORDER BY userid ASC;

-- #5 Find the user with the most ratings
SELECT userid, count(rating) AS numb_ratings
FROM ratings
GROUP BY userid
ORDER BY numb_ratings DESC;

-- #6 Find the user with the highest average rating
SELECT userid, avg(rating)
FROM ratings
GROUP BY userid
ORDER BY avg DESC;

-- #7 Find the user with the highest average rating with more than 50 reviews
SELECT userid, count(rating) AS numb_count, avg(rating) AS avg_rating
FROM ratings
GROUP BY userid
HAVING count(rating) > 50
ORDER BY avg_rating DESC;

-- #8 Find the movies with an average rating over 4
SELECT m.title, avg(r.rating) AS avg_rating
FROM movies m
JOIN ratings r
	ON m.movieid = r.movieid
GROUP BY m.title
HAVING avg(r.rating) > 4
ORDER BY avg_rating DESC;


-- #9 For each genre find the total number of reviews as well as the average review sort by highest average review.
SELECT g.genres, count(r.rating) AS num_ratings, avg(r.rating) AS avg_rating
FROM genre g
JOIN movies m
	ON g.genres	LIKE m.genres
JOIN ratings r
	ON m.movieid = r.movieid
GROUP BY g.genres
ORDER BY avg_rating DESC;

--#10 Create a new table called actors (We are going to pretend the actor can only play in one movie) 
--The table should include name, character name, 
--foreign key to movies and date of birth at least plus an id field.



--#11 Pick 3 movies and create insert statements for 10 actors each. You should use the multi value insert statements
INSERT INTO actors(name, character_name, dob, id, moviesid)
		VALUES
			('Jerry', 'Extra 4', 'January 1 1999',4, 1),
			('Ryan', 'Extra 5', 'January 1 1997',5, 1),
			('Asher', 'Extra 6', 'January 1 2000',6, 1),
			('Astara', 'Extra 7', 'January 1 2001',7, 1),
			('Everly', 'Extra 8', 'January 1 2002',8, 1),
			('Juniper', 'Extra 9', 'January 1 2003',9, 1),
			('Wren', 'Extra 10', 'January 1 2004',10, 1),
			('Bryn', 'Extra 3', 'January 1 2005',11, 2),
			('Zinnia', 'Extra 4', 'January 1 2006',12, 2),
			('Raina', 'Extra 5', 'January 1 2007',13, 2),
			('Cleo', 'Extra 6', 'January 1 2008',14, 2),
			('Prue', 'Extra 7', 'January 1 2009',15, 2),
			('Daisy', 'Extra 8', 'January 1 2010',16, 2),
			('Delilah', 'Extra 9', 'January 1 2011',17, 2),
			('Finley', 'Extra 10', 'January 1 2012',18, 2),
			('Etta', 'Extra 1', 'January 1 1997',19, 3),
			('Edie', 'Extra 2', 'January 1 1996',20, 3),
			('Stella', 'Extra 3', 'January 1 1995',21, 3),
			('Frankie', 'Extra 4', 'January 1 1994',22, 3),
			('Stevie', 'Extra 5', 'January 1 1993',23, 3),
			('Piper', 'Extra 6', 'January 1 1992',24, 3),
			('Isla', 'Extra 7', 'January 1 1991',25, 3),
			('Clementine', 'Extra 8', 'January 1 1990',26, 3),
			('Lola', 'Extra 9', 'January 1 1989',27, 3),
			('Nola', 'Extra 10', 'January 1 1988',28, 3),
			('Callie', 'Extra 9', 'January 1 1987',29, 3),
			('Simone', 'Extra 10', 'January 1 1986',30, 3);


-- #12 Create a new column in the movie table to hold the MPAA rating. UPDATE 5 different movies to their correct rating

ALTER TABLE movies
		ADD COLUMN mpaa_rating CHAR;

UPDATE movies
		SET mpaa_rating='G'
WHERE title LIKE '%Toy Story%';

UPDATE movies
		SET mpaa_rating='G'
WHERE title LIKE '%Land Before Time%';

-- Hard Mode

-- #1. Create a new field on the movies table for the year.
-- Using an update query and a substring method update that column for every movie
-- with the year found in the title column. HINT: The pattern needed is '\d{4}'
-- and depending on how your datagrip was set up you may need to use the
-- psql command line to get the query to work.

ALTER TABLE movies
		ADD release_year_date TEXT;

UPDATE movies
	SET release_year_date = substr(title, char_length(title) - 4, 4)
WHERE release_year_date IS NULL;

SELECT *
FROM movies;

-- #2. Now that we know we can add actors create a
-- join table between actors and movies. This table should not only
-- have the foreign keys for each of the tables, include an
-- extra field for the character name for the actor.
-- Use the current actor table to populate the join table with data
-- including the character’s name

SELECT a.character_name, m.movieid AS movieId, a.id AS actorId
INTO actors_movies_table
FROM actors a
JOIN movies m
	ON a.moviesid = m.movieid;

SELECT *
FROM actors_movies_table;

-- #3 Once you have completed the new year column go through
-- the title column and strip out the year.


UPDATE movies
	SET title = left(title, char_length(title) - 7 )
WHERE 1 = 1;

SELECT *
FROM movies;

-- #4 Create a new column in the movies
-- table and store the average review for each and every movie.

ALTER TABLE movies
		ADD average_rating INT;

UPDATE movies m
		SET average_rating = r.rat
FROM
	(SELECT
		 movieid,
		 avg(rating) as rat
	 FROM ratings
	 GROUP BY movieid
	) r
WHERE r.movieid = m.movieid;


SELECT *
FROM movies;


