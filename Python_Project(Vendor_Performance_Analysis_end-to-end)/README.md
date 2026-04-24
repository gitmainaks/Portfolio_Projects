# 📦 Vendor Performance Analysis

<p align="center">
  <img src="https://via.placeholder.com/150x150/2d3748/ffffff?text=🛒📊" alt="Project Logo" width="150" style="border-radius:20px"/>
</p>

<p align="center">
  <strong>Strategic procurement intelligence powered by exploratory data analysis</strong>
</p>

<div align="center">

[![Python](https://img.shields.io/static/v1?label=Python&message=&color=3776AB&style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![Jupyter](https://img.shields.io/static/v1?label=Jupyter&message=&color=F37626&style=for-the-badge&logo=jupyter&logoColor=white)](https://jupyter.org/)
[![pandas](https://img.shields.io/static/v1?label=pandas&message=&color=150458&style=for-the-badge&logo=pandas&logoColor=white)](https://pandas.pydata.org/)
[![Matplotlib](https://img.shields.io/static/v1?label=Matplotlib&message=&color=11557c&style=for-the-badge&logo=python&logoColor=white)](https://matplotlib.org/)
[![Seaborn](https://img.shields.io/static/v1?label=Seaborn&message=&color=9cf&style=for-the-badge&logo=python&logoColor=white)](https://seaborn.pydata.org/)
[![SciPy](https://img.shields.io/static/v1?label=SciPy&message=&color=8C8C8C&style=for-the-badge&logo=scipy&logoColor=white)](https://scipy.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](https://opensource.org/licenses/MIT)

</div>

---

## 🎯 Overview

This project transforms **10,692 vendor‑brand transactions** into **actionable supply‑chain insights**.  
By combining statistical rigour with vivid visualisations, we answer six high‑impact questions that directly influence vendor management, inventory efficiency, and profit growth.

<div align="center">

| 🔢 Records | 💲 Currency | 🧹 Data Cleansing |
|:---:|:---:|:---|
| 10,692 | USD | Negative/zero‑sales records removed |

</div>

---

## 🔎 Key Findings at a Glance

| 💡 Insight | 📈 Impact |
|---|---|
| ⚠️ **Supplier concentration risk** | Top 10 vendors absorb **65.69%** of total purchase spend |
| 📉 **Bulk purchasing power** | Large orders achieve a **72%** lower unit cost ($10.78 vs $39.07) |
| 💤 **Dormant inventory capital** | **$2.71M** tied up in slow‑moving stock (turnover < 1.0) |
| 💎 **Hidden revenue gems** | **198 brands** boast high margins but suffer from low volumes |
| 🔄 **The margin paradox** | Low‑performing vendors average **41.57%** margin vs **31.18%** for top performers |
| ✅ **Operational harmony** | Purchase ↔ Sales quantity correlation is a near‑perfect **r = 0.99** |

---

## 🧪 Data Cleaning & Methodology

Only analytically sound records were retained to ensure the integrity of all reported metrics.

| 🧹 Condition | 🧰 Action |
|---|---|
| Gross Profit ≤ 0 | Excluded from profitability calculations |
| Profit Margin ≤ 0 (incl. -∞) | Excluded from margin benchmarking |
| Total Sales Quantity = 0 | Retained for inventory analysis; removed from sales benchmarks |

**🛠️ Analytical toolbox**  
- Descriptive statistics & distribution profiling  
- Outlier detection & treatment  
- Correlation heatmap — 16 financial/operational variables  
- Two‑sample hypothesis test (vendor tier profitability)

---

## 🖼️ Visual Storytelling

<div align="center">

| 📊 Correlation Heatmap | 📉 Confidence Interval Comparison |
|:---:|:---:|
| *Reveals the almost perfect alignment between purchasing and sales* | *Confirms a statistically significant gap in margin structures* |

</div>

*All charts, along with the complete 12‑page strategic report, are available under [`reports/`](reports/).*

---

## 🗂️ Repository Structure

```
📁 vendor-performance-analysis/
├── 📁 data/                  # Raw & processed datasets (sampled / de‑identified)
├── 📁 notebooks/            # Jupyter notebooks – step‑by‑step EDA walkthrough
├── 📁 src/                  # Python scripts for cleaning, analysis, and visualisation
├── 📁 reports/              # Final PDF report & exported figures
├── 📄 requirements.txt      # Python dependencies
└── 📄 README.md             # You are here ✨
```

---

## 🚀 Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/your-username/vendor-performance-analysis.git
cd vendor-performance-analysis

# 2. Install dependencies (preferably in a virtual environment)
pip install -r requirements.txt

# 3. Launch the main analysis
jupyter notebook notebooks/Vendor_Performance_EDA.ipynb
```

> 🔒 *The original dataset may be proprietary. A synthetic sample or aggregated summary can be provided upon request.*

---

## 📚 Full Strategic Report

[📄 **Download the complete report (PDF)**](reports/Vendor_Performance_Report.pdf)

Inside you’ll find:
- Summary statistics & outlier commentary
- Business interpretation of correlations
- Vendor‑level slow‑inventory breakdown
- Hypothesis test formalisation
- Actionable recommendations ranked by priority

---

## 🧠 Strategic Recommendations

| 🔔 Priority | 🎯 Action | 📈 Expected Outcome |
|:---:|---|:---|
| 🔴 High | Run targeted promotions for 198 high‑margin, low‑volume brands | Sales lift without margin erosion |
| 🔴 High | Diversify vendor base – reduce Top‑10 spend from 65.69% to <50% | Supply‑chain resilience |
| 🟡 Medium | Lock in volume‑tiered purchase agreements (72% cost advantage) | Sustainable unit cost savings |
| 🟡 Medium | Optimise $2.71M slow‑moving inventory (clearance / renegotiation) | Healthier cash flow & storage |
| 🟡 Medium | Strengthen marketing for high‑margin, under‑performing vendors | Margin‑accretive volume growth |
| 🟢 Low | Deploy vendor scorecards (turnover, margin, concentration) | Proactive risk monitoring |

---

<div align="center">

### 🛠️ Built with passion and Python

![Python](https://img.icons8.com/color/40/000000/python.png)
![Jupyter](https://img.icons8.com/fluency/40/000000/jupyter.png)
![GitHub](https://img.icons8.com/material-outlined/40/000000/github.png)

</div>

---

<p align="center">
  <sub>💡 <em>Replace the logo placeholder with your own project icon and make this README uniquely yours.</em></sub>
</p>
