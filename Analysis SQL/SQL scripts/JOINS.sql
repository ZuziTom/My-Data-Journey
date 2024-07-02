USE sakila10_56
USE tasks10_56

SELECT *
FROM
   payment_join AS p
  LEFT JOIN
    rental_join AS r USING (rental_id)
#     rental_join AS r ON p.rental_id = r.rental_id
;

######################
#### EXERCISE 1 ######
######################


SELECT
    p.payment_id
    r.rental_id,
    p.amount,
    r.rental_date,
    p.payment_date
FROM
    payment as p
JOIN rental as r using (rental_id);


######################
### EXERCISE 2
######################

SELECT
    i.inventory_id,
    r.rental_id,
    i.film_id
FROM rental as r
JOIN inventory as i using (inventory_id);


######################
### EXERCISE 3
######################


SELECT
    i.inventory_id,
    f.film_id,
    f.title,
    f.description,
    f.release_year
FROM
    film AS f
JOIN inventory as i using (film_id);


######################
### EXERCISE 4
######################


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



######################
### EXERCISE 5
######################


SHOW COLUMNS from sakila10_56.rental
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


