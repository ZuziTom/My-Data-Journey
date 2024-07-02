USE sakila10_56

################################################
################# EXERCISE 1 ###################
################### CALENDAR  ############

-- Calculate the number of days between '2000-01-01' and '2030-12-31'
SELECT DATEDIFF('2030-12-31', '2000-01-01') AS num_days;

WITH cte AS (
    SELECT
        ADDDATE('2000-01-01', ROW_NUMBER() over ()) AS date
    FROM payment
    LIMIT 11323
)
SELECT
    date,
    extract(year from date) as date_year,
    extract(month from date) as date_month,
    extract(day from date) as date_day,
    DAYOFWEEK(date) as day_of_week,
    weekofyear(date) as week_of_year,
    now() as last_update
FROM cte