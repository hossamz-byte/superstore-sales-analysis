# Superstore Sales Analysis

End-to-end analysis of the Superstore sales dataset: data cleaning in Python, business questions in SQL Server, and a dashboard and story in Tableau.

Built as part of the DEPI scholarship, Professional Data Analyst track.

## Tools
Python (pandas, matplotlib, seaborn) · SQL Server · Tableau

## Project structure
| Folder | Content |
|---|---|
| [data](data) | Raw, cleaned and featured CSVs, plus `kpis.txt` |
| [notebook](notebook) | Python notebook: cleaning, features, charts |
| [SQL_bussiness](SQL_bussiness) | SQL business queries |
| [Tableu](Tableu) | Tableau workbook |
| [images](images) | Charts and dashboard screenshots |

## Workflow
1. **Python:** cleaned the data, handled outliers, and created new features (Sales_Level, Shipping Duration).
2. **SQL Server:** answered business questions with aggregates, window functions (LAG, ROW_NUMBER, running totals), CTEs and subqueries.
3. **Tableau:** built a dashboard and a story with the main insights.

## Key findings
- Total sales: **2.26M** from **4,922 orders** and **793 customers**. Average order value: **459.42**.
- Sales dipped **4.2%** in 2016, then grew **30.6%** in 2017 and **20.3%** in 2018.
- **Technology** is the top category (36.6% of sales). Furniture has 32.2% and Office Supplies 31.2%.
- **West** and **East** bring 61% of sales. California, New York and Texas bring 40.7%.
- September to December bring **51.8%** of yearly sales.
- **293 customers** ordered in all 4 years and bring 45.9% of sales. The top 10 customers bring only 6.8%.
- Standard Class shipping averages **5 days**. Same Day averages 0.04 days.

## Tableau story
The story walks through the results in this order:
1. **Title:** Superstore Sales 2015–2018: What Drives Our Revenue?
2. **Recap of totals:** sales, orders, customers and average order value.
3. **Growth:** sales fell 4.2% in 2016, then grew 30.6% in 2017 and 20.3% in 2018.
4. **Regions:** West and East make up 61% of sales.
5. **Forecast 2019:** all categories trend up, but the forecast is flat with wide ranges, so it is a rough estimate.
6. **Categories:** Technology brings 36.6% of sales. Click a category to see its sub-categories.

Screenshots: see the [images](images) folder.

## SQL queries
All queries are in the [SQL_bussiness](SQL_bussiness) folder. They cover:
- Sales by category with % of total
- Region sales, orders and average order value
- Top 10 customers
- Shipping days per ship mode
- Yearly growth with LAG
- Top 3 sub-categories per category
- Monthly running total
- Loyal customers (ordered in all 4 years)
- States above average sales
- Customers who bought in 2017 but not in 2018
- Products sold in all 4 regions

## Python
The notebook is in the [notebook](notebook) folder. Key results are saved in [data/kpis.txt](data/kpis.txt).

## How to run
1. Clone the repository.
2. Open the notebook in the `notebook` folder and run all cells. The paths are relative, so keep the folder structure as it is.
3. Open the workbook from the `Tableu` folder in Tableau Public (free).
