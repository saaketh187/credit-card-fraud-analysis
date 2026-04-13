---	Total Transactions ---
select COUNT(*) AS Total_transactions
from Transactions;

--- Fraud vs Genuine ---
select c31,count(*) as transactions_count
from Transactions
group by c31;

--- Fraud Percentage ---
SELECT 
    ROUND(COUNT(CASE WHEN C31 = 1 THEN 1 END) * 100.0 / COUNT(*), 2) AS Fraud_Rate_Percentage
FROM Transactions;

--- Average Amount by class ---
SELECT 
    C31 AS Class,
    ROUND(AVG(C30), 2) AS Average_Amount
FROM Transactions
GROUP BY C31;

--- Total Money Lost to Fraud ---
SELECT 
    ROUND(SUM(C30), 2) AS Total_Fraud_Amount
FROM Transactions
WHERE C31 = 1;

--- Top 10 Fraud Transactions ---
SELECT 
    C30 AS Amount,
    C1 AS Time
FROM Transactions
WHERE C31 = 1
ORDER BY C30 DESC
LIMIT 10;

--- Fraud by time period ---
SELECT 
    CASE 
        WHEN CAST(C1 AS FLOAT) <= 86400 THEN 'Day 1'
        ELSE 'Day 2'
    END AS Day_Period,
    COUNT(*) AS Fraud_Count
FROM Transactions
WHERE C31 = 1
GROUP BY Day_Period;

--- Amount Range Fraud ---
SELECT 
    CASE 
        WHEN CAST(C30 AS FLOAT) <= 50 THEN '€0-€50'
        WHEN CAST(C30 AS FLOAT) <= 100 THEN '€51-€100'
        WHEN CAST(C30 AS FLOAT) <= 500 THEN '€101-€500'
        WHEN CAST(C30 AS FLOAT) <= 1000 THEN '€501-€1000'
        ELSE 'Above €1000'
    END AS Amount_Range,
    COUNT(*) AS Fraud_Count
FROM Transactions
WHERE C31 = 1
GROUP BY Amount_Range
ORDER BY Fraud_Count DESC;

--- Running Total ---
SELECT 
    C1 AS Time,
    C30 AS Amount,
    SUM(CAST(C30 AS FLOAT)) OVER (ORDER BY C1) AS Running_Total
FROM Transactions
WHERE C31 = 1
ORDER BY C1
LIMIT 10;