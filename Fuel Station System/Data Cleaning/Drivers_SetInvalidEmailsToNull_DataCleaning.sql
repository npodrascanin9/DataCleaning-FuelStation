-- DATA CLEANING for invalid emails
-- Description: some drivers might have invalid emails, so it's a good idea to check
-- Task Description: if a driver has an invalid email for instance "zxcv", it needs to be set to NULL


-- First, Let's insert two new drivers with invalid emails
INSERT INTO [dbo].[Drivers]
(
     [Name]
    ,[Surname]
    ,[DateOfBirth]
    ,[LicenceNumber]
    ,[IsActive]
    ,[CreatedAt]
    ,[UpdatedAt]
    ,[Emails]
    ,[PhoneNumbers]
)
VALUES
(
    'Constantin'
    ,'Copelari'
    ,'2000-12-12'
    ,'IT-34123'
    ,1
    ,GETDATE()
    ,GETDATE()
    ,'invalidemail;asdfzxcv;T%#S;Copelari@gmail.com'
    ,NULL
);

INSERT INTO [dbo].[Drivers]
(
     [Name]
    ,[Surname]
    ,[DateOfBirth]
    ,[LicenceNumber]
    ,[IsActive]
    ,[CreatedAt]
    ,[UpdatedAt]
    ,[Emails]
    ,[PhoneNumbers]
)
VALUES
(
     'Antonie'
    ,'Intorniz'
    ,'2000-02-11'
    ,'RT-0313-QW'
    ,1
    ,GETDATE()
    ,GETDATE()
    ,'Antonie.asdf'
    ,NULL
);


-- Step 2
-- Backup data
SELECT *
INTO Drivers_Backup
FROM Drivers;


-- Step 3
-- Data cleaning
WITH DriverEmails_CTE AS (
    SELECT
        Drivers.Id,
        value AS Email,
        dbo.VerifyEmail(value) AS IsValid
    FROM Drivers
    CROSS APPLY STRING_SPLIT(Drivers.Emails, ';')
),
ValidEmails AS (
    SELECT
        Id,
        Email
    FROM DriverEmails_CTE
    WHERE IsValid = 1
)
UPDATE 
    Drivers
SET 
    Drivers.Emails = STUFF(
        (
            SELECT 
                ';' + ve.Email
            FROM 
                ValidEmails ve
            WHERE 
                ve.Id = Drivers.Id
            FOR XML PATH(''), 
            TYPE
        ).value(
            '.', 
            'NVARCHAR(MAX)'
        ), 
        1, 
        1, 
        ''
    )

FROM 
    Drivers
WHERE 
    EXISTS 
    (
        SELECT 
            1 
        FROM 
            DriverEmails_CTE [DriverEmails]
        WHERE 
            [DriverEmails].Id = Drivers.Id
            AND [DriverEmails].IsValid = 0
    );

-- Step 4
-- Verify records (there should be no records)
SELECT
    d.Id,
    value AS Email
    
FROM 
    Drivers d
CROSS APPLY 
    STRING_SPLIT(d.Emails, ';')
WHERE
    dbo.VerifyEmail(value) = 0;
