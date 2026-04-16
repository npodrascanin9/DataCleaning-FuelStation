USE [FuelStationDb];

/*
====================
Data Cleaning Notes
- In the initial design, DriverPhoneNumbers and DriverEmails tables were used to support one-to-many relationships 
  (since a single driver can have multiple phone numbers or email addresses).
- Over time, this approach proved less efficient for reporting and querying, especially when the majority of drivers 
  have only one or two contact details.
- For performance and simplicity, the model was adjusted so that the Drivers table itself contains Emails and PhoneNumbers 
  columns, allowing direct access without joins.
- This denormalized approach can increase column count in Drivers (potentially over 100), but it simplifies 
  data retrieval and reduces query complexity in common scenarios.
- Backup tables were created before transformation to ensure data integrity and rollback capability.
====================
*/

-- 1st step
-- Add column PhoneNumbers
IF NOT EXISTS
(
	SELECT
		1
	FROM
		INFORMATION_SCHEMA.COLUMNS
	WHERE
		TABLE_NAME = 'Drivers'
		AND COLUMN_NAME = 'PhoneNumbers'
)
BEGIN
	PRINT ('Add PhoneNumbers column to Drivers table');
	
	ALTER TABLE Drivers
	ADD PhoneNumbers NVARCHAR(MAX) NULL;
END

-- 2nd step
-- Backup data
-- if anything goes wrong, these backup tables can be reused to fix problems
SELECT *
INTO Drivers_PhoneNumbersDataCleaning_Backup
FROM Drivers;

SELECT *
INTO DriverPhoneNumbers_PhoneNumbersDataCleaning_Backup
FROM DriverPhoneNumbers;


-- 3rd step
-- Create a temp table that contains wanted records
CREATE TABLE #DriverPhoneNumbers
(
	DriverId INT PRIMARY KEY,
	PhoneNumbers NVARCHAR(150)
);

INSERT INTO #DriverPhoneNumbers
(
	DriverId,
	PhoneNumbers
)
SELECT
	DriverPhoneNumbers.DriverId,
	STRING_AGG(
		DriverPhoneNumbers.PhoneNumber,
		','
	) AS PhoneNumbers
FROM
	DriverPhoneNumbers
GROUP BY
	DriverPhoneNumbers.DriverId;


-- 4th step
-- use temp table for cleaning data
UPDATE 
	[Drivers]
SET 
	[Drivers].[PhoneNumbers] = [DriverPhoneNumbers].[PhoneNumbers]
FROM 
	[Drivers]
LEFT JOIN 
	#DriverPhoneNumbers [DriverPhoneNumbers]
ON 
	[DriverPhoneNumbers].[DriverId] = [Drivers].[Id];




-- 5th step
-- Verify data and drop temp table
SELECT
	Name,
	PhoneNumbers
FROM [Drivers]
/*
=====================
Name		PhoneNumbers
John		+1-202-555-0101
Maria		+34-600-123-456,+34-699-987-654
Hans		+49-171-555-7890
Sophie		+33-612-345-678,+33-699-876-543
Luca		NULL
Anna		+48-501-234-567
Peter		+420-606-987-654,+420-777-123-456
Olga		+7-916-555-4321
David		+44-7700-900123
Emily		+1-416-555-7890,+1-647-555-1234
Alejandro	NULL
Isabella	NULL
Mateusz		NULL
Katarzyna	NULL
Yuki		NULL
Chen		NULL
Viktor		NULL
Elena		NULL
Andreas		NULL
Fatima		NULL
=====================
*/

-- In the end: drop temp tables
DROP TABLE #DriverPhoneNumbers;

/*
NOTE:
It would be wise not to delete the DriverEmails table.

- Although we can use sp_depends to check references, this does not cover dynamic SQL usage.
- A more reliable approach is to query sys.sql_modules for occurrences of 'DriverEmails':
  SELECT p.name, m.definition
  FROM sys.procedures p
  JOIN sys.sql_modules m ON p.object_id = m.object_id
  WHERE m.definition LIKE '%DriverPhoneNumbers%';

- However, even this method cannot guarantee detection of all external dependencies, 
  since applications outside the database may also rely on DriverPhoneNumbers.
	- Applications can include: .NET (Dapper, Entity Framework Core), ETL, etc.
- For that reason, it is considered best practice to keep the DriverPhoneNumbers table, 
  even though backups have been created and data has been migrated.
*/
