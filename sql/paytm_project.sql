 -- create database paytm_db;
USE paytm_db;
select count(*) from paytm_transaction;
alter table paytm_transaction modify column timestamp datetime;
-- total transaction;
select count( `transaction id`) from paytm_transaction;
-- total amount
select sum(`amount (INR)`) from paytm_transaction;
-- state wise analysis
select sum(`amount (INR)`),sender_state from paytm_transaction
group by sender_state ;
select max(`amount (INR)`),sender_state from paytm_transaction
group by sender_state
order by sender_state desc ;
select * from paytm_transaction;
-- state wise transaction success rate
select sender_state,
count(*) as total_transactions,
sum(case when transaction_status = 'success' then 1 else 0 end) as successfull_transactions,
round(( sum(case when transaction_status = 'success' then 1 else 0 end)*100.0)/count(*),2) as success_rate_percentage
from  paytm_transaction
group by sender_state
order by success_rate_percentage  desc ;

-- top revenue generating merchant categories
SELECT 
    merchant_category,
    COUNT(*) AS number_of_orders,
    SUM(`amount (INR)`) AS total_revenue,
    ROUND(AVG(`amount (INR)`), 2) AS average_transaction_value
FROM paytm_transaction
WHERE transaction_status = 'SUCCESS'
GROUP BY merchant_category
ORDER BY total_revenue DESC;

-- user behaviour by device type

SELECT 
    device_type,
    COUNT(*) AS total_users_count,
    SUM(`amount (INR)`) AS total_spent,
    ROUND(AVG(`amount (INR)`), 2) AS avg_spent_per_device,
    SUM(CASE WHEN transaction_status = 'FAILED' THEN 1 ELSE 0 END) AS failed_count
FROM paytm_transaction
GROUP BY device_type
ORDER BY total_spent DESC;


-- high_value fraud detection
SELECT 
    (`transaction id`), 
    sender_state, 
    merchant_category, 
    (`amount (INR)`), 
    device_type
FROM paytm_transaction
WHERE `amount (INR)` > (SELECT AVG(`amount (INR)`) * 3 FROM paytm_transaction)
AND transaction_status = 'SUCCESS'
ORDER BY `amount (INR)` DESC;

-- inter-state money flow
SELECT 
    sender_bank, 
    receiver_bank, 
    COUNT(*) AS total_transactions,
    SUM(`amount (INR)`) AS total_money_transferred
FROM paytm_transaction
WHERE sender_bank != receiver_bank 
  AND transaction_status = 'SUCCESS'
GROUP BY sender_bank, receiver_bank
ORDER BY total_money_transferred DESC
LIMIT 10;

-- suspicious merchant velocity
SELECT 
    merchant_category,
    COUNT(*) AS total_attempts,
    ROUND(AVG((`amount (INR)`)), 2) AS avg_amount,
    SUM(CASE WHEN transaction_status = 'FAILED' THEN 1 ELSE 0 END) AS failed_attempts,
    ROUND((SUM(CASE WHEN transaction_status = 'FAILED' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS failure_rate_percentage
FROM paytm_transaction
GROUP BY merchant_category
HAVING total_attempts > 10 AND avg_amount > (SELECT AVG((`amount (INR)`)) FROM paytm_transaction)
ORDER BY failure_rate_percentage DESC;

 -- transaction ticket size bucket
SELECT 
    CASE 
        WHEN (`amount (INR)`) <= 100 THEN 'Micro (Rs 0-100)'
        WHEN (`amount (INR)`) > 100 AND (`amount (INR)`) <= 1000 THEN 'Medium (Rs 101-1000)'
        WHEN (`amount (INR)`) > 1000 AND (`amount (INR)`) <= 5000 THEN 'High (Rs 1001-5000)'
        ELSE 'Ultra High (Above Rs 5000)'
    END AS transaction_bucket,
    COUNT(*) AS transaction_count,
    SUM((`amount (INR)`)) AS total_bucket_amount,
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM paytm_transaction), 2) AS contribution_percentage
FROM paytm_transaction
WHERE transaction_status = 'SUCCESS'
GROUP BY 1
ORDER BY transaction_count DESC;
