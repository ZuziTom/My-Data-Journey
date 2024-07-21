USE sakila10_56


#################################### SAKILA.RENTAL ####################################
#########################################################################################
################################## GROUP BY - INCOME ############################################


-- total amount of rental shop's income
SELECT SUM(amount) AS total_income
FROM payment;

-- total amount of rental shops income / based on rental_id
SELECT
    rental_id,
    sum(amount) as total_income
FROM payment
GROUP BY rental_id
-- GROUP BY rental_id

-- total amount of rented films per employee,
SELECT
    staff_id,
    COUNT(rental_id) as count_rentals
FROM payment
GROUP BY staff_id

-- using DATE_FORMAT function provide above subpoints  and split by months and sort the results by the keys: staff_id/client_id ascending, amount - descending
SELECT
    customer_id,
    --staff id,
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    sum(amount) as total_income
FROM payment
GROUP BY customer_id, month
ORDER BY customer_id ASC, TOTAL_INCOME DESC;
--GROUP BY staff_id, month
--ORDER BY staff_id ASC, TOTAL_INCOME DESC;


############################################### SAKILA.CUSTOMER / PAYMENT #####################################
###############################################################################################################
################################################## PAYMENT REPORT #############################################

CREATE VIEW client_payments AS
SELECT
    c.customer_id as client_id,
    c.first_name as client_name,
    c.last_name as client_surname,
    c.email as client_email,
    SUM(p.amount) as total_payments,
    COUNT(p.amount) as number_of_payments,
    AVG(p.amount) as average_paymnet_amount,
    MAX(p.payment_date) as date_pf_last_payment
FROM customer as c
JOIN payment as p USING (customer_id)
GROUP BY CLIENT_ID

SELECT * FROM client_payments;


############################################## SAKILA.ACTOR / FILM.ACTOR #################################
#########################################################################3################################
######################################## report / NUMBER OF ACTORS IN FILM  ##############################

CREATE TEMPORARY TABLE tmp_film_actors AS
SELECT
    f.film_id as film_id,
    f.title as film_title,
    COUNT(DISTINCT fa.actor_id) AS number_of_actors
FROM film as f
    JOIN film_actor as fa USING (film_id)
    JOIN actor as a USING (actor_id)
GROUP BY film_id, title

-- Query to verify the contents of the temporary table:
SELECT * FROM tmp_film_actors;

############################################## SAKILA.ACTOR / FILM.ACTOR #################################
#########################################################################3################################
######################################## report / NUMBER OF RENTALS  ##############################


CREATE TEMPORARY TABLE tmp_film_rentals AS
SELECT
    f.film_id,
    f.title,
    COUNT(r.rental_id) AS number_of_rentals
FROM
    film AS f
    JOIN inventory AS i USING (film_id)
    JOIN rental AS r USING (inventory_id)
GROUP BY
    f.film_id, f.title
ORDER BY number_of_rentals DESC;

-- Verify the contents of the temporary table
SELECT * FROM tmp_film_rentals;


############################################## SAKILA.ACTOR / FILM.ACTOR #################################
#########################################################################################################
######################################## report / INCOME BY FILM  #######################################

CREATE TEMPORARY TABLE tmp_film_income AS
SELECT
    f.film_id,
    SUM(p.amount) AS total_income
FROM
    film AS f
    JOIN inventory AS i USING (film_id)
    JOIN rental AS r USING (inventory_id)
    JOIN payment AS p USING (rental_id)
GROUP BY
    f.film_id
ORDER BY
    total_income DESC;

-- Verify the contents of the temporary table
SELECT * FROM tmp_film_income;

############################################## SAKILA.ACTOR / FILM.ACTOR #################################
##########################################################################################################
############################################ report / SUMMARY  ###########################################

-- Prepare a report that displays top 10 rented films with
    -- film title
    -- number of actors
    -- amount of revenue
    -- number of film rentals

-- Combine all TMP tables into a single query
SELECT
    f.title AS film_title,
    a.number_of_actors,
    i.total_income,
    r.number_of_rentals
FROM
    tmp_film_rentals AS r
    JOIN tmp_film_income AS i USING (film_id)
    JOIN tmp_film_actors AS a USING (film_id)
    JOIN film AS f USING (film_id)
ORDER BY
    r.number_of_rentals DESC
LIMIT 10;

-- Verify the total income for all films
SELECT
    SUM(total_income) AS total_income_from_tmp
FROM
    tmp_film_income;

-- Compare with the actual total income from the payment table
SELECT
    SUM(amount) AS total_income_from_payments
FROM
    payment;