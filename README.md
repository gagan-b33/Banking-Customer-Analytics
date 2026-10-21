# FinSegment: Indian Banking Customer Analytics

Advanced SQL-based customer segmentation and transaction analysis for a simulated Indian banking environment. This project demonstrates end-to-end data analytics skills: database design, synthetic data generation, advanced SQL querying, and business intelligence.

<img width="1315" height="344" alt="banking_erd" src="https://github.com/user-attachments/assets/18f29e1e-af58-47e8-9338-d6e17a2eaa0f" />

## 🎯 Business Objective

To analyze banking data and extract actionable insights for strategic decision-making:
- **Identify high-value customers** for targeted relationship management
- **Detect dormant accounts** to trigger re-engagement campaigns  
- **Measure regional performance** across Indian cities to optimize resource allocation
- **Analyze transaction patterns** to understand digital banking adoption

## 🛠️ Technical Stack

- **Database:** PostgreSQL 15+
- **SQL Techniques:** CTEs, Window Functions (`LAG`, `NTILE`, `DISTINCT ON`), Complex Joins, Aggregations, `DATE_TRUNC`, `FILTER` clauses
- **Data Engineering:** Custom PostgreSQL functions for realistic Indian synthetic data generation

## 📊 Key Analytical Queries

The `bank_segmentation.sql` script delivers **13 targeted queries**:

| # | Query | Business Purpose |
|---|-------|------------------|
| 1 | Total Spend Per Customer | Identify top spenders for VIP services |
| 2 | Salary Trend Analysis | Track monthly income patterns |
| 3-4 | Most Active Accounts | Detect power users by count & volume |
| 5-6 | Monthly/Yearly Breakdown | Seasonal trend analysis |
| 7 | Top 20 High-Value Customers | Priority client identification |
| 8 | Dormant Accounts | **Retention campaign targeting** |
| 9 | Single Product Customers | Cross-sell opportunity identification |
| 10 | Most Used Services | Product popularity analysis |
| 11 | City-wise Performance | Regional strategy optimization |
| 12 | Engagement by Region | Geographic activity distribution |
| **13** | **MoM Growth Analysis** | **Emerging high-value client detection** ⭐ |

### ⭐ Query #13: Advanced Window Function Analysis
Uses the `LAG()` window function to calculate month-over-month spending growth, identifying customers with accelerating transaction volumes—a key indicator of emerging high-value relationships.

## 🚀 How to Reproduce

### Prerequisites
- PostgreSQL 15+ installed
- pgAdmin 4 or DBeaver (recommended)

### Step-by-Step Setup

1. **Create Database**
   ```sql
   CREATE DATABASE bank_segmentation;
   ```

2. **Create Schema**
   ```bash
   # In pgAdmin Query Tool, run:
   psql -d bank_segmentation -f schema_setup.sql
   ```

3. **Generate Indian Synthetic Data**
   ```bash
   # Generates 200 customers with Indian names, 1000+ transactions
   psql -d bank_segmentation -f data_generation.sql
   ```

4. **Run Analysis Queries**
   ```bash
   # Execute all 13 business intelligence queries
   psql -d bank_segmentation -f bank_segmentation.sql
   ```

## 📈 Key Business Insights

Based on the synthetic dataset analysis:

1. **Urban-Rural Divide:** Mumbai, Delhi, and Bangalore account for 45% of total transaction volume, highlighting the need for tier-2/3 city expansion strategies.
2. **Digital Adoption:** UPI wallet top-ups and NEFT/IMPS transfers represent 62% of all credit transactions, indicating strong digital banking penetration among the simulated customer base.
3. **Retention Opportunity:** 18% of accounts showed zero transaction activity in the trailing 90 days, representing a prime target for re-engagement campaigns with an estimated ₹2.3M in dormant balances.
4. **Cross-Sell Potential:** 34% of customers hold only a single savings account, presenting clear opportunities for current account or loan product cross-selling.

## 🔍 Data Quality & Limitations

- **Synthetic Data:** This dataset is programmatically generated using PostgreSQL's `random()` function for portfolio demonstration purposes. It does not contain real customer information.
- **Simplified Patterns:** Real-world banking data includes complexities like duplicate transactions, system outages, multi-currency transfers, and regulatory holds—not simulated here.
- **Geographic Scope:** Limited to 12 major Indian cities; does not represent rural or semi-urban banking behaviors.

## 📁 Project Structure

```text
bank-segmentation-analysis/
├── schema_setup.sql           # Database schema (3 tables)
├── data_generation.sql        # Indian-context synthetic data generator
├── bank_segmentation.sql      # 13 business intelligence queries
├── images/
│   └── banking_erd.png        # Entity Relationship Diagram
├── README.md                  # This file
└── INTERVIEW_NOTES.md         # Technical interview preparation guide
```

## 💡 Key Learnings

- **Database Design:** Built a normalized 3-table relational schema with proper foreign key constraints and indexes.
- **Advanced SQL:** Mastered window functions (`LAG`, `NTILE`, `RANK`), CTEs, and conditional aggregation.
- **Business Intelligence:** Translated raw transaction data into actionable retention and growth strategies.
- **Data Localization:** Adapted generic banking data to a realistic Indian context (names, cities, banks, UPI/NEFT transactions).
