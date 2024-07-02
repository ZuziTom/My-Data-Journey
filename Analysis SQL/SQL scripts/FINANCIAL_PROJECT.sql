USE financial10_56;  -- the default database we use, change it based on your version

SELECT*
from loan;

##################################
#### History of granted loans ####
###################################

SELECT
    extract(YEAR FROM date) as year,
    extract(QUARTER FROM date) as quarter,
    extract(MONTH FROM date) as month,
    COUNT(*) AS total_loans,
    SUM(payments) as total_amount,
    AVG(payments) as average_amount
FROM loan
GROUP BY year, quarter, month  WITH ROLLUP;

-- little bit adjusted solution to show columns in the way as asked in the exercise
SELECT
    DATE_FORMAT(date, '%Y') AS year,
    CONCAT(DATE_FORMAT(date, '%Y'), '_Q', QUARTER(date)) AS year_quarter,
    CONCAT(DATE_FORMAT(date, '%Y'), '_Q', QUARTER(date), '_', DATE_FORMAT(date, '%m')) AS year_quarter_month,
    COUNT(*) AS total_loans,
    SUM(payments) AS total_loan_amount,
    AVG(payments) AS average_loan_amount
FROM
    loan
GROUP BY
    year, year_quarter, year_quarter_month
WITH ROLLUP;

#############################
###### LOAN STATUS ##########
#############################

SELECT
    status,
    count(*) as total_count
FROM loan
GROUP BY status WITH ROLLUP;

-- total 682 granted loans
-- classes B,D have not been repaid - 76; A,C = 606 = repaid

###################################
#### ANALYSIS OF ACCOUNTS #########
###################################

SELECT*
FROM loan;

-- aggregation of the data based on account_id + ranking over loans amount and count
WITH cte AS (
    SELECT account_id,
           COUNT(amount) AS loans_account_count,
           SUM(amount)   AS total_loan_amount,
           AVG(amount)   AS average_loan
    FROM loan
    WHERE status IN ('A', 'C') -- fully repaid
    GROUP BY account_id
)
SELECT
    *,
    -- ranking
    ROW_NUMBER() over (ORDER BY TOTAL_LOAN_AMOUNT DESC) AS rank_loans_amount,
    ROW_NUMBER() over (ORDER BY LOANS_ACCOUNT_COUNT DESC) AS rank_loans_count
FROM cte;

-- without subquery

SELECT
    account_id,
    COUNT(amount) AS loans_account_count,
    SUM(amount) AS total_loan_amount,
    AVG(amount) AS average_loan,
    -- ranking
    ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS rank_loans_amount,
    ROW_NUMBER() OVER (ORDER BY COUNT(amount) DESC) AS rank_loans_count
FROM
    loan
WHERE
    status IN ('A', 'C') -- fully repaid
GROUP BY
    account_id;



#################################
######## FULLY PAID LOANS #######
############### GENDER ##########

-- 1. find SELECT Query to find out results for the gender
-- 2. need to verify if our select query is correct. Logic is to check if SUM F+M amounts of loans - TOTAL sum of loans = 0
-- 3. to do that we need work with the created data in the SELECT query (SUM of F+M amounts) so keep it within tmp table
-- 4. need to get calculation of total SUM of loans amount from the whole loan table, for verification calculation readability we save it within cte table



DROP TABLE IF EXISTS tmp_gender_results;

CREATE TEMPORARY TABLE tmp_gender_results AS
SELECT
    c.gender as GENDER,
    SUM(amount) as amount
FROM
    loan as l
JOIN account as a using (account_id)
JOIN disp as d using (account_id)
JOIN client as c using (client_id)
WHERE l.status IN ('A','C') AND d.type = 'OWNER' --  there can be multiple type of client (owner and disponent) for us is important only owner.
GROUP BY gender;

-- verification of the results / check the totals of the loans amount between 2 tables - tmp and cte

WITH cte as (
    SELECT sum(amount) as amount
    FROM loan as l
    WHERE l.status IN ('A', 'C')
)

SELECT (SELECT SUM(amount) FROM tmp_gender_results) - (SELECT amount FROM cte) AS difference;
-- = 0


#######################################
######## CLIENT ANALYSIS part 1 #########
########################################

-- using query from previous exercise and saving it into tmp table for easier analysis

DROP TABLE IF EXISTS tmp_analysis_1;
CREATE TEMPORARY TABLE tmp_analysis_1 AS
SELECT
    c.gender,
    2024 - extract(year from birth_date) as age,
    sum(l.amount) as loans_amount,
    count(l.amount) as loans_count
