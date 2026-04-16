USE [FuelStationDb];

SET IDENTITY_INSERT FuelTypes ON;

INSERT INTO FuelTypes 
(Id, Name, PricePerLiter, IsActive)
VALUES 
    (101, 'Dizel', 1.65, 1),
    (102, 'Benzin 95', 1.70, 1),
    (103, 'Benzin 98', 1.85, 1),
    (104, 'LPG', 0.95, 1);

SET IDENTITY_INSERT FuelTypes OFF;
