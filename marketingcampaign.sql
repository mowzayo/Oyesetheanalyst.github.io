CREATE DATABASE MarketData;
-- view  full data --
SELECT * FROM MarketData;

            -- Campaign Performance:
-- Which campaign generated the highest number of impressions, clicks, and conversions?

-- Campaign with the highest number of impressions
WITH CampaignMetrics AS (
    SELECT 
        Campaign,
        SUM(Impressions) AS TotalImpressions,
        SUM(Clicks) AS TotalClicks,
        SUM(Conversions) AS TotalConversions
    FROM 
        MarketData
    GROUP BY 
        Campaign
)
SELECT 
    Campaign,
    TotalImpressions,
    TotalClicks,
    TotalConversions
FROM 
    CampaignMetrics
WHERE 
    TotalImpressions = (SELECT MAX(TotalImpressions) FROM CampaignMetrics)
    OR TotalClicks = (SELECT MAX(TotalClicks) FROM CampaignMetrics)
    OR TotalConversions = (SELECT MAX(TotalConversions) FROM CampaignMetrics)
ORDER BY 
    Campaign;




-- b)What is the average cost-per-click (CPC) and click-through rate (CTR) for each campaign?

SELECT 
    Campaign,
    AVG(Daily_Average_CPC) AS AvgCPC,
    AVG(CTR) AS AvgCTR
FROM 
    MarketData
GROUP BY 
    Campaign
ORDER BY 
    Campaign;


-- Channel Effectiveness: --
-- 2a.Which channel has the highest ROI? -- 

SELECT 
    Channel,
    SUM(Total_Conversion_Value_GBP) AS Revenue,
    SUM(Spend_GBP) AS ProductionCost,
    ROUND(SUM(Total_Conversion_Value_GBP - Spend_GBP), 1) AS NetProfit,
    CASE
        WHEN SUM(Spend_GBP) = 0 THEN NULL
        ELSE ROUND((SUM(Total_Conversion_Value_GBP - Spend_GBP) / SUM(Spend_GBP)) * 100, 1)
    END AS ROI
FROM 
    MarketData
GROUP BY 
    Channel
ORDER BY 
    ROI DESC
;


-- How do impressions, clicks, and conversions vary across different channels?--
-- Looking at there average --

SELECT 
    Channel,
    SUM(Impressions) AS Total_Impressions,
    SUM(Clicks) AS Total_Clicks,
    SUM(Conversions) AS Total_Conversions,
    AVG(Impressions) AS Avg_Daily_Impressions,
    AVG(Clicks) AS Avg_Daily_Clicks,
    AVG(Conversions) AS Avg_Daily_Conversions
FROM 
    MarketData
GROUP BY 
    Channel
ORDER BY 
    Channel;

-- 3)Geographical Insights:
--3A) Which cities have the highest engagement rates (likes, shares, comments)?

SELECT 
    City_Location,
    SUM(Likes_Reactions) AS Total_Likes,
    SUM(Shares) AS Total_Shares,
    SUM(Comments) AS Total_Comments,
    (SUM(Likes_Reactions) + SUM(Shares) + SUM(Comments)) AS Total_Engagement
FROM 
   MarketData
GROUP BY 
    City_Location
ORDER BY 
    Total_Engagement DESC;

--3B)What is the conversion rate by city?

    SELECT 
    City_Location,
    SUM(Clicks) AS Total_Clicks,
    SUM(Conversions) AS Total_Conversions,
    CASE 
        WHEN SUM(Clicks) = 0 THEN 0
        ELSE (CAST(SUM(Conversions) AS FLOAT) / CAST(SUM(Clicks) AS FLOAT)) * 100
    END AS Conversion_Rate_Percentage
FROM 
    MarketData
GROUP BY 
    City_Location
ORDER BY 
    Conversion_Rate_Percentage DESC;

-- Device Performance:
--4a)How do ad performances compare across different devices (mobile, desktop, tablet)?
SELECT 
    Device,
    SUM(Impressions) AS Total_Impressions,
    SUM(Clicks) AS Total_Clicks,
    SUM(Conversions) AS Total_Conversions,
    CASE 
        WHEN SUM(Clicks) = 0 THEN 0
        ELSE (CAST(SUM(Conversions) AS FLOAT) / CAST(SUM(Clicks) AS FLOAT)) * 100
    END AS Conversion_Rate_Percentage,
    SUM(Likes_Reactions) AS Total_Likes,
    SUM(Shares) AS Total_Shares,
    SUM(Comments) AS Total_Comments
FROM 
   MarketData
GROUP BY 
    Device
ORDER BY 
    Total_Impressions DESC;

