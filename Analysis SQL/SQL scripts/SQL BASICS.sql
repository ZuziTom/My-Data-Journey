USE sakila10_56;

########################### SAKILA.RENTAL ANALYSIS ######################################
#########################################################################################
################################## FILTERING ############################################

-- about rentals from 2005
SELECT *
FROM rental
WHERE rental_date >= '2005-01-01' AND rental_date < '2006-01-01';

-- about rentals from 2005-05-24
SELECT *
FROM rental
WHERE rental_date >= '2005-05-24' AND rental_date < '2005-05-25';

-- about rentals after 2005-06-30
SELECT *
FROM rental
WHERE rental_date > '2005-06-30';

-- about holiday rentals, that is: between 2005-06-30 and 2005-08-31 from Jon (first check his staff_id in sakila.staff)
SELECT*
FROM  rental
WHERE rental_date BETWEEN '2005-06-30' AND '2005-08-31' AND staff_id = '2';


########################### SAKILA.CUSTOMER ANALYSIS ####################################
#########################################################################################
################################## FILTERING ############################################

-- Write queries that will display information from sakila.customer for the following questions:

-- Display information for all active customers or those starting from 'ANDRE':
SELECT *
FROM customer
WHERE active = 1 XOR first_name LIKE 'ANDRE%';

-- Display information for all inactive customers with store_id equal to 1:
SELECT *
FROM customer
WHERE active = 0 AND store_id = 1;

-- Display information for customers whose email address is in a domain different from 'sakilacustomer.org':
SELECT*
FROM customer
WHERE NOT email LIKE '%@sakilacustomer.org';

-- Display information for customers with unique values in the create_date column:
SELECT DISTINCT customer.create_date from customer


########################### SAKILA.actor_analytics ANALYSIS #############################
#########################################################################################
################################## FILTERING ############################################

-- Display actors who played in more than -- 25 films / 20 films and whose average rating is above 3.3 / 20 films and whose average rating is above 3.3 or the income from rentals (actor_payload) is above 2000

SELECT*
FROM actor_analytics
-- where films_amount > 25
-- where films_amount > 20 AND avg_film_rate > 3.3;
-- where 1=1
    AND films_amount > 20
    AND avg_film_rate > 3.3
    OR actor_payload > 2000;

################################### SAKILA.RENTAL ######################################
#########################################################################################
################################## ALIASING ############################################

-- Display the data from sakila.rental giving aliases to columns according to the requirements:

SELECT
    rental_id,
    inventory_id,
    customer_id,
    rental_date AS date_of_rental,
    return_date AS date_of_rental_return
FROM
    rental;


################################### SAKILA.PAYMENT #######################################
#########################################################################################
################################## FORMATTING DATES #####################################

-- Write a query to display the payment_date column in the following formats:
# 'year/month/day',
# 'year-name_of_month-day_of_week',
# 'year-number_of_week',
# 'year/month/day@day_of week_name',
# 'year/month/day@day_of_week_number'.

SELECT
    payment_date,
    DATE_FORMAT(payment_date, '%Y/%m/%d') AS year_month_day,
    DATE_FORMAT(payment_date, '%Y-%M-%W') AS year_month_day_of_week,
    DATE_FORMAT(payment_date, '%Y-%U') AS year_number_of_week,
    CONCAT(DATE_FORMAT(payment_date, '%Y/%m/%d'), '@', DATE_FORMAT(payment_date, '%W')) AS year_month_day_at_day_of_week_name,
    CONCAT(DATE_FORMAT(payment_date, '%Y/%m/%d'), '@', DATE_FORMAT(payment_date, '%u')) AS year_month_day_at_day_of_week_number
FROM
    payment;



-- To format the payment_date column from the sakila.payment table according to the US standard using the GET_FORMAT() method in MySQL

SELECT
    payment_date,
    DATE_FORMAT(payment_date, GET_FORMAT(DATE, 'USA')) AS payment_Date_usa_formatted
FROM
    payment;


################################### SAKILA.FILM_LIST #################################################
#######################################################################################################
################################## LEAST / GREATEST VALUE #############################################

-- Query: returns the lowest / greatest value in the columns: price, length, rating:

SELECT
    title,
    price,
    length,
    rating,
    least (price, length, rating) as least,
    greatest (price, length, rating) as greatest
FROM film_list


############################# SAKILA tables / CUSTOMER, ACTOR, STAFF ##################################
#######################################################################################################
################################## UNION ##############################################################

-- Using tables: sakila.customer, sakila.actor, sakila.staff, display everybody's first name without repetitions.

SELECT first_name FROM customer
UNION
SELECT first_name FROM actor
UNION
SELECT first_name FROM staff;

-- Return categories of films without repetitions using UNION (do not use the DISTINCT clause here)

SELECT category FROM nicer_but_slower_film_list
UNION
SELECT category FROM nicer_but_slower_film_list;


############################################ SAKILA.SALES ############################################
#######################################################################################################
###################################### SUBQUERRIES ####################################################

-- Using data from sakila.sales_by_store and sakila.sales_total find stores where total sales is higher than the half of total sales of the rental store.

SELECT store, manager, total_sales
FROM
    sales_by_store
WHERE total_sales > ((SELECT SUM(total_sales)/2 from sales_total));


-- Film ratings statistics:
   -- 1. Analyzing only the data structure, consider which row can determine statistics for all ratings (without rating division),
   -- 2. Find the ratings which are higher than the average for all movies, without rating division,
   -- 3. Find the ratings where the renting time is shorter than the global average,
   -- 4. Use a subquery to display the statistics for id_rating = 3,
   -- 5. Use a subquery to display the statistics for id_rating = 3, 2, 5,
   -- 6. Write a query that shows which rating in the most popular one,
   -- 7. Write a query that reveals which rating has, on average, the shortest movies.

