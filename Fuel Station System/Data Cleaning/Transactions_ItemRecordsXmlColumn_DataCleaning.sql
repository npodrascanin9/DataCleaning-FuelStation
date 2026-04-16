/*
Transactions - data cleaning
- Problem description:
- Transactions table contains ItemRecords xml column

- Example of an xml:
    <Items>
      <Item>
        <FuelTypeId>102</FuelTypeId>
        <Liters>20</Liters>
        <PricePerLiter>1.70</PricePerLiter>
        <DiscountAmount>2.00</DiscountAmount>
      </Item>
    </Items>

- This approach is not good for writing queries, reports, etc.
- In order to solve this, data cleaning is mandatory.
- We should create a new table - TransactionItems
- and fill it with data from column ItemsRecordsXml located in Transactions table
*/

-- 1st step:
-- create a new table - TransactionItems
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'TransactionItems'
)
BEGIN
    CREATE TABLE TransactionItems
    (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        TransactionId INT NOT NULL 
            FOREIGN KEY 
            REFERENCES Transactions(Id),
        FuelTypeId INT NOT NULL 
            FOREIGN KEY 
            REFERENCES FuelTypes(Id),
        Liters DECIMAL(10,2) NOT NULL,
        PricePerLiter DECIMAL(18,2) NOT NULL,
        DiscountAmount DECIMAL(18,2) NULL,
        TotalPrice AS (Liters * PricePerLiter - ISNULL(DiscountAmount,0)) PERSISTED
    );

    CREATE NONCLUSTERED INDEX IX_TransactionItems_TransactionId
    ON TransactionItems
    (
        TransactionId ASC
    );
END


-- 2nd step
-- Backup data first
SELECT *
INTO Transactions_DataCleaning_Backup
FROM Transactions;


-- 3rd step
-- Insert data into table TransactionItems
INSERT INTO TransactionItems 
(
    TransactionId, 
    FuelTypeId, 
    Liters, 
    PricePerLiter, 
    DiscountAmount
)
SELECT
     Transactions.Id
    ,Tbl.Record.value('(FuelTypeId)[1]', 'INT')
        AS FuelTypeId
    ,Tbl.Record.value('(Liters)[1]', 'DECIMAL(10,2)')
        AS Liters
    ,Tbl.Record.value('(PricePerLiter)[1]', 'DECIMAL(18,2)')
        AS PricePerLiter
    ,Tbl.Record.value('(DiscountAmount)[1]', 'DECIMAL(18,2)')
        AS DiscountAmount

FROM 
    Transactions
CROSS APPLY 
    Transactions.ItemRecordsXml.nodes('/Items/Item') 
        AS Tbl(Record);


-- 4th step
-- Verify data
SELECT * 
FROM TransactionItems;
/*
EXPECTED RESULT:
==========================
Id	TransactionId	FuelTypeId	Liters	PricePerLiter	DiscountAmount	TotalAmount
1	1001	        101	        35.00	1.65	        NULL	        57.7500
2	1002	        102	        20.00	1.70	        2.00	        32.0000
3	1003	        103	        25.00	1.85	        NULL	        46.2500
4	1004	        104	        30.00	0.95	        NULL	        28.5000
==========================
*/

-- 5th step
-- Drop column ItemRecordsXml
-- Since we won't be using this column anymore, and since we managed to make a backup, this can be dropped :)
    -- Sure, it's always a good idea to check everywhere in the code whether it's used
    -- If the system is huge, then this would not be a good idea
IF EXISTS
(
    SELECT
        1
    FROM 
        INFORMATION_SCHEMA.COLUMNS
    WHERE
        TABLE_NAME = 'Transactions'
        AND COLUMN_NAME = 'ItemRecordsXml'
)
BEGIN
    ALTER TABLE Transactions
    DROP COLUMN ItemRecordsXml;
END
