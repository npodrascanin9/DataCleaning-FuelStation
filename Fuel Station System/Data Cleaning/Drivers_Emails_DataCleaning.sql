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
-- Add column Emails
IF NOT EXISTS
(
	SELECT
		1
	FROM
		INFORMATION_SCHEMA.COLUMNS
	WHERE
		TABLE_NAME = 'Drivers'
		AND COLUMN_NAME = 'Emails'
)
BEGIN
	PRINT ('Add Emails column to Drivers table');
	
	ALTER TABLE Drivers
	ADD Emails NVARCHAR(MAX) NULL;
END

-- 2nd step
-- Backup data
-- if anything goes wrong, these backup tables can be reused to fix problems
SELECT *
INTO Drivers_EmailsDataCleaning_Backup
FROM Drivers;

SELECT *
INTO DriverEmails_EmailsDataCleaning_Backup
FROM DriverEmails;


-- 3rd step
-- Create a temp table that contains wanted records
CREATE TABLE #DriverEmails
(
	DriverId INT PRIMARY KEY,
	Emails NVARCHAR(150)
);

INSERT INTO #DriverEmails
(
	DriverId,
	Emails
)
SELECT
	DriverEmails.DriverId,
	STRING_AGG(
		DriverEmails.Email,
		';'
	) AS Emails
FROM
	DriverEmails
GROUP BY
	DriverEmails.DriverId;


-- 4th step
-- use temp table for cleaning data
UPDATE 
	[Drivers]
SET 
	[Drivers].[Emails] = [DriverEmails].[Emails]
FROM 
	[Drivers]
LEFT JOIN 
	#DriverEmails [DriverEmails]
ON 
	[DriverEmails].[DriverId] = [Drivers].[Id];


-- 5th step
-- Verify data and drop temp table
SELECT
	Name,
	Emails
FROM [Drivers]
/*
=====================
Name		Emails
John		john.smith@gmail.com
Maria		maria.gonzalez@company.com;maria.gonzalez@gmail.com
Hans		hans.mueller@yahoo.de
Sophie		sophie.dubois@gmail.com;sophie.dubois@work.fr
Luca		NULL
Anna		anna.kowalska@gmail.com
Peter		peter.novak@firma.cz;peter.novak@gmail.com
Olga		olga.ivanova@mail.ru
David		david.johnson@hotmail.co.uk
Emily		emily.brown@company.ca;emily.brown@gmail.com
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
DROP TABLE #DriverEmails;

/*
NOTE:
It would be wise not to delete the DriverEmails table.

- Although we can use sp_depends to check references, this does not cover dynamic SQL usage.
- A more reliable approach is to query sys.sql_modules for occurrences of 'DriverEmails':
  SELECT p.name, m.definition
  FROM sys.procedures p
  JOIN sys.sql_modules m ON p.object_id = m.object_id
  WHERE m.definition LIKE '%DriverEmails%';

- However, even this method cannot guarantee detection of all external dependencies, 
  since applications outside the database may also rely on DriverEmails.
	- Applications can include: .NET (Dapper, Entity Framework Core), ETL, etc.
- For that reason, it is considered best practice to keep the DriverEmails table, 
  even though backups have been created and data has been migrated.
*/
