# Paytm UPI Transaction & Fraud Analysis

End-to-end data analytics project on 250K+ simulated UPI transactions (₹328M), covering SQL querying, Python EDA, and an interactive Power BI dashboard.

## Workflow
1. *SQL* — Queried and analyzed transaction data: fraud detection (high-value anomalies, suspicious merchant velocity), revenue by category, device-wise behavior
2. *Python* — Cleaned and explored the dataset using Pandas, loaded it into MySQL via SQLAlchemy
3. *Power BI* — Built a 2-page interactive dashboard (Business Overview + Fraud & Risk Analysis)

## Key Insights
- Overall fraud rate: 0.19% | Transaction success rate: 95%
- Fraud risk concentrated in specific merchant categories, banks, and hours of day
- Identified high-value anomalies (transactions 3x above average) and suspicious merchant velocity patterns

## Tools Used
SQL (MySQL), Python (Pandas, SQLAlchemy), Power BI (DAX)

## Project Files
- python/paytm_project.ipynb — Data cleaning & EDA
- sql/paytm_project.sql — Fraud detection & business insight queries
- power bi/paytm_upi_dashboard.pbix — Interactive dashboard
- power bi/page1_overview.png, power bi/page2_Fraud_analysis.png — Dashboard screenshots

## Screenshots


![Overview] (power%20bi/page1_overview.png)

![fraud analysis] (power%20bi/page2_Fraud_analysis.png)



![Fraud Analysis](project_upi/power%20bi/page2_Fraud_analysis.png)
