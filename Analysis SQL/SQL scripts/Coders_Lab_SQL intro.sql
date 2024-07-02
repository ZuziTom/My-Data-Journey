USE sakila10_56;


######################
###### EXERCISE 1  ######
######################

# about rentals from 2005
SELECT *
FROM rental
WHERE rental_date >= '2005-01-01' AND rental_date < '2006-01-01';

#about rentals from 2005-05-24
SELECT *
FROM rental
WHERE rental_date >= '2005-05-24' AND rental_date < '2005-05-25';

#about rentals after 2005-06-30
SELECT *
FROM rental
WHERE rental_date > '2005-06-30';

#about holiday rentals, that is: between 2005-06-30 and 2005-08-31 from Jon (first check his staff_id in sakila.staff
SELECT*
FROM  rental
WHERE rental_date BETWEEN '2005-06-30' AND '2005-08-31' AND staff_id = '2';


######################
###### EXERCISE  2  ######
######################

# Write queries that will display information from sakila.customer for the following questions:

#Display information for all active customers:
SELECT *
FROM customer
WHERE active = 1;

# Display information for all active customers or those starting from 'ANDRE':
SELECT *
FROM customer
WHERE active = 1 XOR first_name LIKE 'ANDRE%';


##########################
###### EXERCISE  3  ######
##########################


# Write queries that will display information from sakila.customer for the following questions:

#Display information for all inactive customers with store_id equal to 1:
SELECT *
FROM customer
WHERE active = 0 AND store_id = 1;

#Display information for customers whose email address is in a domain different from 'sakilacustomer.org':
SELECT*
FROM customer
WHERE NOT email LIKE '%@sakilacustomer.org';

#Display information for customers with unique values in the create_date column:
SELECT DISTINCT customer.create_date from customer


##########################
###### EXERCISE  4  ######
##########################


#Get familiar with the structure of sakila.actor_analytics and write queries that:

SELECT*
FROM actor_analytics
#where films_amount > 25
#where films_amount > 20 AND avg_film_rate > 3.3;
where 1=1
    AND films_amount > 20
    AND avg_film_rate > 3.3
    OR actor_payload > 2000;