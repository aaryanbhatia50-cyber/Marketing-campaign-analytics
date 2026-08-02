-- Overall Campaign Conversion Rate
-- What percentage of customers responded to each of the 6 campaigns?

SELECT
    'Campaign 1' AS campaign,
    ROUND(100.0 * SUM("AcceptedCmp1") / COUNT(*), 2) AS conversion_rate_pct
FROM marketing_data

UNION ALL

SELECT
    'Campaign 2',
    ROUND(100.0 * SUM("AcceptedCmp2") / COUNT(*), 2)
FROM marketing_data

UNION ALL

SELECT
    'Campaign 3',
    ROUND(100.0 * SUM("AcceptedCmp3") / COUNT(*), 2)
FROM marketing_data

UNION ALL

SELECT
    'Campaign 4',
    ROUND(100.0 * SUM("AcceptedCmp4") / COUNT(*), 2)
FROM marketing_data

UNION ALL

SELECT
    'Campaign 5',
    ROUND(100.0 * SUM("AcceptedCmp5") / COUNT(*), 2)
FROM marketing_data

UNION ALL

SELECT
    'Latest Campaign',
    ROUND(100.0 * SUM("Response") / COUNT(*), 2)
FROM marketing_data
ORDER BY conversion_rate_pct DESC;

SELECT *
FROM marketing_data
LIMIT 1;

--  Average Spend by Customer Segment
-- Which income and education segments spend the most across all product categories?

SELECT
	"Education",
	CASE WHEN "Income" < 30000 THEN 'Low Income'
	WHEN "Income" Between 30000 AND 70000 THEN 'Mid Income'
	ELSE 'High Income'
	END AS Income_Bracket,
	ROUND(AVG("Total Spend"),2) AS avg_total_spend,
	COUNT (*) AS customers
FROM marketing_data
GROUP BY "Education",income_bracket
ORDER BY avg_total_spend;

-- Channel Preference by Age Group
-- Do younger customers prefer web purchases while older customers prefer stores?

SELECT
    CASE
        WHEN "Age" < 35 THEN 'Young(<35)'
        WHEN "Age" BETWEEN 35 AND 55 THEN 'Mid-Age(35-55)'
        ELSE 'High Age(>55)'
    END AS Age_dist,
    ROUND(AVG("NumWebPurchases"), 2) AS avg_web_purchases,
    ROUND(AVG("NumStorePurchases"), 2) AS avg_store_purchases,
    ROUND(AVG("NumCatalogPurchases"), 2) AS avg_catalog_purchases
FROM marketing_data
GROUP BY Age_dist
ORDER BY avg_web_purchases DESC;

-- Campaign Response by Income Bracket
-- Are high-income customers more likely to respond to campaigns?

SELECT
	CASE
		WHEN "Income" < 30000 THEN 'Low Income'
		WHEN "Income" Between 30000 AND 70000 THEN 'Mid Income'
		ELSE 'High Income'
	END AS Income_Bracket,
	ROUND(AVG("Total_Campaigns_Accepted"),2) AS avg_campaigns_accepted,
	COUNT(*) AS total_customers
FROM marketing_data
WHERE "Income" IS NOT NULL
GROUP BY Income_bracket
ORDER BY avg_campaigns_accepted DESC;

-- Recency vs Spend Relationship
-- Do customers who purchased more recently also spend more?

SELECT
	CASE
		WHEN "Recency" <= 30 THEN 'Active(0-30)days'
		WHEN "Recency" BETWEEN 31 AND 60 THEN 'Warm(31-60)days'
		WHEN "Recency" BETWEEN 61 AND 90 THEN 'Cooling(61-90)days'
		ELSE 'At Risk(90+) days'
		END AS recency_segment,
		ROUND(AVG("Total Spend"),2) AS avg_spend,
		COUNT(*) AS customers
FROM marketing_data
GROUP BY recency_segment
ORDER BY avg_spend;

-- Product Category Revenue Contribution
-- Which product categories drive the most revenue across all customers?

SELECT
    'MntWines' AS category,
    SUM("MntWines") AS total_revenue
FROM marketing_data

UNION ALL

SELECT
    'MntMeatProducts',
    SUM("MntMeatProducts")
FROM marketing_data

UNION ALL

SELECT
    'MntGoldProds',
    SUM("MntGoldProds")
FROM marketing_data

UNION ALL

SELECT
    'MntFruits',
    SUM("MntFruits")
FROM marketing_data

UNION ALL

SELECT
    'MntSweetProducts',
    SUM("MntSweetProducts")
FROM marketing_data

UNION ALL

SELECT
    'MntFishProducts',
    SUM("MntFishProducts")
FROM marketing_data

ORDER BY total_revenue DESC;

-- Multi-Campaign Responders
-- Which customer profiles responded to 3 or more campaigns the high-value loyalists?

SELECT
	"Education",
	"Marital_Status",
	CASE
		WHEN "Income" < 30000 THEN 'Low Income'
		WHEN "Income" BETWEEN 30000 AND 70000 THEN 'Mid Income'
		ELSE 'High Income' 
		END AS Income_Bracket,
	ROUND(AVG("Total Spend") ,2) AS avg_total_spend,
	COUNT (*) AS loyal_customers
FROM marketing_data
GROUP BY "Education","Marital_Status",Income_Bracket
ORDER BY loyal_customers DESC
LIMIT 10;

-- Cost of Inaction: Revenue from Non-Responders
-- How much total spend came from customers who never accepted any campaign?

SELECT
	CASE
		WHEN "Total_Campaigns_Accepted" = 0 THEN 'Never Responded'
		ELSE 'Responded to at leasr 1'
		END AS responder_status,
	COUNT(*) AS customers,
	ROUND(SUM("Total Spend"), 2) AS total_revenue,
	ROUND(AVG("Total Spend"), 2) AS avg_spend_per_customer
FROM marketing_data
GROUP BY responder_status
ORDER BY total_revenue DESC;
