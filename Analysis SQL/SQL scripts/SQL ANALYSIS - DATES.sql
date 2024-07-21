USE sakila10_56

################################################## SAKILA.PAYMENT ###################################
#####################################################################################################
#################################### CALENDAR TABLE  ##################################

-- calendar table in the database, that:
    -- start from '2000-01-01',
    -- end on '2030-12-31'.

    -- The calendar table should have the following columns:
        -- date (date),
        -- year (date_year),
        -- month (date_month),
        -- day (date_day),
        -- number of day of week (day_of_week),
        -- number of week in the year (week_of_year),
        -- date of generating the calendar (last_update).


-- Generate a series of dates from '2000-01-01' to '2030-12-31'
WITH RECURSIVE cte AS (
    -- Start with the initial date
    SELECT
        '2000-01-01' AS date
    UNION ALL
    -- Add one day to each date in the recursive step
    SELECT
        date + INTERVAL 1 DAY
    FROM
        cte
    -- Stop recursion when reaching the end date
    WHERE
        date + INTERVAL 1 DAY <= '2030-12-31'
)

SELECT
    date,
    EXTRACT(YEAR FROM date) AS date_year,
    EXTRACT(MONTH FROM date) AS date_month,
    EXTRACT(DAY FROM date) AS date_day,
    EXTRACT(DOW FROM date) + 1 AS day_of_week,  -- Adjust for SQL conventions where Sunday is 0
    EXTRACT(WEEK FROM date) AS week_of_year,
    CURRENT_TIMESTAMP AS last_update
FROM
    cte;

################################################## SAKILA.PAYMENT ###################################
#####################################################################################################
#################################### PAYMENT REPORT BASED on DATES ##################################


-- a view that displays the following summaries:
    -- sum of payments in one year - name the column payment_year,
    -- sum of payments per month - name the column payment_month,
    -- total amount of payments.


CREATE VIEW payment_summary AS
SELECT
    YEAR(payment_date) AS payment_year,
    MONTH(payment_date) AS payment_month,
    SUM(amount) AS total_amount,  -- total amount of payments for each year and month
    
    SUM(amount) OVER (PARTITION BY YEAR(payment_date)) AS yearly_amount, -- total amount of payments for each year (easier to understand by summing the total_amount within each year)
    SUM(SUM(amount)) OVER (PARTITION BY YEAR(payment_date)) AS yearly_amount,  -- cumulative sum of payments for each year

    SUM(amount) OVER (PARTITION BY MONTH(payment_date)) AS monthly_amount, -- total amount of payments for each month within each year
    SUM(SUM(amount)) OVER (PARTITION BY MONTH(payment_date)) AS monthly_amount,  -- cumulative sum of payments for each month (note: this may not be meaningful if partitioned monthly)

    SUM(amount) OVER () AS total_payments  -- total amount of all payments across the entire dataset

FROM
    payment  -- Specify the source table

-- Group the results by year and month to aggregate payments
GROUP BY
    YEAR(payment_date),
    MONTH(payment_date)

-- Order the results by year and month for better readability
ORDER BY
    payment_year,
    payment_month;

