USE [FuelStationDb];

SET IDENTITY_INSERT FuelStations ON;

INSERT INTO FuelStations 
(Id, Name, Address, City, NoteDescription, IsActive, CreatedAt, UpdatedAt)
VALUES
    (1, 'Pumpa Zemun', 'Beogradski put 12', 'Beograd', 'Glavna pumpa u Zemunu', 1, GETDATE(), GETDATE()),
    (2, 'Pumpa Novi Sad', 'Bulevar Oslobođenja 45', 'Novi Sad', 'Stanica kod centra', 1, GETDATE(), GETDATE()),
    (3, 'Pumpa Niš', 'Knjaževačka 88', 'Niš', 'Pumpa na izlazu iz grada', 1, GETDATE(), GETDATE()),
    (4, 'Pumpa Kragujevac', 'Kralja Petra I 22', 'Kragujevac', 'Nova stanica u centru', 1, GETDATE(), GETDATE());

SET IDENTITY_INSERT FuelStations OFF;
