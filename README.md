# Marketing Campaign Performance & Customer Segmentation Analysis

End-to-end analysis of a 2,240-customer marketing dataset — campaign acceptance rates, customer segmentation, channel behavior, and revenue attribution — built with PostgreSQL, Power BI, and Python.

## Business Problem

Most "campaign analysis" projects stop at "who responded." This project answers the questions a CMO actually asks: which segments respond to which channels, where does revenue really come from, and is the campaign program even the primary revenue driver?

## Dataset

[Customer Personality Analysis](https://www.kaggle.com/datasets/imakash3011/customer-personality-analysis) — 2,240 customer records covering demographics, purchase history across 6 product categories, responses to 6 marketing campaigns, and purchase channel (web/store/catalogue).

## Tools

- **Python (pandas)** — data cleaning, feature engineering (`Age`, `TotalSpend`, `TotalCampaignsAccepted`, `TotalPurchases`)
- **PostgreSQL** — business-question SQL queries
- **Power BI** — 3-page interactive dashboard (DAX measures, calculated columns, conditional-formatted matrix)

## Files

| File | Description |
|---|---|
| `business_queries.sql` | 8 SQL business questions with comments |
| `data_cleaning.ipynb` | Python cleaning + feature engineering |
| `marketing_dashboard.pbix` | Power BI dashboard, 3 pages |
| `marketing_campaign_cleaned.csv` | Cleaned dataset loaded into Postgres |

## Dashboard

### Page 1 — Campaign Performance Overview

- Acceptance rate per campaign (6 campaigns, ranked)
- KPI cards: total customers, overall acceptance rate, avg campaigns accepted per customer

### Page 2 — Customer Segmentation

- Avg spend by income bracket × education
- Purchase channel split (web / store / catalogue)
- Age group × channel-preference matrix (heatmap via conditional formatting)
- Avg campaigns accepted by income bracket

### Page 3 — Revenue & Customer Value

- Revenue by product category (treemap)
- Product spend by age group
- Revenue attribution: responders vs. non-responders

## Key Findings

**1. Campaigns are not the primary revenue driver.**
55% of total revenue (₹747K) comes from customers who never accepted a single campaign across all six attempts. The majority of business revenue happens independent of campaign activity.

**2. Non-response is uniform across age groups — age isn't the driver.**
The 55% non-responder revenue is evenly distributed across Young, Mid-Age, and Senior customers, not concentrated in any one segment. This rules out age-based targeting as the fix; the gap more likely comes from offer relevance, channel mismatch, or timing.

**3. Revenue is concentrated in two product categories.**
Wine (680K) and Meat (373K) account for roughly three-quarters of total product revenue. Gold, Sweets, Fruit, and Fish are minor contributors — inventory and promotional focus should track this concentration.

**4. Senior customers (55+) are the highest-value segment by spend.**
Seniors outspend Mid-Age and Young customers substantially across every product category, despite showing the same non-response rate as other age groups — meaning high spend and campaign engagement don't move together.

## Business Implication

The data doesn't support "run more campaigns" as a fix. Since non-response is evenly spread across age and the highest spenders aren't responding at a different rate than anyone else, the likelier lever is campaign relevance and channel fit, not audience reach or age-based targeting.

## Author

Aaryan Bhatia — [GitHub](https://github.com/aaryanbhatia50-cyber) · [Email](mailto:aaryanbhatia50@gmail.com)
