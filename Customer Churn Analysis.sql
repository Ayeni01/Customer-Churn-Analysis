-- TASK: Load the Telco Customer Churn Dataset into MySQL
-- Objective: Set up the environment and load the dataset into a MySQL database for analysis.-- Creating Database

CREATE DATABASE telco_churn_db;
USE telco_churn_db;
-- Creating Table
CREATE TABLE customers (
    customerID VARCHAR(50),
    gender VARCHAR(10),
    SeniorCitizen TINYINT,
    Partner VARCHAR(10),
    Dependents VARCHAR(10),
    tenure INT,
    PhoneService VARCHAR(10),
    MultipleLines VARCHAR(20),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(20),
    OnlineBackup VARCHAR(20),
    DeviceProtection VARCHAR(20),
    TechSupport VARCHAR(20),
    StreamingTV VARCHAR(20),
    StreamingMovies VARCHAR(20),
    Contract VARCHAR(20),
    PaperlessBilling VARCHAR(10),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges VARCHAR(20), -- we’ll clean this later in Python
    Churn VARCHAR(10)
);

-- Loading Dataset
LOAD DATA INFILE '/path/to/WA_Fn-UseC_-Telco-Customer-Churn.csv'
INTO TABLE customers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- Verifying 
SELECT COUNT(*) FROM customers;
SELECT * FROM customers LIMIT 5;

-- DAY 12 TASK: Perform Basic SQL Queries (SELECT, WHERE, GROUP BY)
-- Objective: Use SQL to explore the dataset and gain preliminary insights into customer behavior and churn patterns.
-- 1. Basic SELECT and COUNT Queries
-- Total number of customers
SELECT COUNT(*) AS total_customers FROM customers;

-- View the first 10 records
SELECT * FROM customers LIMIT 10;

-- Number of churned vs. non-churned customers
SELECT Churn, COUNT(*) AS count FROM customers GROUP BY Churn;

-- 2. Demographic Breakdown
-- Customers by gender
SELECT gender, COUNT(*) AS count FROM customers GROUP BY gender;

-- Customers by senior citizen status
SELECT SeniorCitizen, COUNT(*) AS count FROM customers GROUP BY SeniorCitizen;

-- Customers with and without partners
SELECT Partner, COUNT(*) FROM customers GROUP BY Partner;

-- Customers with and without dependents
SELECT Dependents, COUNT(*) FROM customers GROUP BY Dependents;

-- 3. Service Usage Breakdown
-- Internet service types
SELECT InternetService, COUNT(*) FROM customers GROUP BY InternetService;

-- Phone service usage
SELECT PhoneService, COUNT(*) FROM customers GROUP BY PhoneService;

-- Customers with multiple lines
SELECT MultipleLines, COUNT(*) FROM customers GROUP BY MultipleLines;

-- Customers by OnlineSecurity service
SELECT OnlineSecurity, COUNT(*) FROM customers GROUP BY OnlineSecurity;

-- Customers by StreamingTV subscription
SELECT StreamingTV, COUNT(*) FROM customers GROUP BY StreamingTV;

-- 4. Financial & Subscription Insights
-- Average monthly charges
SELECT AVG(MonthlyCharges) AS avg_monthly_charge FROM customers;

-- Average tenure of customers
SELECT AVG(tenure) AS avg_tenure FROM customers;

-- Customers by contract type
SELECT Contract, COUNT(*) FROM customers GROUP BY Contract;

-- Distribution of payment methods
SELECT PaymentMethod, COUNT(*) FROM customers GROUP BY PaymentMethod;

-- 5. Churn Rate by Category
-- Churn rate by gender
SELECT gender, 
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS churn_rate
FROM customers
GROUP BY gender;

-- Churn by contract type
SELECT Contract, 
       COUNT(*) AS total_customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS churn_rate
FROM customers
GROUP BY Contract;

