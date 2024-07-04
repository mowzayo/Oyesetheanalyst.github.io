CREATE DATABASE SplendorInsurance;
SELECT * FROM InsurancePolicies;
SELECT AVG(claim_freq) AS AVGFREQ FROM InsurancePolicies WHERE marital_status = 'Single';
SELECT  birthdate
FROM InsurancePolicies;

-- 
SELECT DATEPART(YEAR, GETDATE()) - DATEPART(YEAR, birthdate) AS Age
FROM InsurancePolicies


-- CHANGE CLAIM FREQ int  TO DECIMAL --
ALTER TABLE InsurancePolicies
ALTER COLUMN claim_freq decimal;

-- change claim_amt to decimal
ALTER TABLE InsurancePolicies
ALTER COLUMN claim_amt decimal;

-- replace $ for blank in claim_amt
UPDATE InsurancePolicies
SET claim_amt = REPLACE(claim_amt, '$', '');

-- replace $ for blank in household_income
UPDATE InsurancePolicies
SET household_income = REPLACE(household_income, '$', '');

-- change household income to decimal
ALTER TABLE InsurancePolicies
ALTER COLUMN household_income decimal;

-- policy holders . policy holders with claim freq abobe 2 and income less than $125k are high risk policy holders --
SELECT 
    COUNT(CASE 
        WHEN claim_freq > 2 AND household_income < 125000 THEN 1 
        ELSE NULL 
    END) AS HighRiskHolder,
    COUNT(CASE 
        WHEN NOT (claim_freq > 2 AND household_income < 125000) THEN 1 
        ELSE NULL 
    END) AS LowRiskHolder
FROM 
    InsurancePolicies;

-- ADD INCOME GROUP 
ALTER TABLE InsurancePolicies
ADD IncomeGroup VARCHAR(100) ;

-- Update income column --
UPDATE InsurancePolicies
SET IncomeGroup = 
    CASE 
        WHEN claim_freq > 2 AND household_income < 125000 THEN 'HighRisk'
        ELSE 'LowRisk'
    END;

-- Add Age column --
ALTER TABLE InsurancePolicies
ADD Age INT;

-- Update age column --
UPDATE InsurancePolicies
SET Age = DATEPART(YEAR, GETDATE()) - DATEPART(YEAR, birthdate);

-- Add agegroup column --
ALTER TABLE InsurancePolicies
ADD AgeGroup VARCHAR(100);

-- update age column --
UPDATE InsurancePolicies
Set  AgeGroup = CASE
        WHEN age BETWEEN 22 AND 30 THEN '22-30'
        WHEN age BETWEEN 31 AND 40 THEN '31-40'
        WHEN age BETWEEN 41 AND 50 THEN '41-50'
        WHEN age BETWEEN 51 AND 60 THEN '51-60'
        ELSE 'Over 60'
    END;


/*1,Claim Frequency and Amount Analysis
What are the average claim frequencies and amounts for different demographic groups (e.g., age, gender, marital status)? */

--Age --
SELECT 
AgeGroup,
  AVG(claim_freq) AS AVGFREQ,
AVG(claim_amt) AS CLAIMAMOUNT
FROM 
    InsurancePolicies
GROUP BY 
   AgeGroup

-- GENDER 

SELECT 
Gender,
  AVG(claim_freq) AS AVGFREQ,
AVG(claim_amt) AS CLAIMAMOUNT
FROM 
    InsurancePolicies
GROUP BY 
   Gender
--marital status
SELECT 
marital_status,
  AVG(claim_freq) AS AVGFREQ,
AVG(claim_amt) AS CLAIMAMOUNT
FROM 
    InsurancePolicies
GROUP BY 
   marital_status

-- 1b Are there any specific vehicle characteristics (e.g., make, model, year) that correlate with higher claim frequencies or amounts?

SELECT 
    car_year,
    SUM(claim_amt) AS sumAmount,
    SUM(claim_freq) AS sumFreq
FROM 
    InsurancePolicies
WHERE claim_freq > '2'
GROUP BY 
    car_year
ORDER BY car_year DESC

/*2Risk Assessment
Which factors (e.g., household income, education level, coverage zone) are most indicative of high-risk policyholders? */
SELECT 
    Education,
    IncomeGroup,
    Coverage_zone,
     COUNT(*) AS num_policyholders,
    ROUND(SUM(claim_freq),1) AS Total_freq,
    ROUND(SUM(Household_income),0) Total_income
FROM
InsurancePolicies
    WHERE IncomeGroup = 'HighRisk'
GROUP BY
    IncomeGroup,
    education,
    coverage_zone
    ORDER BY num_policyholders DESC,Total_freq DESC,Total_income DESC;

--2b Can we identify any common characteristics among policyholders who make frequent claims?

SELECT 
    marital_status,
    gender,
    education,
    claim_freq,
    CASE
        WHEN claim_freq BETWEEN 2 AND 3 THEN '2-3'
        WHEN claim_freq = 4 THEN '4+'
        ELSE 'Other'
    END AS claim_category
FROM 
    InsurancePolicies
WHERE 
    claim_freq BETWEEN 2 AND 3
    OR claim_freq = 4;
