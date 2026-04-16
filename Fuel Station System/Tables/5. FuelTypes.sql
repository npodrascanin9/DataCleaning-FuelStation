CREATE TABLE FuelTypes
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL, -- Dizel, Benzin, LPG
    PricePerLiter DECIMAL(18,2) NOT NULL,
    IsActive BIT NOT NULL
);
