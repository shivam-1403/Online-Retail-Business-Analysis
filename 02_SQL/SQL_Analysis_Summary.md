# SQL Analysis Summary

## Online Retail Business Analysis

This document summarizes the **business questions, SQL analyses, and key findings** completed using SQL on the Silver-layer e-commerce data.

The purpose of this file is to let a reviewer understand **what was analyzed and what was discovered** without having to execute every SQL query. The detailed SQL scripts remain available in the `SQL/2_Analysis/` folder.

---

# 1. Business Growth Analysis

### SQL file
`SQL/2_Analysis/1_Business_Growth_Analysis.sql`

## Questions answered

- What is the overall business performance?
- How much revenue and gross profit does the business generate?
- What is the average order value?
- How does revenue change month over month?
- Is the business growing year over year?
- How many customers and orders are generated each month?
- How many orders does each customer place?

## Key metrics

| Metric | Result |
|---|---:|
| Gross Revenue | $1,938,509.75 |
| Total Orders | 32,313 |
| Average Order Value | $59.99 |
| Total COGS | $722,370.25 |
| Gross Profit | $1,216,139.50 |
| Gross Margin | 62.74% |

## Key findings

- Revenue increased substantially from **$129,274.14 in 2012** to **$393,247.87 in 2013** and **$1,075,612.19 in 2014**.
- Year-over-year revenue growth was approximately **204.20% in 2013** and **173.52% in 2014**.
- 2015 revenue is **$340,375.55**, but the available data only covers January–March, so it should not be compared directly with full-year results.
- Monthly revenue generally trends upward, with particularly strong November–December periods.
- The highest monthly revenue in the available data is **December 2014: $144,823.02**.
- AOV increased from approximately **$49.99 in 2012** to around **$64–65 during much of 2014**, showing an increase in order value over time.
- Monthly orders and customers increased substantially as the business scaled.
- `orders_per_customer` remains close to 1 in the monthly data, indicating that most monthly purchasing activity comes from customers placing one order in that month.

---

# 2. Customer Analysis

### SQL file
`SQL/2_Analysis/2_Customer_Analysis.sql`

## Questions answered

- How many customers are purchasing?
- How frequently do customers order?
- How much revenue is generated per customer?
- How many customers return?
- How many customers place second or third orders?
- How long is the gap between customer orders?

## Key findings

- Total distinct customers: **31,696**
- Returning customers: **591**
- Returning customer rate: **1.86%**
- Customers reaching a second order: **591**
- Customers reaching a third order: **26**

### Interpretation

The SQL analysis shows a strong **customer acquisition / first-purchase business model**, but relatively weak repeat purchasing.

Only **1.86% of customers are classified as returning customers** in the analyzed order data. The drop from **591 second-order customers to only 26 third-order customers** indicates substantial customer attrition after the first purchase.

The analysis also calculated:
- First order date for each customer
- Sequential order number for each customer
- Time between consecutive orders

These outputs can be used later for retention/cohort analysis if deeper customer analysis is required.

---

# 3. Profitability & Refund Analysis

### SQL file
`SQL/2_Analysis/3_Profitability_and_Refund_Analysis.sql`

## Questions answered

- How does revenue, COGS, and gross profit change over time?
- How many items are sold?
- How many items are refunded?
- How much money is refunded?
- Which products generate the most refund value?
- Which products have the highest refund ratios?
- How does refund behavior change by month and year?

## Key findings

The monthly analysis tracks:

- Revenue
- COGS
- Gross profit
- Total items
- Refund items
- Refund amount

Refund exposure increases as sales volume increases, but some periods show unusually high refund activity.

### Product-level refund exposure

| Product | Refunds | Sales | Refund Ratio | Refund Amount | Refund Share |
|---|---:|---:|---:|---:|---:|
| The Original Mr. Fuzzy | 1,237 | 24,226 | 5.11% | $61,837.63 | 72.46% |
| The Birthday Sugar Panda | 301 | 4,985 | 6.04% | $13,842.99 | 16.22% |
| The Forever Love Bear | 129 | 5,796 | 2.23% | $7,738.71 | 9.07% |
| The Hudson River Mini bear | 64 | 5,018 | 1.28% | $1,919.36 | 2.25% |

