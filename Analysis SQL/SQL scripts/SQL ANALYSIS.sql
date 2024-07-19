USE sakila10_56


#################################### SAKILA.PAYMENT ####################################
#########################################################################################
################################## FILTERING ############################################


-- total amount of rental shop's income
SELECT SUM(amount) AS total_income
FROM payment;

- total amount of rental shops income / based on rental_id
SELECT
    rental_id,
    sum(amount) as total_income
FROM payment
GROUP BY rental_id

- customer ID
SELECT
    customer_id,
    sum(amount) as total_income
FROM payment
GROUP BY customer_id

- total amount of rented films per employee,
SELECT
    staff_id,
    COUNT(rental_id) as count_rentals
FROM payment
GROUP BY staff_id

# exercise 2 / DATE FORMAT split by months and sort the results by the keys: client_id ascending, amount - descending
SELECT
    customer_id,
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    sum(amount) as total_income
FROM payment
GROUP BY customer_id, month
ORDER BY customer_id ASC, TOTAL_INCOME DESC;

# exercise 3 / DATE FORMAT split by months and sort the results by the keys: staff_id ascending, amount - descending
SELECT
    staff_id,
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    COUNT(rental_id) as count_rentals,
    SUM(amount) AS total_income
FROM payment
GROUP BY staff_id, month
ORDER BY staff_id ASC, TOTAL_INCOME DESC;


################################################
################# EXERCISE 2 ####################
################## PAYMENT ########################

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


################################################
################# EXERCISE 3 ###################
################# ACTORS IN FILM  ##############

CREATE TEMPORARY TABLE tmp_film_actors AS
SELECT
    f.film_id as film_id,
    f.title as film_title,
    COUNT(a.actor_id) AS num_actors
FROM film as f
    JOIN film_actor as fa USING(film_id)
    JOIN actor as a USING (actor_id)
GROUP BY film_id, title

# Query to verify the contents of the temporary table:
SELECT * FROM tmp_film_actors;