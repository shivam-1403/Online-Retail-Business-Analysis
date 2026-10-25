
# Power BI Business Analysis
## Online Retail Business Analysis

## 1. Executive Summary

This project analyzes e-commerce sales, product performance, marketing effectiveness, website conversion, customer behavior, and refunds using Power BI.

The objective was to transform raw business data into actionable insights through data modeling, DAX measures, interactive dashboards, and business-focused analysis.

The overall SQL analysis reported approximately **$1.94 million in revenue**, **$1.22 million in gross profit**, and a **62.74% gross margin**. Further analysis revealed differences in conversion performance across devices and landing pages, a low returning-customer rate, and a concentration of refund value in one major product.

These findings identify areas where a business could investigate customer experience, retention, marketing performance, and product quality.

### Business Performance at a Glance

| Metric | Result |
|---|---:|
| Gross Revenue | $1,938,509.75 |
| Gross Profit | $1,216,139.50 |
| Gross Margin | 62.74% |
| Total Orders | 32,313 |
| Average Order Value | $59.99 |
| Total Customers | 31,696 |
| Returning Customers | 591 |
| Returning Customer Rate | 1.86% |

*These headline figures come from the overall SQL analysis. Values in Power BI can vary with filter context, metric definitions, and data relationships.*

---

## 2. Business Questions

The analysis was designed to investigate the following questions:

- How much revenue and gross profit does the business generate?
- Which products contribute most to revenue and profitability?
- Are conversion rates different across desktop and mobile?
- Which traffic sources, campaigns, and landing pages perform differently?
- What does the available data reveal about repeat purchasing?
- Which products account for the greatest refund value and refund rates?
- How can interactive reporting help users investigate these patterns?

---

## 3. Key Findings and Business Implications

### Finding 1: Mobile Conversion Is Substantially Lower Than Desktop

| Device | Conversion Rate |
|---|---:|
| Desktop | 8.50% |
| Mobile | 3.09% |
| Difference | 5.41 percentage points |

Desktop conversion was approximately **2.75 times** the mobile conversion rate.

#### Why This Matters

The gap indicates that desktop and mobile visitors behaved differently in the observed data. Potential areas to investigate include mobile page usability, page speed, checkout friction, and differences in visitor intent.

#### Recommended Business Investigation

- Review the mobile checkout journey and identify where visitors leave.
- Compare page speed and usability across devices.
- Segment mobile conversion by traffic source and landing page.
- Test improvements and evaluate conversion changes using a controlled experiment where feasible.

**Business implication:** Improving mobile conversion could represent a meaningful opportunity, but the potential revenue impact should be calculated using validated traffic volumes, segment-level conversion, and an explicit scenario rather than assumed from the gap alone.

---

### Finding 2: Returning Customers Represented Only 1.86% of Customers

The overall customer analysis reported:

| Metric | Result |
|---|---:|
| Total Customers | 31,696 |
| Returning Customers | 591 |
| Returning Customer Rate | 1.86% |

#### Why This Matters

The result suggests that repeat purchasing was uncommon under the customer-level definition used in the overall analysis.

A business may need to balance customer acquisition with efforts to encourage customers to return. However, the low rate alone does not establish whether the cause is product type, customer lifecycle, purchase frequency, or the observation period.

#### Recommended Business Investigation

- Analyze time between first and subsequent purchases.
- Compare repeat-purchase behavior across acquisition channels.
- Identify products and customer segments associated with repeat orders.
- Evaluate retention campaigns using cohort analysis.
- Track repeat purchase rate and customer lifetime value over time.

**Business implication:** Better retention measurement could help the business understand whether customer acquisition spending is translating into sustained customer relationships.

*Note: Returning-customer figures depend on the calculation and selected time period. The overall customer-level result should not be confused with a measure of customers placing multiple orders within a selected month.*

---

### Finding 3: Refund Value Was Highly Concentrated in Original Mr. Fuzzy

Original Mr. Fuzzy generated approximately **$1.21 million in product revenue** and accounted for **72.46% of total refund value**.

| Product | Refund Amount | Share of Refund Value |
|---|---:|---:|
| Original Mr. Fuzzy | $61,837.63 | 72.46% |
| Birthday Sugar Panda | $13,842.99 | 16.22% |
| Forever Love Bear | $7,738.71 | 9.07% |
| Hudson River Mini bear | $1,919.36 | 2.25% |
| **Total** | **$85,338.69** | **100%** |