-- 4b)Which device type generates the highest conversion rates?
 SELECT TOP 1
    Device,
    SUM(Clicks) AS Total_Clicks,
    SUM(Conversions) AS Total_Conversions,
    CASE 
        WHEN SUM(Clicks) = 0 THEN 0
        ELSE (CAST(SUM(Conversions) AS FLOAT) / CAST(SUM(Clicks) AS FLOAT)) * 100
    END AS Conversion_Rate_Percentage
FROM 
    MarketData
GROUP BY 
    Device
ORDER BY 
    Conversion_Rate_Percentage DESC;

-- 5A) Ad-Level Analysis:
-- Which specific ads are performing best in terms of engagement and conversions?
SELECT 
    Ad,
    SUM(Conversions) AS Total_Conversions,
    (SUM(Likes_Reactions) + SUM(Shares) + SUM(Comments)) AS Total_Engagement,
    CASE 
        WHEN SUM(Clicks) = 0 THEN 0
        ELSE (CAST(SUM(Conversions) AS FLOAT) / CAST(SUM(Clicks) AS FLOAT)) * 100
    END AS Conversion_Rate_Percentage
FROM 
    MarketData
GROUP BY 
    Ad
ORDER BY 
    Total_Engagement DESC, 
    Conversion_Rate_Percentage DESC;
--5b) What are the common characteristics of high-performing ads?
SELECT TOP 5
    Ad,
    Channel,
    Device,
    Campaign,
    SUM(Conversions) AS Total_Conversions,
    (SUM(Likes_Reactions) + SUM(Shares) + SUM(Comments)) AS Total_Engagement,
    CASE 
        WHEN SUM(Clicks) = 0 THEN 0
        ELSE (CAST(SUM(Conversions) AS FLOAT) / CAST(SUM(Clicks) AS FLOAT)) * 100
    END AS Conversion_Rate_Percentage
FROM 
    MarketData
GROUP BY 
    Ad, Channel, Device, Campaign
ORDER BY 
    Total_Engagement DESC, Conversion_Rate_Percentage DESC
;
-- 6A) ROI Calculation:
--What is the ROI for each campaign, and how does it compare across different channels and devices

SELECT 
    Campaign,
    Channel,
    Device,
    SUM(Total_Conversion_Value_GBP) AS TotalConversionValue,
    SUM(Spend_GBP) AS SpendGBP,
    SUM(Total_Conversion_Value_GBP - Spend_GBP) AS NetProfit,
    CASE
        WHEN SUM(Spend_GBP) = 0 THEN NULL
        ELSE (SUM(Total_Conversion_Value_GBP - Spend_GBP) / SUM(Spend_GBP)) * 100
    END AS ROI
FROM 
    MarketData
GROUP BY 
    Campaign, Channel, Device
ORDER BY 
    Campaign, Channel, Device;

    SELECT Campaign,
SUM(Total_conversion_value_GBP) AS Revenue,
SUM(Spend_GBP) AS ProductionCost,
ROUND (SUM(Total_conversion_value_GBP-Spend_GBP),1) AS NetProfit,
ROUND (SUM(Total_conversion_value_GBP-Spend_GBP)/SUM(Spend_GBP) * 100,1) AS ROI
FROM MarketData
GROUP BY Campaign
ORDER BY ROI DESC;
-- 6B)How does spend correlate with conversion value across different campaigns?
SELECT 
    Campaign,
    SUM(Spend_GBP) AS Total_spend,
    Round(SUM(Total_conversion_value_GBP), 0) AS Total_conversion_value
FROM 
    MarketData
GROUP BY 
    campaign
    ORDER BY Total_spend DESC, Total_conversion_value DESC;

--7A) Time Series Analysis:

--Are there any noticeable trends or seasonal effects in ad performance over time?


SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(Impressions) AS TotalImpressions,
    SUM(Clicks) AS TotalClicks,
    SUM(Conversions) AS TotalConversions,
    AVG(Clicks * 100.0 / NULLIF(Impressions, 0)) AS AvgCTR
FROM 
    MarketData
GROUP BY 
    YEAR(Date), MONTH(Date)
ORDER BY 
    YEAR(Date), MONTH(Date);

--7B) How do daily impressions, clicks, spend, and conversions fluctuate over the campaign period?

SELECT TOP 10
    Date,
    SUM(Impressions) AS TotalImpressions,
    SUM(Clicks) AS TotalClicks,
    SUM(Spend_GBP) AS TotalSpend,
    SUM(Conversions) AS TotalConversions
FROM
   MarketData
GROUP BY
    Date
ORDER BY
    Date;
-----

SELECT TOP 10
    Campaign,
    Date,
    SUM(Impressions) AS DailyImpressions,
    SUM(Clicks) AS DailyClicks,
    SUM(Spend_GBP) AS DailySpend,
    SUM(Conversions) AS DailyConversions
FROM 
    MarketData
GROUP BY 
    Campaign,
    Date
ORDER BY 
    Campaign,
    Date;


SELECT Like_Reaction