-- percent
SELECT 
    marital_status,
    gender,
    education,
    claim_category,
    COUNT(*) AS claim_count
FROM (
    SELECT 
        marital_status,
        gender,
        education,
        claim_freq,
        CASE
            WHEN claim_freq BETWEEN 2 AND 3 THEN '2-3'
            WHEN claim_freq = 4 THEN '4+'
            ELSE 'Other'
        END AS claim_category
    FROM 
        InsurancePolicies
    WHERE 
        claim_freq BETWEEN 2 AND 3
        OR claim_freq = 4
) AS subquery
GROUP BY 
    marital_status,
    gender,
    education,
    claim_category
ORDER BY 
    claim_count DESC;
-- percent
SELECT 
    marital_status,
    gender,
    education,
    claim_category,
    COUNT(*) AS claim_count,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY marital_status, gender, education) AS percentage
FROM (
    SELECT 
        marital_status,
        gender,
        education,
        claim_freq,
        CASE
            WHEN claim_freq BETWEEN 2 AND 3 THEN '2-3'
            WHEN claim_freq = 4 THEN '4+'
            ELSE 'Other'
        END AS claim_category
    FROM 
        InsurancePolicies
    WHERE 
        claim_freq BETWEEN 2 AND 3
        OR claim_freq = 4
) AS subquery
GROUP BY 
    marital_status,
    gender,
    education,
    claim_category
ORDER BY 
    claim_count DESC;

/*3Premium Optimization
 How do current premium amounts relate to the risk profiles of policyholders?*/

/* 4Customer Segmentation and Marketing
What are the key characteristics of policyholders with low claim frequencies and high household incomes?*/

SELECT education,marital_status ,
COUNT (*) AS COUNT
FROM InsurancePolicies
WHERE claim_freq <= '2'AND household_income > '125000'
GROUP BY education,marital_status 
ORDER BY COUNT DESC

/*4B How can we segment the customer base to identify high-value customers for targeted marketing campaigns? */
SELECT TOP 10 marital_status,education,coverage_zone,
COUNT(*) AS COUNT
FROM InsurancePolicies
WHERE household_income > '125000' AND claim_freq = '0'
GROUP BY marital_status,education,coverage_zone
ORDER BY COUNT ASC

/* 5A Demographic Analysis

How does the distribution of policyholders vary across different demographic factors (age, gender, marital status)? */
SELECT AgeGroup,gender,marital_status,
COUNT(*) AS COUNT
FROM InsurancePolicies
GROUP BY AgeGroup,gender,marital_status
ORDER BY COUNT DESC

/*5BAre there any noticeable trends in car usage and ownership among different demographic groups?*/
SELECT car_use,AgeGroup,COUNT(*) AS COUNT
FROM InsurancePolicies
GROUP BY car_use,AgeGroup
ORDER BY COUNT DESC

SELECT car_use,marital_status,COUNT(*) AS COUNT
FROM InsurancePolicies
GROUP BY car_use,marital_status
ORDER BY COUNT DESC

/*6A Geographical Analysis
How do claim frequencies and amounts vary across different coverage zones?
*/

SELECT SUM(claim_amt) AS CLAIM,SUM(claim_freq) AS FREQ,coverage_zone,COUNT(*) AS COUNT
FROM InsurancePolicies
GROUP BY coverage_zone
ORDER BY COUNT DESC

/*6B Are there any regional trends or patterns that should be taken into consideration for marketing or risk assessment? */
SELECT coverage_zone,marital_status,claim_freq,COUNT(*) AS COUNT
FROM InsurancePolicies
WHERE household_income > '125000' AND claim_freq < '2'
GROUP BY  coverage_zone,marital_status,claim_freq
ORDER BY claim_freq,COUNT ASC

SELECT coverage_zone,car_use,COUNT(*) AS COUNT
FROM InsurancePolicies
WHERE household_income > '125000' AND claim_freq  < '2'
GROUP BY  coverage_zone,car_use
ORDER BY COUNT DESC
-- another 
SELECT 
    coverage_zone,
    AVG(claim_freq) AS AvgClaimFreq,
    SUM(claim_freq) AS TotalClaimFreq,
    AVG(claim_amt) AS AvgClaimAmt,
    SUM(claim_amt) AS TotalClaimAmt,
    COUNT(ID) AS PolicyholderCount,
    AVG(household_income) AS AvgHouseholdIncome,
    AVG(DATEDIFF(YEAR, birthdate, GETDATE())) AS AvgPolicyholderAge,
    COUNT(CASE WHEN kids_driving > 0 THEN 1 ELSE NULL END) AS PolicyholdersWithKidsDriving,
    COUNT(CASE WHEN marital_status = 'Married' THEN 1 ELSE NULL END) AS MarriedPolicyholders,
    COUNT(CASE WHEN car_use = 'Commercial' THEN 1 ELSE NULL END) AS CommercialCarUse
FROM 
    InsurancePolicies
GROUP BY 
    coverage_zone
ORDER BY 
    coverage_zone;


