# 📊 Vendor Performance Analysis  
**Exploratory Data Analysis & Strategic Insights**

![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Jupyter](https://img.shields.io/badge/Jupyter-F37626?style=for-the-badge&logo=jupyter&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=for-the-badge&logo=pandas&logoColor=white)
![NumPy](https://img.shields.io/badge/NumPy-013243?style=for-the-badge&logo=numpy&logoColor=white)
![Matplotlib](https://img.shields.io/badge/Matplotlib-11557C?style=for-the-badge&logo=matplotlib&logoColor=white)
![Seaborn](https://img.shields.io/badge/Seaborn-3776AB?style=for-the-badge&logo=seaborn&logoColor=white)
![SciPy](https://img.shields.io/badge/SciPy-8CAAE6?style=for-the-badge&logo=scipy&logoColor=white)
![SQLite](https://img.shields.io/badge/SQLite-003B57?style=for-the-badge&logo=sqlite&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)

---

## 📌 Project Overview

This project delivers a comprehensive **vendor performance analysis** using a transactional dataset of **10,692 vendor‑brand records**. Through exploratory data analysis (EDA), statistical testing, and deep‑dives into purchasing behaviour, sales efficiency, and profitability, the study uncovers actionable patterns that support:

- Strategic procurement planning  
- Vendor relationship management  
- Inventory optimisation  

The final output is a structured report with six core research questions answered by data‑driven evidence, accompanied by a clear set of recommendations for stakeholders.

---

## 🔍 Key Questions Addressed

1. How concentrated is procurement spend, and what are the supply‑chain risks?  
2. What is the financial advantage of bulk purchasing?  
3. Which vendors tie up the most capital in slow‑moving inventory?  
4. Are there high‑margin brands that are under‑performing in sales?  
5. Do high‑performing and low‑performing vendors operate with different profitability models?  
6. Is the observed difference in profitability statistically significant?

---

## 📂 Dataset

| Attribute               | Description                                       |
|-------------------------|---------------------------------------------------|
| **Records**             | 10,692 vendor‑brand transactions                 |
| **Variables**           | 18 financial & operational metrics               |
| **Data Cleaning**       | Removed zero‑sales, negative gross profit, and negative margin entries |
| **Key Metrics**         | Purchase price, sales volume, gross profit, margin, stock turnover, etc. |

> All monetary figures are reported in **USD**.

---

## 🛠️ Tools & Technologies

- **Python** – Core programming language  
- **Pandas** & **NumPy** – Data manipulation and numerical analysis  
- **Matplotlib** & **Seaborn** – Visualisations and correlation heatmap  
- **SciPy** – Hypothesis testing (two‑sample t‑test)  
- **Jupyter Notebook** – Interactive development and documentation  

---

## 📊 Methodology

1. **Data Cleaning** – Removal of erroneous or non‑representative records (e.g., non‑profitable transactions).  
2. **Descriptive Statistics** – Summary statistics, distribution analysis, and outlier detection.  
3. **Correlation Analysis** – Heatmap to uncover relationships between 16 numeric variables.  
4. **Segmentation** – High‑ vs. low‑performing vendor tier classification based on sales volume.  
5. **Hypothesis Testing** – Two‑sample t‑test to validate profitability differences between vendor tiers.  
6. **Strategic Synthesis** – Translation of analytical findings into prioritised business recommendations.

---

## 💡 Key Insights

| # | Insight | Strategic Implication |
|---|---------|-----------------------|
| 1 | **Top 10 vendors** account for 65.69% of total purchases → high concentration risk. | Diversify supplier base to mitigate supply‑chain disruption. |
| 2 | **Bulk orders** achieve a **72% lower unit cost** ($10.78 vs. $39.07 per unit). | Formalise volume‑tiered purchasing agreements. |
| 3 | **$2.71M** in unsold inventory is tied up in slow‑moving stock (turnover < 1). | Renegotiate order quantities, run clearance promotions. |
| 4 | **198 brands** show high margins but low sales – an untapped revenue opportunity. | Targeted marketing and selective price promotions. |
| 5 | **Low‑performing vendors** have higher average margins (41.57%) than top performers (31.18%). | Volume‑versus‑margin strategies must be customised per tier. |
| 6 | **Hypothesis test rejects H₀** – statistically significant margin difference between tiers. | Confirms the need for tier‑specific management approaches. |

---

## 📈 Strategic Recommendations

| Priority | Action | Expected Impact |
|----------|--------|-----------------|
| 🔴 High | Launch promotional campaigns for 198 high‑margin, low‑sales brands | Volume uplift without sacrificing margin structure |
| 🔴 High | Reduce vendor concentration from 65.7% to below 50% in 12 months | Lower supply‑chain disruption risk |
| 🟡 Medium | Introduce volume‑tiered purchase agreements to lock in bulk discounts | Sustained unit cost advantage |
| 🟡 Medium | Liquidate or optimise the $2.71M slow‑moving inventory | Improved cash flow and reduced holding costs |
| 🟡 Medium | Enhance distribution & marketing for low‑performing, high‑margin vendors | Margin‑accretive volume growth |
| 🟢 Low | Deploy ongoing vendor scorecards (turnover, margin, concentration) | Data‑driven procurement and early risk warnings |

---

