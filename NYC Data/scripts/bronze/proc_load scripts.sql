/************ PROCEDURE TO LOAD DATA INTO THE TABLES ****************/
CREATE  PROCEDURE load_bronze_layer AS 
BEGIN 
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY 
	SET @start_time = GETDATE();
	PRINT 'INSERTING DATA INTO bronze.nyc_yellowtaxi';
	PRINT @start_time 
	BULK INSERT bronze.nyc_yellowtaxi
	FROM 'C:\Users\tilesanmi\Downloads\NYC Data\data\NYC Taxi Data.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' SECONDS';
	PRINT @end_time
END TRY
BEGIN CATCH 
	PRINT ' Error Message' + ERROR_MESSAGE();
END CATCH
END

 