/* 7 Customer Behavior Insights
Are there any trends or patterns in the behavior of policyholders who have children driving?*/
SELECT TOP 30 marital_status, education,car_use,coverage_zone,AgeGroup,COUNT(*)AS COUNT
FROM InsurancePolicies
WHERE kids_driving > '0'
GROUP BY marital_status, education,car_use,coverage_zone,AgeGroup
ORDER BY COUNT DESC
-- another way 
SELECT 
    kids_driving,
    AVG(claim_freq) AS AvgClaimFreq,
    SUM(claim_freq) AS TotalClaimFreq,
    AVG(claim_amt) AS AvgClaimAmt,
    SUM(claim_amt) AS TotalClaimAmt,
    COUNT(ID) AS PolicyholderCount,
    AVG(household_income) AS AvgHouseholdIncome,
    AVG(DATEDIFF(YEAR, birthdate, GETDATE())) AS AvgPolicyholderAge
FROM 
    InsurancePolicies
WHERE 
    kids_driving > 0
GROUP BY 
    kids_driving
ORDER BY 
    kids_driving;

SELECT 
    CASE 
        WHEN kids_driving = 0 THEN '0'
        WHEN kids_driving = 1 THEN '1'
        WHEN kids_driving = 2 THEN '2'
        WHEN kids_driving = 3 THEN '3'
        ELSE 'Others'
    END AS KidsDrivingGroup,
    SUM(claim_freq) AS TotalClaimFreq
FROM 
    InsurancePolicies
GROUP BY 
    CASE 
        WHEN kids_driving = 0 THEN '0'
        WHEN kids_driving = 1 THEN '1'
        WHEN kids_driving = 2 THEN '2'
        WHEN kids_driving = 3 THEN '3'
        ELSE 'Others'
    END
ORDER BY TotalClaimFreq DESC;
/*7b How does the presence of children driving affect the frequency and number of claims?*/



SELECT 
    CASE 
        WHEN kids_driving = 0 THEN '0'
        WHEN kids_driving = 1 THEN '1'
        WHEN kids_driving = 2 THEN '2'
        WHEN kids_driving = 3 THEN '3'
        ELSE 'Others'
    END AS KidsDrivingGroup,
    SUM(claim_freq) AS TotalClaimFreq
FROM 
    InsurancePolicies
GROUP BY 
    CASE 
        WHEN kids_driving = 0 THEN '0'
        WHEN kids_driving = 1 THEN '1'
        WHEN kids_driving = 2 THEN '2'
        WHEN kids_driving = 3 THEN '3'
        ELSE 'Others'
    END
ORDER BY TotalClaimFreq DESC;



-- slide --
SELECT COUNT(*) 
FROM InsurancePolicies
WHERE  marital_status = 'single' AND IncomeGroup = 'LowRisk'


SELECT COUNT(car_make) as car,education
FROM InsurancePolicies
WHERE marital_status = 'single' AND car_make = 'ford'
GROUP BY education


SELECT SUM(household_income) AS household,SUM(claim_amt) AS claim,gender AS policyholders
FROM InsurancePolicies
WHERE   marital_status = 'single' AND IncomeGroup = 'HighRisk' 
GROUP BY gender

SELECT COUNT(education) AS PolicyHolders,education
FROM InsurancePolicies
WHERE IncomeGroup = 'LowRisk' And gender = 'Male' AND marital_status = 'single'
GROUP BY education

SELECT COUNT(marital_status) 
FROM InsurancePolicies
WHERE IncomeGroup = 'HighRisk' And gender = 'Male' AND marital_status = 'single'



SELECT COUNT(coverage_zone) AS Policyholder,coverage_zone
FROM InsurancePolicies
WHERE IncomeGroup = 'HighRisk' AND marital_status = 'Single'
GROUP BY coverage_zone
ORDER BY Policyholder DESC

SELECT COUNT(coverage_zone) AS PolicyholdeRM,coverage_zone
FROM InsurancePolicies
WHERE IncomeGroup = 'HighRisk' AND marital_status = 'Single' AND gender = 'Male'
GROUP BY coverage_zone
ORDER BY PolicyholderM DESC

SELECT COUNT(coverage_zone) AS PolicyholderF,coverage_zone
FROM InsurancePolicies
WHERE IncomeGroup = 'HighRisk' AND marital_status = 'Single' AND gender = 'Female'
GROUP BY coverage_zone
ORDER BY PolicyholderF DESC

SELECT SUM(household_income),gender AS claimm
FROM InsurancePolicies
WHERE IncomeGroup = 'HighRisk' AND marital_status = 'Single' 
GROUP BY gender
ORDER BY claimm DESC

SELECT SUM(household_income) AS claimm
FROM InsurancePolicies
WHERE IncomeGroup = 'HighRisk' AND marital_status = 'Single' 
ORDER BY claimm DESC

SELECT MAX(Age) AS age
FROM InsurancePolicies
WHERE marital_status = 'Single' AND gender = 'male'


Link to report: https://docs.google.com/document/d/1m57iQy6MQRdTkCrddppQUaMgfdicl7Q4/edit?usp=sharing&ouid=111446565330267740289&rtpof=true&sd=true
