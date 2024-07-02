USE sakila10_56

select DISTINCT first_name, COUNT(*) from actor GROUP BY 1 order by 2 desc
# cisla 1 a 2 je stlpec v poradi / group bz 1 stlpec a order bz 2 stlpec

######################
#### EXERCISE 1 ####
######################


# Names in SakilaDB
# Using tables:
# sakila.customer,
# sakila.actor,
# sakila.staff,
# display everybody's first name without repetitions.

-- Display everybody's first name without repetitions
SELECT first_name FROM customer
UNION
SELECT first_name FROM actor
UNION
SELECT first_name FROM staff;



######################
#### EXERCISE 2 ####
######################

# Film categories
# Using the UNION property of returning a set by default, modify the query below to return the categories of films (category)
# without repetitions (do not use the DISTINCT clause here):

-- Return categories of films without repetitions using UNION
SELECT category FROM nicer_but_slower_film_list
UNION
SELECT category FROM nicer_but_slower_film_list;

