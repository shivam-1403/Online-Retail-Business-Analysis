# Python Exploratory Data Analysis Summary

## Overview

This stage of the project performs end-to-end exploratory data analysis on a cleaned e-commerce dataset using Python. The objective is to move beyond descriptive reporting by answering business-driven questions about customer behavior, marketing performance, landing pages, product performance, and refunds.

The analysis follows a structured workflow where each section begins with a business question, uses the appropriate dataset grain, and concludes with business-focused insights supported by visualizations.

## Tools & Libraries

- Python
- Pandas
- Matplotlib
- Statsmodels (Two-Proportion Z-Test & Confidence Interval)

## Analysis Performed

### 1. Monthly Business Performance

- Tracked monthly revenue, orders, profit, and Average Order Value (AOV).
- Identified consistent business growth over time through time-series analysis.

### 2. Order Size Analysis

- Compared one-item and two-item orders.
- Measured how average revenue changes with order size.

### 3. Two-Item Purchase Analysis

- Identified the product combinations most frequently purchased together.
- Found that **The Original Mr. Fuzzy** is the strongest driver of multi-item purchasing.

### 4. Returning Customer Analysis

- Measured repeat-customer participation over time.
- Observed gradual improvement in returning-customer share as the business matured.

### 5. Landing Page Performance

- Compared landing-page conversion rates.
- Calculated:
  - Conversion Rate
  - Absolute Difference
  - Relative Lift

#### Statistical Validation

Performed a **Two-Proportion Z-Test** between `/home` and `/lander-5` to determine whether the observed conversion-rate difference could reasonably be explained by random variation.

Also calculated a **95% Confidence Interval** for the observed conversion difference.

### 6. Device Mix Validation

Investigated whether landing pages received similar types of visitors.

This revealed that some landing pages had substantially different desktop/mobile traffic distributions, making the landing-page comparison an observational analysis rather than a purely causal conclusion.

### 7. Traffic Source Performance

Compared marketing channels using:

- Sessions
- Orders
- Conversion Rate
- Revenue
- Profit
- Revenue per Session
- Profit per Session

### 8. Campaign Performance

Evaluated marketing campaigns by both traffic volume and efficiency.

Compared:

- Brand
- Nonbrand
- Desktop Targeted
- Pilot

### 9. Refund Performance

Analyzed post-purchase performance by combining refund records with product sales.

Calculated:

- Refund Count
- Refund Amount
- Units Sold
- Refund Rate

This distinguished products with the largest financial refund impact from those with the highest relative refund risk.

## Key Business Findings

- Revenue grew consistently throughout the analysis period.
- Two-item purchasing increased over time, contributing to higher order values.
- **The Original Mr. Fuzzy** dominated multi-item purchasing behavior.
- Returning-customer participation improved as the business matured.
- `/lander-5` achieved the highest observed conversion rate, although device mix should be considered before interpreting the result as a landing-page effect.
- **Bsearch** delivered the strongest conversion efficiency among traffic sources.
- **Brand** campaigns achieved the highest conversion efficiency, while **Nonbrand** generated the largest overall revenue.
- **The Birthday Sugar Panda** recorded the highest refund rate, while **The Original Mr. Fuzzy** generated the largest refund losses.

## Statistical Techniques Used

- Two-Proportion Z-Test
- Confidence Interval Estimation
- Relative Lift Analysis

## Visualizations Included

The notebook includes business-focused visualizations rather than decorative charts.

- Monthly Revenue Trend
- Product Pair Analysis
- Returning Customer Trend
- Landing Page Conversion Comparison
- Device Mix Comparison
- Traffic Source Performance
- Campaign Performance
- Refund Rate by Product

## Skills Demonstrated

- Exploratory Data Analysis (EDA)
- Data Cleaning and Transformation
- Multi-table Merging
- GroupBy Aggregation
- Statistical Testing
- Business KPI Analysis
- Marketing Performance Analysis
- Customer Behavior Analysis
- Product Performance Analysis
- Data Visualization
- Business Insight Communication

## Outcome

The Python phase transforms cleaned transactional data into actionable business insights through structured analysis, statistical validation, and professional visualizations, demonstrating a complete business-oriented analytics workflow suitable for portfolio presentation.