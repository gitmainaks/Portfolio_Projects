# 🏬 Store Sales Data Warehouse

![Data Warehouse](https://img.shields.io/badge/Data%20Warehouse-Star%20Schema-blue?style=for-the-badge)
![SQL Server](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![PySpark](https://img.shields.io/badge/PySpark-E25A1C?style=for-the-badge&logo=apachespark&logoColor=white)
![Medallion Architecture](https://img.shields.io/badge/Architecture-Medallion%20(Bronze%2FSilver%2FGold)-gold?style=for-the-badge)
![Draw.io](https://img.shields.io/badge/Diagrams-Draw.io-FF6B35?style=for-the-badge&logo=diagramsdotnet&logoColor=white)

A robust, analytics-ready data warehouse for store sales, built from raw CSV transactions using a modern medallion architecture. Clean, validated data flows through **Bronze → Silver → Gold** layers, ending in a star schema with pre-built customer and product report views — ready to power dashboards in minutes.

---

## 📦 Project Overview

This project transforms raw sales records into a trustworthy, structured warehouse that supports trend analysis, customer segmentation, product performance, and geographic reporting. All quality checks are automated; every load is verified before it reaches the Gold layer.

**Key outcomes:**
- **Single source of truth** preserved in Bronze
- **Cleansed, enriched dataset** in Silver
- **Business‑friendly dimension & fact tables** in Gold
- **Pre‑built report views** for immediate dashboard consumption
- **Comprehensive data quality** checks guarding every ETL step

---

## 🧱 Architecture: Medallion Layers

| Layer   | What It Contains                                                                                             | Purpose                                        |
|---------|--------------------------------------------------------------------------------------------------------------|------------------------------------------------|
| 🟤 **Bronze** | Raw data ingested directly from CSV (exact copy)                                                             | Immutable audit trail, source of truth         |
| ⚪ **Silver** | Cleaned, standardized data with derived fields (`unit_price`), prefix‑stripped IDs                           | Analysis‑ready, consistent, validated dataset  |
| 🟡 **Gold**   | Star schema: `dim_customers`, `dim_products`, `fact_sales` + report views (`report_customers`, `report_products`) | Optimized for reporting, dashboards, ad‑hoc queries |

---

### Step‑by‑Step Flow

1. **Pre‑processing (PySpark)** – Removes special characters from product names, trims whitespace, and standardises text before loading.
2. **Bronze Load** – `BULK INSERT` into `bronze.ssf` table; full truncate & reload with timing logs.
3. **Silver Transformation** – Strips prefixes from `customer_id` and `product_id`, calculates `unit_price = sales / quantity`.
4. **Gold Views** – Creates `dim_customers`, `dim_products`, and `fact_sales` views, forming a classic **star schema**.
5. **Report Views** – `report_customers` (VIP/Regular/New, recency, avg spend) and `report_products` (performance segments, monthly revenue, AOV).

---

## ✅ Data Quality Assurance

Before moving to Silver, every row is checked. Any failed check stops the pipeline.

| Check Type               | What It Verifies                                                            |
|---------------------------|-----------------------------------------------------------------------------|
| Duplicate / Null PK       | `row_id` is unique and never missing                                        |
| Leading / Trailing Spaces | All text fields are trimmed – no invisible whitespace                       |
| Standardisation           | Ship modes, segments, categories, regions use consistent values             |
| Negative / Null Numbers   | `sales`, `quantity`, `discount`, `profit` are ≥0 and present                |
| Invalid Date Order        | `order_date` ≤ `ship_date` (no orders shipped before they were placed)      |

> **How it works:** Each check runs as a SQL query that returns **zero rows** when data is clean. Any returned rows flag issues for immediate resolution.

---

## 📋 Key Data Fields

| Field          | Description                                                                 |
|----------------|-----------------------------------------------------------------------------|
| `order_id`     | Unique transaction identifier                                               |
| `order_date`   | When the order was placed                                                   |
| `ship_date`    | When the order was shipped                                                  |
| `customer_id`  | Customer identifier (prefix removed in Silver)                              |
| `customer_name`| Full name of the customer                                                   |
| `segment`      | Consumer, Corporate, Home Office                                            |
| `region`       | Geographic region (e.g., West, East)                                        |
| `state` / `city` | Customer location details                                                 |
| `product_id`   | Product identifier (prefix removed)                                         |
| `product_name` | Cleaned product name                                                        |
| `category` / `sub_category` | Product classification (e.g., Furniture > Chairs)                 |
| `sales`        | Transaction revenue                                                         |
| `quantity`     | Number of units sold                                                        |
| `unit_price`   | **Derived** – `sales / quantity`                                            |
| `discount`     | Discount rate (0.2 = 20%)                                                   |
| `profit`       | Profit from the transaction                                                 |

---

## 📊 Analytics & Reporting

Once data reaches Gold, the following insights are available **out‑of‑the‑box**:

### Sales & Revenue
- Monthly / yearly totals, customer counts
- Cumulative running totals
- Moving averages of unit price

### Product Performance
- Top & bottom 5 products by revenue
- Revenue & avg unit price by sub‑category
- Year‑over‑year growth (Above Avg / Avg / Below Avg)
- Products compared to their own historical average

### Customer Insights
- Top 10 customers by revenue
- **Segmentation:** VIP (>12 months history + >$1,000 spend), Regular, New
- **Recency:** months since last order
- AOV (Average Order Value) & Avg Monthly Spend per customer

### Geographic Distribution
- Customer & volume counts by region / state / city

### Part‑to‑Whole & Price Bands
- % contribution of each sub‑category to total sales
- Products grouped into price bands: Below $50, $50‑100, $100‑200, Above $200

### Ready‑to‑Use Report Views
| View                  | Provides                                                                 |
|-----------------------|--------------------------------------------------------------------------|
| `gold.report_customers` | Segments (VIP/Regular/New), recency, average monthly spend               |
| `gold.report_products`  | Performance segments, monthly revenue, average order value (AOV)        |

---

## 🏁 Summary

✔ **Automated pipeline** from raw file to analytics‑ready Gold Layer  
✔ **Star schema** for fast, simple reporting joins  
✔ **Pre‑built report views** – plug straight into Power BI or Tableau  
✔ **Comprehensive analytics** – trends, ranking, segmentation, YoY comparisons  
✔ **Built‑in data quality** – zero‑defect guarantee at every load  

> 🚀 **Connect your favourite BI tool and start building live dashboards.**  

---
