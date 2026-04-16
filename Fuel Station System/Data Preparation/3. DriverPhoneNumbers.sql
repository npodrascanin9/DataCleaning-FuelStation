USE [FuelStationDb];

-- 13 records execute
INSERT INTO DriverPhoneNumbers (DriverId, PhoneNumber, CreatedAt)
VALUES
-- John Smith (1) ima jedan broj
(1, '+1-202-555-0101', GETDATE()),

-- Maria Gonzalez (2) ima dva broja
(2, '+34-600-123-456', GETDATE()),
(2, '+34-699-987-654', GETDATE()),

-- Hans Müller (3) ima jedan broj
(3, '+49-171-555-7890', GETDATE()),

-- Sophie Dubois (4) ima dva broja
(4, '+33-612-345-678', GETDATE()),
(4, '+33-699-876-543', GETDATE()),

-- Luca Rossi (5) nema broj (preskačemo ga)

-- Anna Kowalska (6) ima jedan broj
(6, '+48-501-234-567', GETDATE()),

-- Peter Novák (7) ima dva broja
(7, '+420-777-123-456', GETDATE()),
(7, '+420-606-987-654', GETDATE()),

-- Olga Ivanova (8) ima jedan broj
(8, '+7-916-555-4321', GETDATE()),

-- David Johnson (9) ima jedan broj
(9, '+44-7700-900123', GETDATE()),

-- Emily Brown (10) ima dva broja
(10, '+1-416-555-7890', GETDATE()),
(10, '+1-647-555-1234', GETDATE());
