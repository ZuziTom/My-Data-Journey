USE sakila10_56

################################################## SAKILA.ACTORS ###################################
#####################################################################################################
########################################### ACTOR RATINGS REPORT  ##################################

-- grouping the actors according criteria and creating the column acting_level
-- based on the new column provide analysis
    -- number of occurences in each group,
    -- total revenue of each group,
    -- number of films in each group,
    -- average rating in each group.

SELECT
    CASE
        WHEN avg_film_rate < 2 THEN 'POOR ACTING'
        WHEN avg_film_rate  BETWEEN 2 and 2.5 THEN 'FAIR ACTING'
        WHEN avg_film_rate BETWEEN 2.5 AND 3.5 THEN 'GOOD ACTING'
        WHEN avg_film_rate > 3.5 THEN 'SUPERB ACTING'
    END AS acting_level,
    COUNT(*) AS occurrences,
    SUM(actor_payload) AS total_revenue,
    SUM(films_amount) AS total_films,
    AVG(avg_film_rate) AS avg_rating
FROM actor_analytics
GROUP BY ACTING_LEVEL


########################################### SAKILA.PAYMENT ##########################################
#####################################################################################################
########################################### PAYMENT CLASSIFICATION ##################################

-- group the payments according to the given classification
-- what percent of the total payments were the fees

SELECT * FROM payment

SELECT
    CASE
        WHEN amount < 2 THEN 'fee'
        ELSE 'regular'
    END AS payment_classification,
    COUNT(*) AS payment_count,
    SUM(amount) as total_amount
FROM payment
GROUP BY payment_classification;


-- Calculate the percentage of total payments that are fees
SELECT
    (SELECT COUNT(*) FROM payment WHERE amount < 2) /
            COUNT(*) * 100
            AS fee_percentage
FROM
    payment;