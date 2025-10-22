CREATE DATABASE NYC_TAXI_DATA

USE NYC_TAXI_DATA

/*=============================================================================
DDL SCRIPT: This is to create the bronze tables
*/

CREATE TABLE bronze.nyc_yellowtaxi (
VendorID INT,
tpep_pickup_datetime DATETIME,
tpep_dropoff_datetime DATETIME,
passenger_count	FLOAT,
trip_distance FLOAT,
RatecodeID  FLOAT,
store_and_fwd_flag VARCHAR,
PULocationID	INT,
DOLocationID  INT,
payment_type INT,
fare_amount	FLOAT,
extra FLOAT,
mta_tax	FLOAT,
tip_amount FLOAT,
tolls_amount	FLOAT,
improvement_surcharge	FLOAT,
total_amount	FLOAT,
congestion_surcharge FLOAT,
Airport_fe FLOAT
)

