-- Lab | SQL Queries - Lesson 2.6
-- In this lab, you will be using the Sakila database of movie rentals. 
-- You have been using this database for a couple labs already, but if you need to get the data again, refer to the official installation link.
-- The database is structured as follows:

USE sakila;


-- In the table actor, which are the actors whose last names are not repeated? 
-- For example if you would sort the data in the table actor by last_name, 
-- you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. 
-- These three actors have the same last name. So we do not want to include this last name in our output. 
-- Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.

SELECT DISTINCT last_name, first_name from actor;

-- Which last names appear more than once? 
-- We would use the same logic as in the previous question but this time we want to include the last names of the actors where the last name was present more than once

SELECT last_name, count(last_name) as appearance from actor
GROUP BY last_name
HAVING (appearance >1);

-- Using the rental table, find out how many rentals were processed by each employee.

SELECT staff_id, sum(rental_id) from rental
GROUP BY staff_id;

-- Using the film table, find out how many films were released each year.

SELECT release_year, count(release_year) from film
GROUP BY release_year;

-- Using the film table, find out for each rating how many films were there.

SELECT rating, count(film_id) as film_count from film
GROUP BY rating;

-- What is the mean length of the film for each rating type. Round off the average lengths to two decimal places

SELECT rating, round(AVG(length),2) as mean_length from film
GROUP BY rating;

-- Which kind of movies (rating) have a mean duration of more than two hours?

SELECT rating, round(AVG(length))>=120 as average_duration 
from film 
group by rating
order BY average_duration DESC; 
-- alternative
SELECT round(AVG(length),2)  AS average_length, rating FROM sakila.film
GROUP BY rating HAVING average_length > 120;

-- Rank films by length (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, and the rank.

SELECT title, length, 
RANK() OVER (ORDER BY length DESC) AS 'rank' 
FROM sakila.film
WHERE length IS NOT NULL AND length NOT LIKE '%0%'