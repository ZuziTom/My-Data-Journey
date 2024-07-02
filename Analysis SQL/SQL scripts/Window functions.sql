USE sakila10_56;

SELECT
    customer_id,
    AVG(amount) OVER (PARTITION BY customer_id) as payment_amount,
    MIN(amount) OVER (PARTITION BY customer_id) as min_payment,
    MAX(amount) OVER (PARTITION BY customer_id) as max_payment
FROM payment
WINDOW customer_window As (PARTITION BY customer_id)

# WINDOW aka variable
SELECT
    customer_id,
    AVG(amount) OVER (customer_window) as payment_amount,
    MIN(amount) OVER (customer_window) as min_payment,
    MAX(amount) OVER (customer_window) as max_payment
FROM payment
WINDOW customer_window As (PARTITION BY customer_id)

SELECT
    customer_id,
    amount,
    ROW_NUMBER() OVER (amount_window) as rn,
    DENSE_RANK() OVER (amount_window) as dr,
    RANK() OVER (amount_window) as r
FROM payment
WINDOW amount_window As (ORDER BY amount DESC)

SELECT
  customer_id,
  amount,
  payment_date,
  LEAD(amount) OVER (customer_window) as following_payment,
  LAG(amount) OVER (customer_window) as previous_payment
FROM payment
WINDOW customer_window As (PARTITION BY customer_id ORDER BY payment_date ASC)
ORDER BY customer_id, payment_date


################################################
################# EXERCISE 1 ###################
################### ACTORS RANKING  ############


SELECT * FROM actor_analytics

SELECT
    actor_id,
    first_name,
    last_name,
    avg_film_rate,
    ROW_NUMBER() OVER row_numbers as row_ranking
FROM actor_analytics
WINDOW row_numbers as (ORDER BY avg_film_rate DESC)



################################################
################# EXERCISE 2 ###################
################### CUMULATIVE SUM  ############


SELECT
    actor_id,
    avg_film_rate,
    MIN(avg_film_rate) OVER cumsum as cum_min_avg_film_rate,
    actor_analytics.actor_payload,
    SUM(actor_payload) OVER cumsum as cum_sum_actor_playload,
    actor_analytics.longest_movie_duration,
    MAX(longest_movie_duration) OVER cumsum as cum_max_longest_movie_duration,
    ROW_NUMBER() OVER cumsum as row_ranking
FROM actor_analytics
WINDOW cumsum  as (ORDER BY actor_id ASC)



################################################
################# EXERCISE 3 ###################
################### PARETO PRINCIPLE  ############


 SELECT
        SUM(actor_payload) AS total_income
    FROM
        actor_analytics
# 367559.07

SELECT
    actor_id,
    first_name,
    last_name,
    actor_payload,
    ROW_NUMBER() OVER income AS actor_rank,
    COUNT(*) OVER () AS total_actors,
    ROW_NUMBER() OVER income / COUNT(*) OVER () AS actor_percentage,
    SUM(actor_payload) OVER income as cum_sum_payload,
    SUM(actor_payload) OVER() as total_income,
    SUM(actor_payload) OVER income / SUM(actor_payload) OVER () AS cumulative_income_percentage
FROM
    actor_analytics
#WINDOW income AS (PARTITION BY actor_payload DESC)
WINDOW income AS (ORDER BY actor_payload DESC)