FROM
        loan as l
    INNER JOIN
        account a using (account_id)
    INNER JOIN
        disp as d using (account_id)
    INNER JOIN
        client as c using (client_id)
WHERE l.status IN ('A', 'C') AND d.type = 'OWNER'
GROUP BY c.gender, 2;

-- to double check the SUM of loans / should be 606 ... and that is correct
SELECT
    SUM(loans_count)
FROM tmp_analysis_1;

-- QUESTIONS:
-- who has more repaid loans - women or men?
-- what is the average age of the borrower divided by gender?

SELECT
    gender,
    SUM(loans_count) AS loans_count
FROM tmp_analysis_1
GROUP BY gender;
-- M = 299, F = 307

SELECT
    gender,
    AVG(age) as avg_age
FROM tmp_analysis_1
GROUP BY gender
-- M = 66.5, F = 64.5


########################################
######## CLIENT ANALYSIS part 2 #########
########################################

-- using core of the previous query and joining district table

DROP TABLE IF EXISTS tmp_district;
CREATE TEMPORARY TABLE tmp_district AS
SELECT
    d2.A2 as area,
    COUNT(DISTINCT c.client_id) as clients_per_area,
    SUM(l.amount) as paid_loans_sum,
    COUNT(l.amount) as paid_loans_count
FROM loan as l
JOIN account a using (account_id)
JOIN disp as d using (account_id)
JOIN client as c using (client_id)
JOIN district as d2 on c.district_id = d2.district_id
WHERE l.status IN ('A', 'C')AND d.type = 'OWNER'
GROUP BY area
ORDER BY CLIENTS_PER_AREA DESC;

-- ANSWERS
SELECT *
FROM tmp_district
ORDER BY clients_per_area DESC -- district with the most customers
# ORDER BY paid_loans_sum DESC -- district with the highest repaid loans
# ORDER BY  paid_loans_count DESC -- district with the highest number of repaid loans

-- >>> Hl.m. Praha, SUM 10 502 628, COUNT 73


########################################
######## CLIENT ANALYSIS part 3 #########
########################################
-- percentage of each district in the total amount of loans granted
-- solution with window function to calculate the total sum of paid loans in each district by total sum

SELECT
    d2.A2 as area,
    d2.district_id,
    COUNT(DISTINCT c.client_id) as clients_per_area,
    SUM(l.amount) as paid_loans_sum,
    COUNT(l.amount) as paid_loans_count,
    (SUM(l.amount) / SUM(SUM(l.amount)) OVER()) * 100 as loans_percentage
FROM loan as l
JOIN account a using (account_id)
JOIN disp as d using (account_id)
JOIN client as c using (client_id)
JOIN district as d2 on c.district_id = d2.district_id
WHERE l.status IN ('A', 'C')AND d.type = 'OWNER'
GROUP BY area, d2.district_id
ORDER BY CLIENTS_PER_AREA DESC;

-- different approach with subquery to calculate total sum of paid loans across all districts
-- adding column loans percentage to recalculate share amount

SELECT
    d2.A2 as area,
    d2.district_id,
    COUNT(DISTINCT c.client_id) as clients_per_area,
    SUM(l.amount) as paid_loans_sum,
    COUNT(l.amount) as paid_loans_count,
    SUM(l.amount) / total_loans.total_sum * 100 as loans_percentage
FROM loan as l
JOIN account a using (account_id)
JOIN disp as d using (account_id)
JOIN client as c using (client_id)
JOIN district as d2 on c.district_id = d2.district_id
JOIN (
    SELECT SUM(amount) as total_sum
    FROM loan
    WHERE status IN ('A', 'C')
) as total_loans
WHERE l.status IN ('A', 'C') AND d.type = 'OWNER'
GROUP BY area, d2.district_id
ORDER BY clients_per_area DESC;

########################################
######## SELECTION #####################
########### PART 1 #####################

-- clients with
    -- account balance > 1000
    -- > 5 loans
    -- born after 1990

SELECT*
FROM loan

SELECT
    c.client_id,
    SUM(l.amount - l.payments) as client_balance,
    COUNT(l.loan_id) as number_of_loans
FROM loan as l
JOIN account as a using (account_id)
JOIN disp as d using (account_id)
JOIN client as c using (client_id)
WHERE l.status IN ('A', 'C') AND d.type = 'OWNER' AND YEAR(c.birth_date) > 1990
GROUP BY c.client_id
HAVING
    SUM(amount - payments) > 1000
    AND COUNT(loan_id) > 5;

