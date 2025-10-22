/*********** Data Quality Checks *************************/


/***1. Pickup date is greater than drop off date and this is not possible so it is wrong. **/
SELECT COUNT(*) FROM  silver_nyc_taxi_table
WHERE tpep_pickup_datetime > tpep_dropoff_datetime 


--2. Wrong Amounts - To check if total amount is less than 0-- Wrong Amounts
SELECT * FROM silver_nyc_taxi_table
WHERE total_amount < 0


--3.  Standardization of the Payment type , Store Forward number and Rate Code ID to pick the original value of the entered data.
SELECT payment_type,RatecodeID,store_and_fwd_flag
FROM silver_nyc_taxi_table

------ Payment Type ----------- 
-- 1= Credit Card 
-- 2= Cash; 
-- 3= No charge;
-- 4= Dispute; 
-- 5= Unknown; 
-- 6= Voided trip.

----- Store Forward Number ----------
-- 1- Store and Forward
-- 2 - Store 


----- Rate Code ID ----------
--1= Standard rate; 
--2= JFK; 
--3= Newark;
--4= Nassau or Westchester;
--5= Negotiated fare;
--6= Group ride.


-- To Create the schema
CREATE SCHEMA silver 



