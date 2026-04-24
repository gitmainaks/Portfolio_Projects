# 📦 Vendor Performance Analysis

<p align="center">
  <em>Uncovering procurement efficiencies, inventory bottlenecks, and margin mysteries across 10,692 transactions</em>
</p>

<div align="center">

![Python](https://img.shields.io/badge/Python-3.8%2B-blue?style=for-the-badge&logo=python&logoColor=white)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-orange?style=for-the-badge&logo=jupyter&logoColor=white)
![pandas](https://img.shields.io/badge/pandas-1.x-150458?style=for-the-badge&logo=pandas&logoColor=white)
![Matplotlib](https://img.shields.io/badge/Matplotlib-3.x-11557c?style=for-the-badge&logo=python&logoColor=white)
![Seaborn](https://img.shields.io/badge/Seaborn-0.11-9cf?style=for-the-badge&logo=python&logoColor=white)
![SciPy](https://img.shields.io/badge/SciPy-1.7-8c8c8c?style=for-the-badge&logo=scipy&logoColor=white)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)

</div>

---

## 🎯 Overview

This project delivers a **full‑stack exploratory data analysis** of vendor–brand transactions, converting raw data into **strategic procurement intelligence**. Through statistical rigour and compelling visuals, we answer six high‑impact business questions that drive vendor management, inventory optimisation, and profitability growth.

<div align="center">

| 🔢 Dataset size | 💲 Currency | 🧹 Data quality |
|:---:|:---:|:---:|
| 10,692 records | USD | Zero‑sales, negative GP, negative margin records excluded |

</div>

---

## 🔎 Key Highlights

| 💡 Insight | 📈 Impact |
|---|---|
| ⚠️ **Supplier risk** | Top 10 vendors command **65.69%** of total purchases — a single‑point‑of‑failure risk |
| 📉 **Bulk savings** | Large orders enjoy a **72%** lower unit cost ($10.78 vs. $39.07) |
| 💤 **Dormant capital** | **$2.71M** in unsold inventory tied up in slow‑moving stock |
| 💎 **Hidden gems** | **198 brands** show high margins but low sales — a promo goldmine |
| 🔄 **Margin paradox** | Low‑performing vendors achieve **41.57%** avg. margin vs. **31.18%** for top performers |
| ✅ **Operational sync** | Purchase ↔ Sales quantity correlation: **r = 0.99** |

---

## 🧪 Data Cleaning & Methodology

We applied a rigorous pre‑processing protocol to safeguard analytical integrity:

| 🧹 Condition | 🧰 Action |
|---|---|
| Gross Profit ≤ 0 | Excluded from profitability analysis |
| Profit Margin ≤ 0 (incl. -∞) | Excluded from margin benchmarking |
| Total Sales Quantity = 0 | Retained for inventory analysis; excluded from sales metrics |

**🛠️ Analytical toolbox**  
- Descriptive statistics, distribution profiling, outlier detection  
- Correlation heatmap (16 variables)  
- Two‑sample hypothesis test (profit margin differentials by vendor tier)

---

## 🖼️ Visual Storytelling

<div align="center">

| 📊 Correlation Heatmap | 📉 Margin Confidence Intervals |
|:---:|:---:|
| *Revealed near‑perfect purchase‑sales alignment (r=0.99)* | *Confirmed statistically distinct profitability tiers* |

</div>


---

## 📚 Report Insight

Inside you’ll find:
- Detailed summary statistics and outlier commentary
- Correlation analysis & its business interpretation
- Actionable recommendations ranked by priority (🔴 High / 🟡 Medium / 🟢 Low)
- Vendor‑level slow‑inventory breakdown
- Hypothesis test formalisation

---

## 🧠 Strategic Recommendations Snapshot

| 🔔 Priority | 🎯 Action | 📈 Expected Outcome |
|:---:|---|:---|
| 🔴 High | Promote the 198 high‑margin, low‑volume brands | Volume growth without margin erosion |
| 🔴 High | Diversify vendor base to reduce top‑10 concentration | Reduced supply chain risk |
| 🟡 Medium | Formalize bulk‑order agreements to lock in 72% cost advantage | Sustained unit cost efficiency |
| 🟡 Medium | Liquidate/optimise $2.71M slow‑moving inventory | Improved cash flow |
| 🟡 Medium | Boost marketing for low‑performing, high‑margin vendors | Margin‑accretive growth |
| 🟢 Low | Build vendor scorecards (turnover, margin, concentration) | Proactive risk monitoring |

---

<div align="center">