-- select client_id, calculate client_balance and number of loans
-- join tables account, disp, client
-- where / filtering the table to find clients (active statuses ans are the owners of accounts)
-- group by client_id
-- HAVING filters based on aggregate condition client_id

-- ANSWER: there is no such customer

########################################
######## SELECTION #####################
########### PART 2 #####################

-- determine which condition caused the empty results

    SELECT
    c.client_id,
    SUM(l.amount - l.payments) as client_balance,
    COUNT(l.loan_id) as number_of_loans
FROM loan as l
JOIN account as a using (account_id)
JOIN disp as d using (account_id)
JOIN client as c using (client_id)
WHERE l.status IN ('A', 'C') AND d.type = 'OWNER' # AND YEAR(c.birth_date) > 1990
GROUP BY c.client_id
HAVING
    SUM(amount - payments) > 1000
    # AND COUNT(loan_id) > 5;  -- the max amount of each client is 1

########################################
######## EXPIRING CARDS ################
########################################

-- SCOPE:
        -- create table / within procedure to delete/truncate it and fill in with new information based on p_date
        -- select information based on joined tables that are needed for further calculation
        -- FILTER information based on exercise condition in WHERE CLAUSE - need to find all the cards that are expiring in next 7 days from the p_date (date from the CALL of the procedure)
        -- end PROCEDURE

-- it can be done with and without cte
-- SHOW PROCEDURE STATUS WHERE Db = 'financial10_56'; -- to check procedure status


DROP TABLE IF EXISTS cards_at_expiration;
CREATE TABLE cards_at_expiration (
    client_id INT,
    card_id INT,
    issued DATE, -- added for check
    expiration_date DATE,
    client_address VARCHAR(255),
    report_date DATE, -- report date = p_date just to have easily readable report for other persons what is going on in here
    PRIMARY KEY (client_id, card_id)
);


DELIMITER $$
DROP PROCEDURE IF EXISTS refresh_cards_at_expiration;
CREATE PROCEDURE refresh_cards_at_expiration(p_date DATE)
BEGIN
    -- Delete existing data from the cards_at_expiration table
    TRUNCATE TABLE cards_at_expiration; -- truncate is faster, deleting whole table

    -- Insert new data into the cards_at_expiration table
    INSERT INTO cards_at_expiration (client_id, card_id, issued, expiration_date, client_address, report_date)
    with cte AS (SELECT c.client_id,
                        ca.card_id,
                        ca.issued,
                        DATE_ADD(ca.issued, INTERVAL 3 YEAR) AS expiration_date, -- calculation expiration date based on the exercise condition
                        d2.A3                                AS client_address
                 FROM card AS ca
                          JOIN disp AS d USING (disp_id)
                          JOIN client AS c USING (client_id)
                          JOIN district AS d2 USING (district_id))
    SELECT *,
           p_date
    FROM cte
    WHERE p_date BETWEEN DATE_ADD(expiration_date, INTERVAL -7 DAY) AND expiration_date;
END$$

DELIMITER ;

CALL refresh_cards_at_expiration('2001-01-01');
SELECT * FROM cards_at_expiration; -- to check the table

###### solution without CTE

DELIMITER $$
DROP PROCEDURE IF EXISTS refresh_cards_at_expiration_report;
CREATE PROCEDURE refresh_cards_at_expiration_report(p_date DATE)
BEGIN
    -- Delete existing data from the cards_at_expiration table
    TRUNCATE TABLE cards_at_expiration; -- truncate is faster, deleting whole table

    -- Insert new data into the cards_at_expiration table
    INSERT INTO cards_at_expiration (client_id, card_id, issued, expiration_date, client_address, report_date)
    SELECT
        c.client_id,
        ca.card_id,
        ca.issued,
        DATE_ADD(ca.issued, INTERVAL 3 YEAR) AS expiration_date, -- calculation expiration date based on the exercise condition
        d2.A3 AS client_address,
        p_date AS report_date -- date the report/table is created
    FROM
        card AS ca
        JOIN disp AS d USING (disp_id)
        JOIN client AS c USING (client_id)
        JOIN district AS d2 USING (district_id)
    WHERE
        p_date BETWEEN DATE_ADD(DATE_ADD(ca.issued, INTERVAL 3 YEAR), INTERVAL -7 DAY) AND DATE_ADD(ca.issued, INTERVAL 3 YEAR);
END$$

DELIMITER ;

CALL refresh_cards_at_expiration_report('2001-01-01');
SELECT * FROM cards_at_expiration; -- to check the table