### Key findings

- **The Original Mr. Fuzzy** generates the largest absolute refund amount: **$61,837.63**.
- It accounts for approximately **72.46% of total refund value**.
- **The Birthday Sugar Panda** has the highest overall refund ratio among the products shown: **6.04%**.
- The Original Mr. Fuzzy has a **5.11%** overall refund ratio.
- The Hudson River Mini bear has the lowest refund ratio at **1.28%**.
- A major anomaly appears in **September 2014**, when The Original Mr. Fuzzy had **213 refunds out of 1,056 sales**, producing a **20.17% monthly refund ratio**. This period deserves investigation.

The yearly product analysis also shows that the highest refund-ratio product changes over time:
- 2012: Original Mr. Fuzzy — 6.54%
- 2013: Original Mr. Fuzzy — 4.96%
- 2014: Birthday Sugar Panda — 5.69%
- 2015: Birthday Sugar Panda — 7.42%

---

# 4. Product Performance Analysis

### SQL file
`SQL/2_Analysis/4_Product_Performance_Analysis.sql`

## Questions answered

- Which products sell the most?
- Is product demand increasing?
- How do products rank by sales and order volume?
- Has selling price changed over time?
- Has COGS changed over time?
- Which products generate the most profit?

## Overall product performance

| Rank | Product | Sales | Orders |
|---:|---|---:|---:|
| 1 | The Original Mr. Fuzzy | $1,211,057.74 | 24,226 |
| 2 | The Forever Love Bear | $347,702.04 | 5,796 |
| 3 | The Hudson River Mini bear | $150,489.82 | 5,018 |
| 4 | The Birthday Sugar Panda | $229,260.15 | 4,985 |

## Key findings

- **The Original Mr. Fuzzy is the dominant product**, generating more than $1.21M in sales and 24,226 order items.
- Its sales volume is substantially higher than every other product.
- The Forever Love Bear is the second-largest product by sales value.
- Product rankings change somewhat by year, but Original Mr. Fuzzy remains the leading product throughout the available period.

## Pricing analysis

The analysis found that observed selling prices and COGS remained constant for each product over the available years:

| Product | Selling Price | COGS |
|---|---:|---:|
| The Original Mr. Fuzzy | $49.99 | $19.49 |
| The Forever Love Bear | $59.99 | $22.49 |
| The Birthday Sugar Panda | $45.99 | $14.49 |
| The Hudson River Mini bear | $29.99 | $9.49 |

No selling-price or COGS changes were observed in the analyzed data.

## Product profitability

The yearly profitability analysis calculates:

`Total Price - Total COGS = Product Profit`

The Original Mr. Fuzzy generates the largest absolute product profit because of its very high sales volume.

---

# 5. Marketing Analysis

### SQL file
`SQL/2_Analysis/5_Marketing_Analysis.sql`

## Questions answered

- Where are customers coming from?
- Which acquisition sources generate the most orders?
- Which campaigns generate revenue and profit?
- Which campaigns have the highest conversion rate?
- Which marketing content performs best?
- Which devices are customers using?
- Is marketing performance changing over time?

## UTM source performance

| Source | Users | Orders | Revenue | Gross Profit | Conversion |
|---|---:|---:|---:|---:|---:|
| gsearch | 299,700 | 21,333 | $1,276,144.89 | $800,158.50 | 6.75% |
| *(blank)* | 66,144 | 6,118 | $371,433.03 | $233,444.50 | 7.34% |
| bsearch | 61,965 | 4,519 | $268,672.50 | $168,434.00 | 7.19% |
| socialbook | 10,685 | 343 | $22,259.33 | $14,102.50 | 3.21% |

### Key findings

- **gsearch is the largest acquisition source**, producing 21,333 orders and $1.28M revenue.
- gsearch also generates the highest gross profit: **$800,158.50**.
- The blank/untagged source has the highest conversion rate at **7.34%**, but its attribution should be treated separately because the source value is missing.
- bsearch converts at **7.19%**, slightly above gsearch's 6.75%.
- socialbook has the weakest conversion rate at **3.21%**.

