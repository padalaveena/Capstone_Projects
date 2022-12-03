CREATE SCHEMA bank_db;  -- creating a database named as bank_db 
USE bank_db;            -- using bank_db database
SELECT * FROM bank_data;    -- selecting all details from bank_data table

-- Qn1: Write SQL query to identify the age group which is taking more loan and then calculate the sum of all 
-- of the balances of it?

-- Answer:-

SELECT DISTINCT age,                  
       count(balance) AS More_loans,   
       sum(balance) AS balances        
FROM bank_data
GROUP BY age                           
ORDER BY More_loans DESC;

/*
Explanation: Here I have to identify the age group which is taking more loan and then calculate the sum of all of the balances
of it. So, Iam using distinct keyword for age for selecting different age groups, count function for balance to count balance of 
each age group then using sum function for balance to sum of balance of each age group. After from clause iam using group by 
clause and order by clause for More_loans to sorting the result set in descending order.
     After executing the above query the result set consists of 3 columns that are age, More_loans and balances and each column 
contains 55 rows.
*/


-- Qn2: write SQL query to calculate for each record if aloan has been taken less 100 ,then calculate the fine of 15% of
-- the current balance and create a temp table and then add the amount for each month from that temp table?

-- Answer:-

CREATE TEMPORARY TABLE fine_amount
WITH cte AS (SELECT age,
               month,
               campaign,
               balance,
               balance*.15 AS fine
FROM bank_data
WHERE campaign<100)
SELECT * FROM cte;
SELECT month,fine FROM fine_amount GROUP BY month;

/*
Explanation:- Here I have to calculate for each record if a loan has been taken less 100 ,then calculate the fine of 15% of
the current balance. So, first Iam creating a temporary table with CTE(Common Table Expression) in that iam selecting age, month,
campaign, balance and iam calculating balance with 15% and using alias to give a temporary name for it from bank_data table and using 
where clause to filter out the result where loan has been taken less than 100(100 means peson). Then iam selecting month and fine 
amount from the temporary table with using group by month.
     After executing the above query the result set consists of two columns that are month and fine and both column contains 12 rows.
*/


-- Qn3: Write an SQL query to calculate each age group along with each department's highest balance record?

-- Answer:-
 
SELECT DISTINCT age,
       job,
       max(balance) as high_balance
from bank_data
group by age,job;

/*
Explanation:- Here I have to calculate each age group along with each department's highest balance record. So , Iam selecting
age with distinct keyword, job and to calculate high amount of balance iam using max function from bank_data table with using 
group by age, job.
    After executing the above query the result set consists of 3 columns with 542 rows.
*/


-- Qn4: write an SQL query to find the secondary highest education, where duration is more than 150. The query should contain
-- only married people, and then calculate the interest amount?(Formula interest--> balance*15%)

-- Ans:- 
 
with details as(select education,
       duration,
       marital,
       balance
from bank_data
where education='secondary' and duration>150 and marital='married')
select duration,balance*'15%' as Interest_amt from details
;

/*
Explanation:- Here I have to find the secondary highest education, where duration is more than 150 with married people. So, Iam 
using CTE(common table expression) named as details in that iam selecting education, duration, marital, balance from bank_data_data table
and using where clause to filter out the result where education is secondary and duration is less than 150 and marital is married.
Then, from details(CTE) iam selecting duration and count the balance with 15%. 
     After executing the above query the result set consists of 2 columns with 7861 rows.
*/


-- Qn5: write an SQL query to find which profession has taken more loan along with age?

-- Answer:-

select distinct age, 
       job,
       sum(loan) as more_loan
from(select distinct age,
            job,
            sum(balance) as loan 
	 from bank_data
     group by age,job) a 
group by job
order by more_loan desc;

/*
Explanation:- Here I have to find the profession with taking more loan. So iam using sub query to solve this. In that sub query 
iam selecting age with distinct keyword, job and using sum function to calculate the total balance and using alias to give a 
temporary name to it from bank_data table and using group by clause with ae, job and the subquery assigned named as a. Then, from that
subquery iam selecting distinct age, job and using sum function to calculate total loan using alias to give a temporary name as more_loan
and using group by job and using order by clause for more_loan to sorting the result set in descending order.
      After executing the above query the result set consists of 3 columns with 12 rows.
*/


-- Qn6: write an SQL query to calculate each month's total balance and then calculate in which month the highest amount
-- of transaction was performed?     

-- Answer:-
 
CREATE TEMPORARY TABLE balace_details
WITH cte AS (SELECT month,
               balance,
               sum(balance) AS total_balance
		FROM bank_data
        GROUP BY month)
SELECT * FROM cte;
SELECT * FROM balace_details;
SELECT month, 
       total_balance 
FROM balace_details 
ORDER BY total_balance DESC
LIMIT 1;

/*
Explanation:- Here I have to calculate each month's total balance and the highest amount of transaction. So, first iam creating 
temporary table named as balance_details with CTE in that iam selecting month, balance and using sum function to calculating the
total balance from the bank_data table and using group by clause with month. For calculating each month's total balance iam selecting all
from balance_details. Then, for calculating the highest amount of transaction iam selcting month, total_balance from bank_details 
and using order by clause for total_balance to sorting the result set in descending order and using limit 1 to return the first 
row.
    After executing the first query the result set consists of 3 columns with 12 rows.
    After executing the second query the result set contains only one row that is the highest transaction amount in the month may.
*/

-- ---------------------------------------------------------------------------------------------------------------------------- --
