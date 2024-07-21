USE sakila10_56;

-- EXAMPLE of WINDOW functions in MySQL: 
-- AVG, SUM, MIn, MAX, ROW_NUNMBER, LEAD, LAG, COUNT, RANK, DENSE_RANK


-- GENERAL SYNTAX: 
-- window_function OVER (PARTITION BY column_name_1 ORDER BY column_name_2)


############################# SAKILA.PAYMENT ####################################
################################################################################
############################# PAYMENT REPORT ###################################

-- the minimum / maximum / average payment per customer

SELECT
    customer_id,
    AVG(amount) OVER (PARTITION BY customer_id) as payment_amount,
    MIN(amount) OVER (PARTITION BY customer_id) as min_payment,
    MAX(amount) OVER (PARTITION BY customer_id) as max_payment
FROM payment
WINDOW customer_window As (PARTITION BY customer_id)

-- WINDOW aka variable

SELECT
    customer_id,
    AVG(amount) OVER (customer_window) as payment_amount,
    MIN(amount) OVER (customer_window) as min_payment,
    MAX(amount) OVER (customer_window) as max_payment
FROM payment
WINDOW customer_window As (PARTITION BY customer_id)

-- ROW_NUMBER - enumerates the rows (1,2,3,4,5, ...)
-- RANK - skip the numbering in case there are > 1 subjects on 1 place (1,2,2,4,5, ...)
-- DENSE_RANK - keep numbering in case there are > 1 subjects on 1 place (1,2,2,3,4, ...)

--  Ranking customers by payment

SELECT
    customer_id,
    amount,
    ROW_NUMBER() OVER (amount_window) as rn,
    DENSE_RANK() OVER (amount_window) as dr,
    RANK() OVER (amount_window) as r
FROM payment
WINDOW amount_window As (ORDER BY amount DESC)

-- LEAD clause - designates the next element in the partition
-- LAG clause - designates the previous element in a partition

-- the next and previous payment for each customer

SELECT
  customer_id,
  amount,
  payment_date,
  LEAD(amount) OVER (customer_window) as following_payment,
  LAG(amount) OVER (customer_window) as previous_payment
FROM payment
WINDOW customer_window As (PARTITION BY customer_id ORDER BY payment_date ASC)
ORDER BY customer_id, payment_date


############################# SAKILA.ACTOR ####################################
################################################################################
############################# ACTORS RANKING REPORT ############################

-- ranking of actors based on the average rating using ROW_NUMBER clause

SELECT * FROM actor_analytics

SELECT
    actor_id,
    first_name,
    last_name,
    avg_film_rate,
    ROW_NUMBER() OVER row_numbers as row_ranking
FROM actor_analytics
WINDOW row_numbers as (ORDER BY avg_film_rate DESC)



############################# SAKILA.ACTOR ####################################
################################################################################
############################# CUMULATIVE SUM ##################################


SELECT
    actor_id,
    avg_film_rate,
    MIN(avg_film_rate) OVER cumsum as cum_min_avg_film_rate, -- Calculates the cumulative minimum of avg_film_rate up to the current row, ordered by actor_id in ascending order
    actor_payload,
    SUM(actor_payload) OVER cumsum as cum_sum_actor_payload, -- Calculates the cumulative sum of actor_payload up to the current row, ordered by actor_id in ascending order
    longest_movie_duration,
    MAX(longest_movie_duration) OVER cumsum as cum_max_longest_movie_duration, -- Calculates the cumulative maximum of longest_movie_duration up to the current row, ordered by actor_id in ascending order
    ROW_NUMBER() OVER (ORDER BY actor_id) AS row_number
FROM actor_analytics
WINDOW cumsum  as (ORDER BY actor_id ASC)



############################# SAKILA.ACTOR ####################################
################################################################################
############################# PARETO PRINCIPLE ##################################

-- what % of actors is responsible for what % of income of the rental shop

 SELECT
        SUM(actor_payload) AS total_income
    FROM
        actor_analytics      -- total income > 367559.07


SELECT
    actor_id,  
    first_name,  
    last_name,  
    actor_payload, 
    ROW_NUMBER() OVER income AS actor_rank,  -- Assigns a unique sequential integer to rows based on the income window definition (ordering by actor_payload in descending order)
    COUNT(*) OVER () AS total_rows,  -- Counts the total number of rows in the entire result set
    ROW_NUMBER() OVER income / COUNT(*) OVER () AS actor_rank_percentage,  -- Calculates the rank of the actor as a percentage of the total number of rows
    SUM(actor_payload) OVER income AS cum_sum_payload,  -- Calculates the cumulative sum of actor_payload based on the income window definition
    SUM(actor_payload) OVER() AS total_income,  -- Calculates the total sum of actor_payload for the entire result set
    SUM(actor_payload) OVER income / SUM(actor_payload) OVER () AS cumulative_income_percentage  -- Calculates the cumulative income as a percentage of the total income
FROM
    actor_analytics 
WINDOW income AS (ORDER BY actor_payload DESC);  -- Defines the window specification named 'income' which orders rows by actor_payload in descending order


############################# SAKILA.FILM #########################################
###################################################################################
############################# FILM RANKING REPORT #################################


-- ranking of the movies by number of rentals

SELECT
    rating,
    film_id,
    title,
    num_rentals,
    RANK() OVER (PARTITION BY rating ORDER BY num_rentals DESC) AS rank,
    DENSE_RANK() OVER (PARTITION BY rating ORDER BY num_rentals DESC) AS dense_rank,
    ROW_NUMBER() OVER (PARTITION BY rating ORDER BY num_rentals DESC) AS row_number
FROM
    sakila.film_analytics
ORDER BY
    rating, num_rentals DESC;
