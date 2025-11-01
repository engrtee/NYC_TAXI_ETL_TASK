-- Create database and Schemas----

--===========================================================

-- The purpose of this script is to create the database and the schemas.---------------

USE master;
GO


-- To create the database NYC TAXI DATA
CREATE DATABASE NYC_TAXI_DATA
GO


-- To use the database we just created
USE NYC_TAXI_DATA


-- -- Create schemas

-- Bronze Schema--
CREATE SCHEMA bronze;
GO


-- Silver Schema--
CREATE SCHEMA silver;
GO


--- Gold Schema--
CREATE SCHEMA gold;
GO
