# E-Commerce Data Analysis | SQL & Power BI

An end-to-end e-commerce analytics project focused on transforming raw transaction data into actionable business insights using **SQL, Power Query, and Power BI**.

This collaborative project was completed as part of the **TechTrek Data Analyst Final Project**. It covers data preparation, exploratory and advanced SQL analysis, customer segmentation, revenue trends, product performance, and interactive dashboard development.

## Project Overview

The goal of this project was to understand how an e-commerce business generates revenue, how customers contribute to sales, which products perform best, and how transaction patterns change over time.

The analysis addressed questions such as:

- How is revenue distributed across customers?
- Is revenue concentrated among a small number of customers or products?
- How does revenue change over time, and are there seasonal patterns?
- Which products generate the most revenue versus the highest sales volume?
- How do sales vary across regions, divisions, and payment methods?
- What actions could improve customer retention and revenue stability?

## Tools & Technologies

- **Microsoft SQL Server / SQL:** Data analysis, joins, aggregations, CTEs, and window functions.
- **Power Query:** Data cleaning, transformation, standardization, and validation.
- **Microsoft Power BI:** Interactive dashboards, KPI reporting, and data visualization.

## Dataset

The project uses the [E-Commerce Data Analysis dataset on Kaggle](https://www.kaggle.com/datasets/mmohaiminulislam/ecommerce-data-analysis).

The dataset follows a relational structure consisting of one fact table and five dimension tables.

| Table | Description |
|---|---|
| `fact_table` | Transaction-level data, including quantity, unit price, total price, and dimension keys |
| `customer_dim` | Customer information |
| `item_dim` | Product information, prices, suppliers, and manufacturing countries |
| `store_dim` | Geographic and store-related information |
| `time_dim` | Date and time attributes, including year, month, quarter, and hour |
| `trans_dim` | Transaction and payment-method information |

The fact table contains approximately **1 million rows**, providing a substantial dataset for transaction and revenue analysis.

The original dataset is available through the Kaggle link above.

## Data Cleaning & Preparation

All six tables were cleaned and transformed in Power Query before the SQL analysis.

Key preparation steps included:

- Handling missing values while preserving useful records.
- Checking tables for duplicate keys and duplicate records.
- Converting columns to appropriate data types.
- Standardizing inconsistent unit labels and country-name capitalization.
- Parsing raw date-time values into a validated Date/Time field.
- Validating `total_price` against `quantity × unit_price`.

These steps helped improve consistency and reliability across the tables before analysis.

## SQL Analysis

The SQL analysis includes both descriptive and advanced analytical queries.

### 1. Business & Transaction Analysis

- Total revenue and quantity sold.
- Average unit price and transaction counts.
- Unique customer counts.
- Revenue by division, district, and payment method.
- Revenue by year and quarter.
- Peak transaction hours.
- Top-selling and highest-revenue products.

### 2. Customer Analysis

- Total customer spending and revenue contribution.
- Customer-level transaction counts.
- Customer revenue concentration.
- Customer segmentation using `NTILE(3)` into Low Value, Medium Value, and High Value groups.

### 3. Revenue Trend Analysis

- Annual revenue comparisons.
- Year-over-year revenue changes using `LAG()`.
- Monthly revenue comparisons and growth calculations.
- Identification of seasonal patterns and recurring weak periods.

### 4. Product Performance

- Product-level sales volume and revenue.
- Revenue per sold unit.
- Individual product contribution to total revenue.
- Analysis of whether sales volume translates into revenue contribution.

The complete SQL queries are available in [`sql_analysis.sql`](./sql_analysis.sql).

## Power BI Dashboard

The final Power BI report organizes the analysis into three connected pages:

### 1. Sales Overview
Presents core KPIs, year-to-date trends, division sales, and transaction-type mix.

### 2. Market & Regional Performance
Explores manufacturing-country performance, geographic patterns, and division-level results.

### 3. Customer & Transaction Insights
Highlights customer KPIs, top customers, customer sales trends, and transaction mix.

The dashboard uses a consistent visual design to make the findings easier to explore and interpret.

**Power BI report:** [`TechTrek-Final-Project-ECommerce-Dashboard1.pbix`](./TechTrek-Final-Project-ECommerce-Dashboard1.pbix)

## Key Findings

The analysis produced several notable findings:

- **Stable revenue:** Annual revenue remained around 15 million per year from 2014 through 2020.
- **Seasonality:** February was consistently a weaker month, while March, May, and December performed relatively well.
- **Customer diversification:** The highest-spending customer segment contributed the largest revenue share, but no individual customer accounted for more than approximately 1.62% of total revenue.
- **Product diversification:** No single product accounted for more than approximately 1.24% of total revenue.
- **Volume versus value:** Higher sales volume did not always translate into higher revenue, highlighting the importance of price and product mix.

The analysis excluded 2021 from the revenue trend comparison because the available data indicated substantially lower order volume and appeared incomplete.

## Business Recommendations

Based on the findings, the project recommends:

- Developing loyalty programs and personalized promotions for high-value customers.
- Monitoring customer retention and long-term customer value.
- Prioritizing inventory and marketing for strong revenue-contributing products.
- Planning seasonal campaigns to address recurring February weakness.
- Maintaining a diversified customer and product strategy.
- Tracking revenue and transaction metrics regularly to identify emerging changes.

## Project Files

| File | Description |
|---|---|
| [`sql_analysis.sql`](./sql_analysis.sql) | SQL queries for descriptive and advanced analysis |
| [`TechTrek-Final-Project-ECommerce-Dashboard1.pbix`](./TechTrek-Final-Project-ECommerce-Dashboard1.pbix) | Power BI dashboard |
| [`Ecommerce_Project_Documentation.pdf`](./Ecommerce_Project_Documentation.pdf) | Project documentation |
| [`Ecommerce_Final_Presentation_Fin.pdf`](./Ecommerce_Final_Presentation_Fin.pdf) | Final project presentation |
| `cleaned_data/` | Cleaned data files currently included in the repository |

## How to Explore the Project

1. Download the original dataset from [Kaggle](https://www.kaggle.com/datasets/mmohaiminulislam/ecommerce-data-analysis).
2. Prepare the six tables using the documented cleaning workflow in Power Query.
3. Load the cleaned tables into your SQL database. The queries in `sql_analysis.sql` expect cleaned table names such as `fact_table_cleaned` and `customer_dim_cleaned`; adapt the names or connections to your database as needed.
4. Open `sql_analysis.sql` to explore the analysis queries.
5. Open the Power BI `.pbix` file in Power BI Desktop. You may need to reconnect the data sources on your machine.

## Limitations

- The 2021 data was excluded from the main annual trend analysis because it appeared incomplete.
- Profit, cost, and margin data were unavailable, so profitability could not be evaluated.
- Customer demographic information was limited.
- The dataset did not contain an explicit product-category field, limiting category-level analysis.
- External factors such as promotions, holidays, and competitor activity were not available.

## Data Privacy

Do not publish real personal identifiers or sensitive customer information. Any customer-level data included in a public repository should be anonymized or removed when it is not necessary for understanding the analysis.

## Project Resources

- **GitHub Repository:** [ecommerce-data-analysis](https://github.com/M-Gaber056/ecommerce-data-analysis)
- **Original Dataset:** [E-Commerce Data Analysis — Kaggle](https://www.kaggle.com/datasets/mmohaiminulislam/ecommerce-data-analysis)

---

*TechTrek Data Analyst Final Project — E-Commerce Analytics*
