# 🛒 E-Commerce Analytics & Logistics Modeling — Olist Dataset

## 📌 Project Overview

This project presents an end-to-end data analytics workflow built on a real Brazilian e-commerce dataset (Olist).  
The main goal is to simulate a real-world data analytics and data science process, including:

- Data modeling using SQL
- Exploratory Data Analysis (EDA)
- Advanced behavioral analytics
- Business insights generation
- Predictive modeling for logistics performance

Unlike tutorial-style projects, this work emphasizes **realistic data issues, feature engineering, and business interpretation**.

---

## 🎯 Objectives

- Build a relational analytics dataset from raw CSV data using SQL
- Analyze business performance and operational patterns
- Identify customer spending behavior and purchasing dynamics
- Evaluate logistics performance and delivery efficiency
- Develop predictive models to anticipate operational risks

---

## 🗄️ Data Source

Dataset: **Olist Brazilian E-Commerce Public Dataset**  
Source: Kaggle

The raw data includes:

- Orders
- Customers
- Payments
- Order items
- Reviews
- Sellers
- Geolocation
- Product metadata

---

## 🧱 Project Structure

```
ecommerce-analytics-sql-ml/
│
├── data/
│ ├── raw/
| |── processed/ 
│ └── olist.db
│
├── sql/
│ ├── 01_create_fact_tables.sql
│ └── 02_create_analytics_table.sql
│
├── notebooks/
│ ├── 01_eda.ipynb
│ ├── 02_analytics.ipynb
│ ├── 03_business_insights.ipynb
│ └── 04_modeling.ipynb
│
├── src/
│ └── create_db.py
│ └── run_sql.py
|
|── powerbi/
|  └── ecommerce_dashboard.pbix
|
├── docs/
|  └──db_schema.png 
|
├── requirements.txt
|
└── README.md
```

---

## ⚙️ Data Engineering & SQL Modeling

Raw CSV files were loaded into SQLite and transformed into structured analytical tables.

Key transformations included:

- Revenue aggregation from order items
- Payment consolidation
- Delivery time calculation
- Feature engineering using SQL

Fact tables created:

- `fact_revenue`
- `fact_paid`
- `analytics_orders`

This step simulates real-world data warehouse preparation.

---

## 📊 Exploratory Data Analysis (EDA)

Main analyses included:

- Expected vs. actual payments comparison
- Temporal evolution of the business
- Payment method distribution
- Geographic revenue analysis
- Ticket size distribution
- Delivery time analysis

Key Findings:

- Revenue growth showed clear temporal patterns
- Strong geographic concentration in São Paulo
- Highly skewed order value distribution
- Noticeable delivery variability across orders

---

## 🧠 Advanced Analytics

Further behavioral and operational analyses were conducted:

### Customer Spending Segmentation
Orders were segmented into low, medium, and high spend categories.

Findings:
- High-spend orders contribute disproportionately to revenue
- Spending distribution is highly skewed

### Logistics vs. Spending
- Higher spend orders tend to have longer delivery times
- Logistics complexity increases with order size

### Temporal Behavior
- Orders peak between 10:00 and 21:00
- Weekdays dominate order volume
- High-ticket purchases follow general traffic patterns

---

## 💼 Business Insights

### Operational Optimization
- Delivery delays are linked to operational complexity
- Peak demand windows identified for logistics planning

### Customer Strategy
- High-value customers could benefit from priority logistics
- Payment diversity indicates different purchasing behaviors

### Geographic Strategy
- Revenue concentration highlights core operational regions
- Delivery performance varies across states

---

## 📊 Interactive Dashboard

A Power BI dashboard was developed to present executive-level insights.

Main features:
- Revenue evolution
- Geographic concentration
- Logistics performance

File available in /powerbi folder.

---

## 🤖 Predictive Modeling

### Model Objective
Predict the probability of delivery delays using behavioral and operational features available at purchase time.

### Features Used
- Purchase hour
- Day of week
- Month
- Number of items
- Payment complexity

### Models Implemented
- Random Forest Classifier
- Baseline classification models

### Results

Model performance showed:

- Strong ability to identify on-time deliveries
- Limited capacity to detect delayed orders

This indicates that:

- Operational logistics variables are missing
- Behavioral features alone are insufficient predictors

---

## 🧾 Key Takeaways

- Real-world datasets rarely produce high-performing models without operational features
- SQL modeling is critical before meaningful analysis
- Behavioral analytics can generate actionable business insights even without strong predictive models
- Understanding model limitations is as valuable as achieving high accuracy

---

## 🚀 Future Improvements

- Incorporate geographic distance between customers and sellers
- Add product category complexity features
- Include seller-level performance metrics
- Introduce advanced logistic modeling
- Evaluate regression-based delivery time prediction

---

## 🛠️ Technologies Used

- Python
- Pandas
- SQLite
- SQL
- Scikit-learn
- Matplotlib

---

## 👤 Author

Sebastian Souto  
Data Science Student

---

## 📎 License

This project is for educational and portfolio purposes.
