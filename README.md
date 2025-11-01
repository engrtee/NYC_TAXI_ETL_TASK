# 🚕 NYC Taxi Data ETL Pipeline (SQL + Python)

This project is an **End-to-End ETL Pipeline** built to demonstrate how the **Medallion Architecture (Bronze–Silver–Gold)** works in practice using **SQL Server** and **Python**.

It was inspired by a real-world challenge from the **Data Engineering Community (DEC)**, where participants were tasked to build and deploy a data pipeline for the NYC Taxi dataset.

Although this version focuses on a **Full Load**, it lays the foundation for incremental loads, data validation, and transformation logic.

---

## 🧭 Project Overview

The goal of this project was to:

- Understand and apply the **Bronze–Silver–Gold (Medallion)** data architecture  
- Build an **ETL pipeline** from scratch  
- Implement **data quality checks** and **transformations** in SQL  
- Create **reusable stored procedures** for consistent data loading  

---

## 🏗️ Architecture

markdown
Copy code
    ┌────────────┐
    │   Python   │
    │ Extraction │
    └──────┬─────┘
           │
           ▼
┌────────────────────────────┐
│ Bronze Layer │
│ Raw data from CSV (SQL) │
└───────────┬────────────────┘
│
▼
┌────────────────────────────┐
│ Silver Layer │
│ Data cleaning + enrichment │
└───────────┬────────────────┘
│
▼
┌────────────────────────────┐
│ Gold Layer │
│ Dimension + Fact Views │
└────────────────────────────┘

yaml
Copy code

---

## 🧱 Layers Breakdown

### **1. Bronze Layer**
- Holds the **raw** taxi trip data.
- Data is ingested using a **BULK INSERT** operation from a local CSV file.
- No transformations applied.

```sql
EXEC load_bronze_layer;
Scripts:

init_database.sql

ddl scripts.sql

2. Silver Layer
Cleans and standardizes raw data.

Adds descriptive mappings for:

VendorID → Vendor Name

RateCodeID → Rate Code Description

payment_type → Payment Type Description

Filters invalid rows (e.g., negative amounts, invalid timestamps).

sql
Copy code
EXEC proc_load_silver;
Script: proc_load_silver.sql

3. Gold Layer
Creates analytical views for reporting:

gold.dim_RateCodeID

gold.dim_paymentType

gold.dim_Vendor

gold.fact_taxi

These views can be used directly in tools like Power BI, Tableau, or SQL-based dashboards.

🧪 Data Quality Checks
Data validation was a key part of this project.
A few SQL checks were added to ensure reliability of the Silver data:

sql
Copy code
-- 1. Check invalid pickup/dropoff times
SELECT COUNT(*) FROM silver_nyc_taxi_table
WHERE tpep_pickup_datetime > tpep_dropoff_datetime;

-- 2. Check for negative total amounts
SELECT * FROM silver_nyc_taxi_table
WHERE total_amount < 0;

-- 3. Confirm standardized categorical values
SELECT payment_type, RatecodeID, store_and_fwd_flag
FROM silver_nyc_taxi_table;
🐍 Python Data Extraction
Data extraction was done using Python to pull all 12 months of 2024 NYC Taxi trip data from the public dataset and merge them into a single Excel file.

python
Copy code
import pandas as pd

def loaddata():
    df_empty = pd.DataFrame()
    numrange = ["01","02","03","04","05","06","07","08","09","10","11","12"]
    for num in numrange:
        url = f"https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-{num}.parquet"
        df = pd.read_parquet(url)
        print(f"url {num} and the length of the original dataframe is {len(df_empty)} and the monthly load is {len(df)}")
        df_empty = pd.concat([df_empty, df])
    df_empty.to_excel("NYC Taxi Data.xlsx", index=False)

loaddata()
This script automates the extraction of monthly taxi trip data and prepares it for loading into SQL.

⚙️ Setup Instructions
1. Clone the Repository
bash
Copy code
git clone https://github.com/<your-username>/nyc-taxi-etl-pipeline.git
cd nyc-taxi-etl-pipeline
2. Create the Database
Run init_database.sql in SQL Server Management Studio (SSMS) to create:

Database: NYC_TAXI_DATA

Schemas: bronze, silver, gold

3. Create the Bronze Table
Execute ddl scripts.sql to set up the base raw table.

4. Load the Data
Modify the file path in the stored procedure if needed, then run:

sql
Copy code
EXEC load_bronze_layer;
5. Transform and Load to Silver
sql
Copy code
EXEC proc_load_silver;
6. Create the Gold Views
Execute the view creation statements at the end of your SQL script.

💡 Key Learnings
Data Architecture: Learned how data flows through layered systems.

Data Quality: Saw firsthand how invalid timestamps and negative totals can affect reliability.

Automation: Stored procedures simplify repeatable ETL tasks.

Scalability: The Medallion model provides a clean foundation for future incremental loads.

🧰 Tools & Technologies
Category	Tool
Database	SQL Server
Language	Python (pandas)
File Format	Parquet → Excel → CSV
Architecture	Medallion (Bronze–Silver–Gold)
Visualization (optional)	Power BI / Tableau

🚀 Next Steps
Add incremental load logic

Integrate Airflow or SQL Agent for scheduling

Visualize trends (e.g., average fare by vendor, peak trip hours) using Power BI
