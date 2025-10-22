CREATE OR ALTER PROCEDURE proc_load_silver AS 
BEGIN
	DECLARE @start_time DATETIME, @endtime DATETIME;
	set @start_time = GETDATE();
	PRINT '==============Loading Silver layer ============================'
	PRINT  '==============Inserting data into the silver_nyc_taxi tables at============================';
	PRINT  @start_time;

	-- To Delete the old table if it finds it already created. 
	DROP TABLE IF EXISTS silver_nyc_taxi_table


		WITH silver_table as 
		(
		SELECT TOP 1000000	CASE 
				WHEN VendorID = 1 THEN 'Creative Mobile Technologies'
				WHEN VendorID = 2 THEN 'Verifone Inc'
				ELSE 'na'
		END AS VendorName,
		VendorID,
		tpep_pickup_datetime,
		tpep_dropoff_datetime,
		passenger_count,
		trip_distance,
			CASE 
				WHEN RatecodeID = 1 THEN 'Standard Rate'
				WHEN RatecodeID = 2 THEN 'JFK'
				WHEN RatecodeID = 3 THEN 'Newark'
				WHEN RatecodeID = 4 THEN 'Nassau or Wechester'
				WHEN RatecodeID = 5 THEN 'Negotiated Fare'
				WHEN RatecodeID = 6 THEN 'Group Ride' 
				ELSE 'n/a'
			END AS RatecodeName	,
			RateCodeID,

			CASE
				WHEN store_and_fwd_flag ='Y'	THEN 'Store and Forward'
				WHEN store_and_fwd_flag = 'N'	THEN 'Store and Not Forwarded'
			END AS store_and_fwd_flag,
		PULocationID,
		DOLocationID,
			CASE 
				WHEN payment_type = 1 THEN 'Credit Card'
				WHEN payment_type = 2 THEN 'Cash'
				WHEN payment_type = 3 THEN ' No charge' 
				WHEN payment_type = 4 THEN 'Dispute' 
				WHEN payment_type = 5 THEN 'Unknown'
				WHEN payment_type = 6 THEN 'Voided trip' 
			ELSE 'n/a'
			END AS payment_typeID	,
			payment_type,
		fare_amount	,
		extra	,
		mta_tax	,
		tip_amount,
		tolls_amount,
		improvement_surcharge	,
		total_amount	,
		congestion_surcharge,
		Airport_fe as 'Airport Fee'

		FROM  bronze.nyc_yellowtaxi
		WHERE tpep_pickup_datetime < tpep_dropoff_datetime AND total_amount > 0
		)
 
		SELECT * INTO  silver_nyc_taxi_table
		from silver_table


			SET @endtime = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND,@start_time,@endtime) AS VARCHAR) + ' seconds';
		PRINT @endtime;
END

exec proc_load_silver