Birthday Sugar Panda had the highest reported refund rate among these products at approximately **6.04%**, while Original Mr. Fuzzy generated the largest refund amount.

#### Why This Matters

A product can account for the largest refund amount because it sells in high volume, has a high refund rate, or both. Refund amount alone does not establish that a product has the poorest quality.

#### Recommended Business Investigation

- Compare refund rates alongside sales volume for every product.
- Review refund reasons, where available.
- Investigate whether refunds cluster around particular periods or product versions.
- Examine the customer experience and product descriptions for potential mismatches.
- Prioritize further investigation using both refund rate and financial exposure.

**Business implication:** Combining refund value, sales volume, and refund rate provides a stronger basis for prioritizing product-quality investigations than refund counts alone.

---

### Finding 4: Landing Page Conversion Rates Varied Considerably

Observed landing-page conversion rates ranged from approximately **3.39% to 10.17%**.

| Landing Page | Sessions | Orders | Conversion Rate |
|---|---:|---:|---:|
| /lander-5 | 68,166 | 6,930 | 10.17% |
| /lander-2 | 131,170 | 10,128 | 7.72% |
| /lander-4 | 9,385 | 708 | 7.54% |
| /lander-1 | 47,574 | 2,157 | 4.53% |
| /lander-3 | 79,000 | 2,679 | 3.39% |

#### Why This Matters

The observed rates differ by landing page, suggesting that landing-page performance deserves closer examination. However, pages may attract different audiences and traffic sources, so these rates are not necessarily an apples-to-apples comparison.

#### Recommended Business Investigation

- Compare traffic sources and device mix for each landing page.
- Review engagement and funnel progression by landing page.
- Investigate the content and user journey of lower-converting pages.
- Validate differences with controlled tests before making causal claims.

**Business implication:** Landing-page analysis can help prioritize further investigation into acquisition and website experience, while accounting for differences in the visitors each page attracts.

---

### Finding 5: Revenue and Profitability Provide a Strong Baseline for Monitoring

The overall SQL summary reported approximately:

- **$1.94 million** in gross revenue
- **$1.22 million** in gross profit
- **62.74%** gross margin
- **$59.99** average order value

Revenue increased substantially through 2014. However, the available 2015 data covers only January through March.

#### Why This Matters

Revenue alone does not describe business performance completely. Monitoring gross profit, margin, order value, and order volume together helps distinguish changes in sales from changes in profitability.

#### Recommended Business Investigation

- Track revenue and gross profit together over time.
- Monitor margin changes by product.
- Compare average order value across customer and acquisition segments.
- Separate full-year comparisons from partial-year periods.
- Investigate whether changes in product mix correspond to changes in margin.

**Business implication:** A combined sales and profitability view gives decision-makers a more complete performance picture than revenue reporting alone.

---

### Finding 6: Traffic Sources and Devices Show Different Performance Patterns

The analysis identified differences across traffic sources, campaigns, and devices.

Examples from the overall analysis include:

| Segment | Observed Result |
|---|---:|
| Desktop conversion rate | 8.50% |
| Mobile conversion rate | 3.09% |
| Brand campaign conversion rate | 7.79% |
| Pilot campaign conversion rate | 1.08% |
| Socialbook conversion rate | 3.21% |

#### Why This Matters

Traffic volume and conversion efficiency are different dimensions. A channel can generate many orders without having the highest conversion rate, while a smaller campaign can have a different conversion profile.

#### Recommended Business Investigation

- Compare sessions, orders, revenue, and conversion rate together.
- Examine device and landing-page performance within each traffic source.
- Evaluate campaign efficiency using advertising cost and acquisition data, if available.
- Avoid increasing or cutting marketing spend based on conversion rate alone.

**Business implication:** Combining traffic volume, conversion, revenue, and cost data can support more informed marketing allocation decisions.

*Advertising spend and customer acquisition cost were not established by the metrics summarized here, so marketing profitability cannot be concluded from conversion rates alone.*

---

## 4. Power BI Report Design

The report contains five interactive dashboard pages.

### Dashboard 1: Executive Overview

Provides a high-level view of revenue, customers, average order value, gross profit, profit margin, and refund amount.

