use `debit and credit banking_data`;

#  Aggregate Queries
#1 Monthly Total Credit and Debit Amounts

SELECT 
  transaction_month,
  transaction_type,
  SUM(amount) AS total_amount
FROM `banking_credit data`
GROUP BY transaction_month, transaction_type
ORDER BY transaction_month;

# 2 Total Transaction Amount by Branch

SELECT 
  branch,
  SUM(amount) AS total_transaction_amount
FROM `banking_credit data`
GROUP BY branch
ORDER BY total_transaction_amount DESC;
#3 Customer with the Highest Total Transactions

SELECT 
  customer_name,
  SUM(amount) AS total_spent
FROM `banking_credit data`
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 1;
--  KPI Queries
# 4 Average Transaction Amount (Credit vs Debit)

SELECT 
  transaction_type,
  AVG(amount) AS avg_transaction
FROM `banking_credit data`
GROUP BY transaction_type;

#5 Customer Retention (Repeat Customers Count)

SELECT 
  customer_name,
  COUNT(*) AS transaction_count
FROM `banking_credit data`
GROUP BY customer_name
HAVING COUNT(*) > 1;
#6 Highest Balance After Credit

SELECT 
  customer_name,
  MAX(balance) AS max_balance
FROM `banking_credit data`
WHERE transaction_type = 'Credit';
#  Advanced / Complex Queries
#7 Net Balance Change by Customer (Credits - Debits)

SELECT 
  customer_name,
  SUM(CASE WHEN transaction_type = 'Credit' THEN amount ELSE -amount END) AS net_change
FROM `banking_credit data`
GROUP BY customer_name
ORDER BY net_change DESC;

#8 Monthly Credit/Debit Ratio

SELECT 
  transaction_month,
  SUM(CASE WHEN transaction_type = 'Credit' THEN amount ELSE 0 END) AS total_credit,
  SUM(CASE WHEN transaction_type = 'Debit' THEN amount ELSE 0 END) AS total_debit,
  ROUND(
    SUM(CASE WHEN transaction_type = 'Credit' THEN amount ELSE 0 END) / 
    NULLIF(SUM(CASE WHEN transaction_type = 'Debit' THEN amount ELSE 0 END), 0), 2
  ) AS credit_debit_ratio
FROM `banking_credit data`
GROUP BY transaction_month;
# 9 Top 5 Customers by Credit Card Spending

SELECT 
  customer_name,
  SUM(amount) AS total_credit_card_spending
FROM `banking_credit data`
WHERE transaction_method = 'Credit Card'
GROUP BY customer_name
ORDER BY total_credit_card_spending DESC
LIMIT 5;

---- end --