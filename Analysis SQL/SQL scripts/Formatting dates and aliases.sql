USE sakila10_56

######################
#### EXERCISE 1 ######
######################

#Display the data from sakila.rental giving aliases to columns according to the requirements:

SELECT
    rental_id,
    inventory_id,
    customer_id,
    rental_date AS date_of_rental,
    return_date AS date_of_rental_return
FROM
    rental;


   

############################
#### EXERCISE 2 ##########
############################

# Write a query to display the payment_date column in the following formats:


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

   
##########################   
#### EXERCISE 3 #########
#########################

# To format the payment_date column from the sakila.payment table according to the US standard using the GET_FORMAT() method in MySQL

SELECT
    payment_date,
    DATE_FORMAT(payment_date, GET_FORMAT(DATE, 'USA')) AS payment_Date_usa_formatted
FROM
    payment;


   ########################
   #### EXERCISE 4-5 ######
   ########################

#Using sakila.film_list, write and perform a query that:
#returns the lowest value in the columns: price, length,
#returns the lowest value in the columns: price, length, rating.

-- Returns the lowest value in the columns: price, length
SELECT
    title,
    price,
    length,
    rating,
    least (price, length, rating) as least,
    greatest (price, length) as greatest
FROM film_list

-- The first query calculates the minimum value for price and length, and the second query calculates the minimum value for price, length, and rating.
-- The difference in results between the two queries will come from the fact that the LEAST function is considering the minimum values across all specified columns in each case.
-- If any of the columns has a different minimum value, it will be reflected in the result.



