USE [FuelStationDb];

CREATE TABLE Transactions
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    FuelStationId INT NOT NULL 
        FOREIGN KEY 
        REFERENCES FuelStations(Id),
    PumpNumber INT NOT NULL,
    TransactionDate DATETIME NOT NULL,
    TransactionDateUtc DATETIME NOT NULL,
    TotalAmount DECIMAL(18,2) NOT NULL,
    PaymentMethod NVARCHAR(50) NOT NULL, -- Cash, Card, Loyalty
    DiscountTotal DECIMAL(18,2) NULL,
    ItemRecordsXml XML NOT NULL,
    CreatedAt DATETIME NOT NULL,
    UpdatedAt DATETIME NOT NULL
);