-- 1.
SELECT * FROM rating_analytics where rating is NULL;

-- 2. ratings which are higher than the average for all movies
WITH global_avg AS (SELECT AVG(avg_rental_duration) AS avg_rental_duration FROM rating_analytics WHERE rating IS NOT NULL)

SELECT *
FROM rating_analytics
WHERE avg_rental_duration > (SELECT avg_rental_duration FROM global_avg);

-- 3. ratings where the renting time is shorter than the global average
wITH global_avg_rental_time AS (SELECT AVG(avg_rental_duration) AS avg_rental_duration FROM rating_analytics WHERE rating IS NOT NULL)

SELECT *
FROM rating_analytics
WHERE avg_rental_duration < (SELECT avg_rental_duration FROM global_avg_rental_time);

-- 4: Display the statistics for id_rating = 3
SELECT *
FROM rating_analytics
WHERE id_rating = 3;

-- 5: Display the statistics for id_rating = 3, 2, 5
SELECT *
FROM rating_analytics
WHERE id_rating IN (3, 2, 5);

-- 6: Display the most popular rating
SELECT rating_name
FROM rating_analytics
ORDER BY total_films DESC
LIMIT 1;

-- 7: Display the rating with the shortest average movie duration
SELECT rating_name
FROM rating_analytics
ORDER BY average_duration ASC
LIMIT 1;





-- Actors statistics:
    -- Find the actor/actress with the name of ZERO and the surname: CAGE, display all statistics for their id; Display actors who played in at least 30 films, Using the results from the previous point display all of their information from sakila.actor
    -- Find the actors who played in the movies with the length of (longest_movie_duration) of 184, 174, 176, 164. Using the results from the previous subpoint, find these films in sakila.film (this will require more than one subquery).

-- Step 1: Find the actor/actress with the name ZERO and the surname CAGE
WITH ZeroCage AS (SELECT * FROM actor WHERE first_name = 'ZERO' AND last_name = 'CAGE'),

-- Step 2: Display actors who played in at least 30 films
ActorsInAtLeast30Films AS (SELECT actor_id FROM film_actor GROUP BY actor_id HAVING COUNT(film_id) >= 30 )

-- Step 3: Using the results from step 2, display all of their information from sakila.actor
ActorsWith30Films AS (SELECT * FROM actor WHERE actor_id IN (SELECT actor_id FROM ActorsInAtLeast30Films))

-- Step 4: Find the actors who played in the movies with the length of 184, 174, 176, 164
ActorsInSpecificLengthFilms AS (
    SELECT DISTINCT fa.actor_id
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    WHERE f.length IN (184, 174, 176, 164)
),

-- Step 5: Using the results from the previous subpoint, find these films in sakila.film
FilmsInSpecificLength AS (
    SELECT f.*
    FROM film f
    WHERE f.film_id IN (
        SELECT fa.film_id
        FROM film_actor fa
        WHERE fa.actor_id IN (SELECT actor_id FROM ActorsInSpecificLengthFilms)
    )
)

-- Final Selects to Display Results

-- Step 1: Display actor with the name ZERO and surname CAGE
SELECT * FROM ZeroCage;

-- Step 3: Display all information from sakila.actor for actors who played in at least 30 films
SELECT * FROM ActorsWith30Films;

-- Step 5: Display films in sakila.film where actors played in movies with specific lengths
SELECT * FROM FilmsInSpecificLength;


############################################ SAKILA.pament AND rentals ############################################
###################################################################################################################
################################################### JOINs #########################################################

-- Join for rental and payment tables
SELECT
    p.payment_id
    r.rental_id,
    p.amount,
    r.rental_date,
    p.payment_date
FROM
    payment as p
JOIN rental as r using (rental_id);


-- RENTAL REPORT based on several tables

SELECT
    r.rental_ID as Rental_ID,
    f.film_id as Film_ID,
    f.title as Film_Title,
    f.description as Film_Description,
    f.rating as Film_Rating,
    r.rental_date as Rental_date,
    p.payment_date as Payment_date,
    p.amount as Payment_Amount
FROM
    rental as r
JOIN
    inventory as i using (inventory_id)
JOIN
    film as f using (film_id)
JOIN
    payment as  p using (rental_id)


-- UNPAID RENTALS REPORT

SHOW COLUMNS from sakila10_56.rental  -- help query
SHOW COLUMNS from tasks10_56.payment

SELECT
    r.rental_id,
    r.rental_date,
    p.payment_id
FROM
    tasks10_56.payment AS p
RIGHT JOIN
    sakila10_56.rental AS r USING (rental_id)
WHERE
    p. payment_id IS NULL;


############################################ SAKILA.COUNTRY and TASKS.CITY_COUNTRY DB ############################################
##################################################################################################################################
######################################### JOINs in data modification / UPDATE ####################################################

-- Populate country name in the task.city_country table based on the sakila.country table using UPDATE function, then show the results

SELECT * FROM tasks10_56.city_country

UPDATE tasks10_56.city_country
SET country = (
    SELECT country FROM sakila10_56.country
                   WHERE country.country_id = tasks10_56.city_country.country_id
);

SELECT * FROM tasks10_56.city_country


############################################### CREATE VIEW TABLE #################################################
###################################################################################################################
###################################################################################################################

CREATE VIEW actor_film AS
SELECT 
    a.first_name as actor_name,
    a.last_name as actor_last_name,
    f.title as film_title,
    f.description as film_description
FROM
       actor as a
    INNER JOIN
        film_actor fa on a.actor_id = fa.actor_id
    INNER JOIN
        film f on fa.film_id = f.film_id

-- DROP VIEW view_name