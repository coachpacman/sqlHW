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