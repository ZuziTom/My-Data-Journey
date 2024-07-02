USE sakila10_56

################################################
################# EXERCISE 1 ###################
################### REPORTS  ###################

SELECT
    s.store_id,
    st.staff_id,
    st.first_name,
    st.last_name,
    SUM(p.amount) as total_sales
FROM staff as st
JOIN store as s USING (store_id)
jOIN payment as p USING (staff_id)
GROUP BY st.staff_id, st.first_name, st.last_name, s.store_id WITH ROLLUP

#stores total sales

SELECT
    s.store_id,
    SUM(p.amount) as total_sales
FROM staff as st
JOIN store as s USING (store_id)
jOIN payment as p USING (staff_id)
GROUP BY s.store_id WITH ROLLUP

# total sales

SELECT
    SUM(amount) as total_sales
FROM payment;


################################################
################# EXERCISE 2 ###################
################### REPORTS  ###################

# Using only ROLLUP

SELECT
    customer_id as client_id,
    staff_id as emplyee_id,
    SUM(amount) as total_payments
FROM payment
WHERE
    customer_id < 4
GROUP BY customer_id, staff_id with ROLLUP
HAVING SUM(amount) > 71;