-- Churn by tenure bucket
SELECT
  CASE
    WHEN tenure BETWEEN 0 AND 12 THEN '0-1 Year'
    WHEN tenure BETWEEN 13 AND 24 THEN '1-2 Years'
    WHEN tenure BETWEEN 25 AND 36 THEN '2-3 Years'
    WHEN tenure BETWEEN 37 AND 48 THEN '3-4 Years'
    WHEN tenure BETWEEN 49 AND 60 THEN '4-5 Years'
    ELSE '5+ Years'
  END AS tenure_group,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
  ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS churn_rate
FROM customers
GROUP BY tenure_group;

-- 6. Combined Group Insights
-- Monthly charges by churn status
SELECT Churn, 
       ROUND(AVG(MonthlyCharges), 2) AS avg_monthly,
       ROUND(MAX(MonthlyCharges), 2) AS max_monthly,
       ROUND(MIN(MonthlyCharges), 2) AS min_monthly
FROM customers
GROUP BY Churn;

-- Churn rate by InternetService
SELECT InternetService,
       COUNT(*) AS total_customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS churn_rate
FROM customers
GROUP BY InternetService;

-- 7. Filtering Specific Groups
-- Customers with tenure > 12 months and churned
SELECT * FROM customers
WHERE tenure > 12 AND Churn = 'Yes';

-- Senior citizens with fiber optic internet who churned
SELECT * FROM customers
WHERE SeniorCitizen = 1 AND InternetService = 'Fiber optic' AND Churn = 'Yes';

-- High spenders who did not churn
SELECT * FROM customers
WHERE MonthlyCharges > 90 AND Churn = 'No';

-- TASK: Identify Churned Customers Using SQL
-- Objective: Use SQL to isolate churned customers, uncover churn patterns, and prepare key segments for deeper analysis.

-- Step-by-Step Breakdown
-- 1. Isolate Churned Customers
-- Start by pulling all customers who have churned:
SELECT * FROM customers
WHERE Churn = 'Yes';

-- 2. Analyze Churned Customer Count
SELECT COUNT(*) AS churned_customers
FROM customers
WHERE Churn = 'Yes';

-- 3. Churn by Demographics
-- a. Gender
SELECT gender, COUNT(*) AS churned_count
FROM customers
WHERE Churn = 'Yes'
GROUP BY gender;

-- b. Senior Citizens
SELECT SeniorCitizen, COUNT(*) AS churned_count
FROM customers
WHERE Churn = 'Yes'
GROUP BY SeniorCitizen;

-- c. Dependents & Partners
SELECT Partner, Dependents, COUNT(*) AS churned_count
FROM customers
WHERE Churn = 'Yes'
GROUP BY Partner, Dependents;

-- 4. Churn by Service Type
-- a. Internet Service
SELECT InternetService, COUNT(*) AS churned_count
FROM customers
WHERE Churn = 'Yes'
GROUP BY InternetService;

-- b. Streaming Services
SELECT StreamingTV, StreamingMovies, COUNT(*) AS churned_count
FROM customers
WHERE Churn = 'Yes'
GROUP BY StreamingTV, StreamingMovies;

-- c. Tech Support and Security Services
SELECT OnlineSecurity, TechSupport, COUNT(*) AS churned_count
FROM customers
WHERE Churn = 'Yes'
GROUP BY OnlineSecurity, TechSupport;

-- 5. Churn by Contract Type & Payment
SELECT Contract, PaymentMethod, COUNT(*) AS churned_count
FROM customers
WHERE Churn = 'Yes'
GROUP BY Contract, PaymentMethod;

-- 6. High-Risk Segments: Combined Conditions
-- a. Short Tenure & Month-to-Month
SELECT * FROM customers
WHERE Churn = 'Yes' AND tenure <= 12 AND Contract = 'Month-to-month';

-- b. Senior Citizens with Fiber Optic
SELECT * FROM customers
WHERE Churn = 'Yes' AND SeniorCitizen = 1 AND InternetService = 'Fiber optic';

-- c. Customers with No Security or Support
SELECT * FROM customers
WHERE Churn = 'Yes' AND OnlineSecurity = 'No' AND TechSupport = 'No';

-- 7. Create a View (Optional)
-- For easier future access:

CREATE VIEW churned_customers AS
SELECT * FROM customers
WHERE Churn = 'Yes';