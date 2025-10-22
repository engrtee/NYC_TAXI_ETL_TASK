/************************** DDL SCRIPT TO CREATE GOLD VIEWS ********************************


-- These views can be used for analytics and reporting ----------
-- I will list out all the possible dimension tables and the fact table so we can have a well functional datawarehouse. 


==========================================================================================================================================================

Dimension Tables - (The rationale behind picking them is because based on the site, I checked online, there is a corresponding description for the codes.)
		 1. Rate Code Dimensions Table
		 2. Vendor ID Dimensions Table
		 3. Store and Forward Flag
		 4. Payment Type
================================================================================================================================================================*/



-- Fact Table: 
 --1. Main Taxi Data Table



-- Create dimension Tables for the ffg 
--1. Rate Code Dimensions Table 

CREATE VIEW gold.dim_RateCodeID AS
SELECT	 
	DISTINCT RateCodeID, RateCodename
	FROM  silver_nyc_taxi_table




--2.. Payment Type Dimensions Table 

CREATE VIEW gold.dim_paymentType AS
SELECT	
	DISTINCT payment_type, payment_typeID as Payment_Type_Name
	FROM silver_nyc_taxi_table

-- 3. Vendor ID Table
CREATE VIEW gold.dim_Vendor AS
SELECT	
	DISTINCT VendorID, VendorName 
	FROM silver_nyc_taxi_table


-- 4 Facts Taxi Table
CREATE VIEW gold.fact_taxi AS
SELECT * FROM 
 silver_nyc_taxi_table



