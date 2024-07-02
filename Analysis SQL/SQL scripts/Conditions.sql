USE sakila10_56

SELECT
    *
    , CASE
        WHEN films_amount > 20 THEN 'SUPER POPULAR'
        WHEN films_amount BETWEEN 10 AND 20 THEN 'POPULAR'
        WHEN films_amount < 10 THEN 'LOW POPULAR'
        ELSE 'ERROR'
    END AS how_popular
FROM actor_analytics

SELECT
    amount,
    IF(amount > 5, 'Big payment', 'Low payment') AS payment_type
FROM payment



################################################
################# EXERCISE  ###################
################# ACTORS RANKING  ##############

SELECT * FROm actor_analytics

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



################################################
################# EXERCISE  ###################
################# FILM CLASSIFICATION  #########

SELECT* FROM film

DELIMITER //

CREATE PROCEDURE film_classification(IN length INT, OUT film_category VARCHAR(20))
BEGIN
    SET film_category =
        CASE
            WHEN length <= 60 THEN 'very short'
            WHEN length <= 90 THEN 'short'
            WHEN length <= 120 THEN 'normal'
            WHEN length <= 150 THEN 'long'
            ELSE 'very long'
        END;

    SELECT film_category;
END //

DELIMITER ;

CALL film_classification(120)



################################################
################# EXERCISE  ###################
################# PAYMENT AMOUNT  ############

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
    (SELECT COUNT(*) FROM payment) * 100
        AS fee_percentage;

-- Calculate the percentage of total payments that are fees
SELECT
    (SELECT COUNT(*) FROM payment WHERE amount < 2) /
            COUNT(*) * 100
            AS fee_percentage
FROM
    payment;