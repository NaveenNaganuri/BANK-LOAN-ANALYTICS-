use banking_data_1;
-- Aggregate Function Queries

-- Query 1: Total, average, min, and max loan amount
SELECT 
    SUM(`Loan Amount`) AS total_loan,
    AVG(`Loan Amount`) AS avg_loan,
    MIN(`Loan Amount`) AS min_loan,
    MAX(`Loan Amount`) AS max_loan
FROM `banking data-csv`;

-- Query 2: Average interest rate per term
SELECT 
    `Term`, 
    AVG(`Int Rate`) AS avg_interest_rate
FROM `banking data-csv`
GROUP BY `Term`;

-- Query 3: Total payment received by state
SELECT 
    `State Name`, 
    SUM(`Total Pymnt`) AS total_payment
FROM `banking data-csv`
GROUP BY `State Name`;

-- KPI Queries

-- Query 1: Default loan rate (percentage)
SELECT 
    (COUNT(CASE WHEN `Is Default Loan` = 'Yes' THEN 1 END) * 100.0) / COUNT(*) AS default_loan_percentage
FROM `banking data-csv`;

-- Query 2: Average funded amount per product category
SELECT 
    `Purpose Category`, 
    AVG(`Funded Amount`) AS avg_funded_amount
FROM `banking data-csv`
GROUP BY `Purpose Category`;

-- Query 3: Collection recovery effectiveness (recoveries as % of funded amount)
SELECT 
    SUM(`Recoveries`) / SUM(`Funded Amount`) * 100 AS recovery_effectiveness_percent
FROM `banking data-csv`;

-- Complex Queries

-- Query 1: Total funded amount by delinquency status and state
SELECT 
    `State Name`, 
    `Is Delinquent Loan`, 
    SUM(`Funded Amount`) AS total_funded
FROM `banking data-csv`
GROUP BY `State Name`, `Is Delinquent Loan`
ORDER BY total_funded DESC;

-- Query 2: Average interest rate and payment by caste and gender
SELECT 
    `Caste`, 
    `Gender ID`, 
    AVG(`Int Rate`) AS avg_interest_rate,
    AVG(`Total Pymnt`) AS avg_payment
FROM `banking data-csv`
GROUP BY `Caste`, `Gender ID`;

-- Query 3: Top 5 branches by total disbursed loan
SELECT 
    `Branch Name`, 
    SUM(`Loan Amount`) AS total_disbursed
FROM `banking data-csv`
GROUP BY `Branch Name`
ORDER BY total_disbursed DESC
LIMIT 5;
