USE sakila10_56

#################################### SAKILA.RENTAL ####################################
#########################################################################################
################################## ROLLUP - REPORT ####################################

-- the store's total sales and its employees

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

-- the store's total sales (no division by employee)

SELECT
    s.store_id,
    SUM(p.amount) as total_sales
FROM staff as st
JOIN store as s USING (store_id)
jOIN payment as p USING (staff_id)
GROUP BY s.store_id WITH ROLLUP

-- pament report determines the sum of payments divided by client and by employee
-- using ROLLUP and HAVING clause for payments above 70

SELECT
    customer_id as client_id,
    staff_id as emplyee_id,
    SUM(amount) as total_payments
FROM payment
WHERE
    customer_id < 4
GROUP BY customer_id, staff_id with ROLLUP
-- HAVING SUM(amount) > 71;