Key visuals:
- Revenue and Gross Profit Trend by Month-Year
- Revenue by Product
- Conversion Rate by Device
- Revenue by Traffic Source
- Refund Amount by Product

### Dashboard 2: Sales and Product Performance

Explores sales trends, order characteristics, and product profitability.

Key visuals:
- Monthly Revenue Growth
- Average Order Value Trend
- Orders by Items Purchased
- Gross Profit by Product
- Profit Margin by Product

### Dashboard 3: Marketing and Conversion

Examines website sessions, conversion rates, campaigns, landing pages, traffic sources, and funnel stages.

Key visuals:
- Conversion Rate by Landing Page
- Website Conversion Funnel
- Sessions by Traffic Source
- Conversion Rate by Traffic Source
- Conversion Rate by Campaign

### Dashboard 4: Customer Behavior and Retention

Explores customer counts, returning customers, revenue per customer, and repeat-purchasing patterns.

Key visuals:
- Monthly Repeat-Purchasing Customers
- Revenue per Customer by Traffic Source

### Dashboard 5: Refunds and Product Quality

Focuses on refund volume, refund value, refund rates, and product-level differences.

Key visuals:
- Monthly Refund Rate
- Monthly Refund Amount
- Refund Count by Product
- Refund Rate by Product

The dashboards include slicers for relevant dimensions such as date, product, traffic source, device, campaign, landing page, and items purchased.

---

## 5. Data Model and Technical Implementation

### Data Model

The report connects six cleaned datasets:

- Orders
- Order items
- Products
- Refunds
- Website sessions
- Website pageviews

Relationships connect sessions to orders and pageviews, orders to order items, products to order items, and order items to refunds.

Single-direction filtering was used to reduce ambiguity in the model. A Date table supports time-based analysis, and date relationships must be considered when interpreting visuals based on different event tables.

### DAX and Analytical Measures

The report includes measures for:

- Revenue, orders, customers, gross profit, and margin
- Average order value and product profitability
- Sessions, converted sessions, and conversion rate
- Revenue and profit per session
- Returning customers and repeat customer rate
- Two-item orders
- Refund counts, refund amounts, and refund rates
- Month-over-month and year-over-year revenue comparisons

### Tools Used

- Power BI
- DAX
- Power Query
- Data Modeling
- SQL
- Excel
- Python and Pandas
- Matplotlib and Seaborn

---

## 6. Definitions and Limitations

The results should be interpreted with the following points in mind.

- **Refund rate:** Defined in this Power BI project as refunded items divided by items sold.
- **Returning customers:** The result depends on whether repeat purchasing is measured across the full dataset or within the selected filter context.
- **Conversion rate:** Depends on the session and order definitions used by the measure.
- **Funnel analysis:** Distinct sessions reaching individual stages should not be treated as a verified sequential conversion journey unless the same session cohort and stage progression have been validated.
- **Date filtering:** Active and inactive date relationships can affect how slicers filter measures and visuals.
- **Partial year:** The 2015 data covers January through March only.
- **Causality:** Observed differences between products, devices, traffic sources, and landing pages do not establish the reasons behind those differences.
- **Metric reconciliation:** Values can differ across SQL, Python, and Power BI because of differences in data grain, definitions, filters, or relationship behavior.

---

## 7. Business Value of the Analysis

The project demonstrates how an analytics workflow can move beyond reporting totals to identify areas for further business investigation.

The analysis highlights:

1. A substantial desktop-mobile conversion gap.
2. A low overall returning-customer rate under the project's definition.
3. Concentration of refund value in a major product.
4. Variation in landing-page conversion performance.
5. The importance of monitoring revenue alongside gross profit and margin.
6. The need to compare marketing volume and conversion efficiency together.

These findings do not prove the cause of the observed patterns or quantify realized savings. Instead, they provide a data-backed starting point for prioritizing investigations, designing experiments, and monitoring future business performance.

## 8. Conclusion

The Power BI phase completes the reporting component of the Online Retail Business Analysis project.

By combining a relational data model, DAX measures, time-based analysis, and five interactive dashboards, the report provides a structured way to explore sales performance, marketing conversion, customer behavior, and product refunds.

The project demonstrates an end-to-end analytics workflow using SQL, Excel, Python, and Power BI, with a focus on translating business data into measurable findings and practical next steps.