## Campaign performance

| Campaign | Orders | Revenue | Gross Profit | Conversion |
|---|---:|---:|---:|---:|
| nonbrand | 22,640 | $1,349,977.69 | $845,993.50 | 6.71% |
| *(blank)* | 6,118 | $371,433.03 | $233,444.50 | 7.34% |
| brand | 3,212 | $194,839.70 | $122,599.00 | 7.79% |
| desktop_targeted | 288 | $18,516.10 | $11,720.00 | 5.15% |
| pilot | 55 | $3,743.23 | $2,382.50 | 1.08% |

### Key findings

- **nonbrand** drives the largest number of orders, revenue, and gross profit.
- **brand** has the highest conversion rate among named campaigns at **7.79%**.
- The pilot campaign performs poorly with only **1.08% conversion**.

## Marketing content

- `g_ad_1` has the largest volume: **18,822 orders** and **$1.12M revenue**.
- `b_ad_2` has the highest conversion rate at **8.86%**, despite much lower traffic volume.
- `g_ad_2` converts at **7.53%**.
- `social_ad_1` has the weakest conversion rate at **1.08%**.

## Device performance

| Device | Users | Orders | Revenue | Gross Profit | Conversion |
|---|---:|---:|---:|---:|---:|
| Desktop | 288,580 | 27,805 | $1,665,757.84 | $1,045,029.00 | 8.50% |
| Mobile | 133,839 | 4,508 | $272,751.91 | $171,110.50 | 3.09% |

### Key finding

Desktop conversion is **8.50%**, compared with only **3.09% on mobile**. This is one of the clearest opportunities identified in the marketing analysis.

## Performance over time

The yearly source analysis shows that conversion rates generally improved from 2012 to 2015 for the major sources.

For example:
- gsearch: **3.91% in 2012 → 8.55% in 2015**
- bsearch: **4.80% in 2012 → 8.75% in 2015**
- untagged source: **5.06% in 2012 → 7.99% in 2015**

The available data for 2015 covers only January–March.

---

# 6. Website Behavior Analysis

### SQL file
`SQL/2_Analysis/6_Website_Behavior_Analysis.sql`

## Questions answered

- How does website traffic change over time?
- How many pageviews are generated?
- How many pages are viewed per session?
- Which pages are viewed most?
- Which pages are associated with purchasing sessions?
- How does the website funnel progress from sessions to purchase?
- Which landing pages perform best?

## Traffic trends

The website received:

**472,871 sessions**

and the analysis tracked monthly:
- Website sessions
- Website pageviews
- Average pageviews per session

### Key finding

Average pageviews per session increased from approximately **1.98 in March 2012** to **2.72 in March 2015**.

This indicates that sessions became more engaged with the website over the available period.

## Most-viewed pages

| Rank | Page | Views |
|---:|---|---:|
| 1 | `/products` | 261,231 |
| 2 | `/the-original-mr-fuzzy` | 162,525 |
| 3 | `/home` | 137,576 |
| 4 | `/lander-2` | 131,170 |
| 5 | `/cart` | 94,953 |

The product listing page is the most viewed page in the dataset.

---

# Website Purchase Funnel

The SQL funnel analysis measured distinct sessions reaching major stages.

| Funnel Stage | Sessions |
|---|---:|
| All sessions | 472,871 |
| Product view | 210,214 |
| Cart | 94,953 |
| Shipping | 64,484 |
| Billing | 52,058 |
| Purchase | 32,313 |

Approximate stage conversion from total sessions:

- Product view: **44.45%**
- Cart: **20.08%**
- Shipping: **13.64%**
- Billing: **11.01%**
- Purchase: **6.83%**

### Key findings

- A substantial portion of sessions do not reach a product page.
- The largest funnel reduction occurs between **product view and cart**.
- 32,313 sessions ultimately resulted in orders.
- The funnel provides a clear framework for identifying where website optimization could have the greatest impact.

---

# Landing Page Performance

