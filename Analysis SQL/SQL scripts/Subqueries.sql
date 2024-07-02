USE sakila10_56

######################
#### EXERCISE 1 ####
######################


# Store sales
# Using data from sakila.sales_by_store and sakila.sales_total find stores where total sales is higher than the half of total sales of the rental store.

SELECT store, manager, total_sales
FROM
    sales_by_store
WHERE total_sales > ((SELECT SUM(total_sales)/2 from sales_total));


######################
#### EXERCISE 2 ####
######################


# Film ratings statistics
# Get familiar with the structure of sakila.rating_analytics, which has aggregated information regarding particular ratings for all films. Then do the following:

# 1. Analyzing only the data structure, consider which row can determine statistics for all ratings (without rating division),
# 2. Find the ratings which are higher than the average for all movies, without rating division,
# 3. Find the ratings where the renting time is shorter than the global average,
# 4. Use a subquery to display the statistics for id_rating = 3,
# 5. Use a subquery to display the statistics for id_rating = 3, 2, 5,

# Additionally, as an exercise:
# 6. Write a query that shows which rating in the most popular one,
# 7. Write a query that reveals which rating has, on average, the shortest movies.

### 1.
SELECT * FROM rating_analytics where rating is NULL;

### 2.
WITH avg as (SELECT avg_rental_duration FROM rating_analytics where rating is NULL)
SELECT * FROM rating_analytics WHERE avg_rental_duration > (SELECT * FROM avg);

### 3.
WITH actor AS (SELECT * FROM actor WHERE first_name = 'ZERO' and last_name = 'CAGE')
    SELECT * FROM actor_analytics WHERE actor_id = (SELECT actor_id FROM actor);

### 4.
WITH actor_many_films AS (SELECT * FROM actor_analytics WHERE films_amount > 30 )
    SELECT * FROM actor WHERE actor_id IN (select actor_id from actor_many_films)
    SELECT * FROM actor_analytics WHERE longest_movie_duration IN (184, 174, 176, 164)