| Landing Page | Sessions | Orders | Conversion | Revenue | Gross Profit |
|---|---:|---:|---:|---:|---:|
| `/lander-5` | 68,166 | 6,930 | **10.17%** | $438,542.75 | $277,831.50 |
| `/lander-2` | 131,170 | 10,128 | 7.72% | $594,763.41 | $371,292.50 |
| `/lander-4` | 9,385 | 708 | 7.54% | $45,460.60 | $28,731.00 |
| `/lander-1` | 47,574 | 2,157 | 4.53% | $108,748.43 | $66,432.50 |
| `/lander-3` | 79,000 | 2,679 | 3.39% | $165,675.64 | $104,188.00 |

### Key findings

- **`/lander-5` is the strongest landing page by conversion rate at 10.17%**.
- `/lander-2` produces the largest number of orders and highest revenue because of its much larger session volume.
- `/lander-3` has the weakest conversion rate at **3.39%**.
- The difference between `/lander-5` and `/lander-3` suggests substantial variation in landing-page effectiveness.

---

# Overall SQL Findings

The six analysis phases collectively identify several major business themes.

## 1. Strong business growth

Revenue expanded rapidly through 2014, with gross revenue reaching **$1.94M** across the available data and gross margin of **62.74%**.

## 2. Strong dependence on one product

The Original Mr. Fuzzy generates approximately **$1.21M in sales**, making it by far the dominant product.

## 3. Weak repeat purchasing

Only **1.86% of customers** are classified as returning customers, and only **26 customers** reached a third order.

This is one of the strongest customer-side findings.

## 4. Refund concentration

The Original Mr. Fuzzy accounts for **72.46% of total refund value**.

The September 2014 spike in its refund ratio (**20.17%**) is particularly notable and should be investigated.

## 5. Search dominates acquisition

gsearch produces the largest volume of traffic, orders, revenue, and profit.

However, smaller sources can show stronger conversion rates, demonstrating that **traffic volume and traffic efficiency are not the same thing**.

## 6. Mobile is a major opportunity

Mobile conversion is **3.09%**, compared with **8.50% for desktop**.

This represents a large performance gap worth investigating.

## 7. Landing pages vary substantially

`/lander-5` converts at **10.17%**, while `/lander-3` converts at only **3.39%**.

Landing-page design, audience targeting, or campaign alignment may explain part of this difference.

## 8. Website engagement is improving

Average pageviews per session increased from approximately **1.98 to 2.72** over the available period.

---

# SQL Analysis Map

| Phase | Main Business Area | Primary Questions |
|---|---|---|
| 1 | Business Growth | Revenue, orders, AOV, profit, growth |
| 2 | Customer Analysis | Customers, repeat orders, retention behavior |
| 3 | Profitability & Refunds | Profit, COGS, refunds, refund exposure |
| 4 | Product Performance | Product sales, demand, pricing, profitability |
| 5 | Marketing | Sources, campaigns, conversion, device performance |
| 6 | Website Behavior | Traffic, pages, funnel, landing pages |

---

# Technical SQL Techniques Used

The analysis used a range of SQL techniques including:

- `SELECT`, `WHERE`, `GROUP BY`, `ORDER BY`
- Aggregate functions: `SUM()`, `COUNT()`, `COUNT(DISTINCT)`
- `JOIN` / `LEFT JOIN`
- Common Table Expressions (`WITH`)
- Window functions
- `RANK()`
- `ROW_NUMBER()`
- `LAG()`
- Windowed `SUM()`
- `MIN() OVER()`
- Date functions such as `YEAR()`, `MONTH()`, `MONTHNAME()`
- `TIMESTAMPDIFF()`
- Funnel analysis using conditional session-level logic
- Multi-table business metric calculations

---

# Important Data Notes

- The available dataset begins in **March 2012**.
- The available 2015 data ends in **March 2015**. Therefore, 2015 should not be treated as a complete year.
- Some marketing dimensions contain blank/untagged values. These were retained in the analysis rather than silently removed.
- Product price and COGS values were observed to remain constant across the available years.
- The analysis focuses on the Silver-layer data and the business questions defined for this project.

---

## Related SQL

Detailed query implementations are available in:

`SQL/2_Analysis/`

Each analysis file corresponds directly to one section of this summary.
