USE [FuelStationDb];


-- insert 13 records
INSERT INTO DriverEmails 
(DriverId, Email, CreatedAt)
VALUES
-- John Smith (1) ima jedan email
(1, 'john.smith@gmail.com', GETDATE()),

-- Maria Gonzalez (2) ima dva emaila
(2, 'maria.gonzalez@gmail.com', GETDATE()),
(2, 'maria.gonzalez@company.com', GETDATE()),

-- Hans Müller (3) ima jedan email
(3, 'hans.mueller@yahoo.de', GETDATE()),

-- Sophie Dubois (4) ima dva emaila
(4, 'sophie.dubois@gmail.com', GETDATE()),
(4, 'sophie.dubois@work.fr', GETDATE()),

-- Luca Rossi (5) nema email (preskačemo ga)

-- Anna Kowalska (6) ima jedan email
(6, 'anna.kowalska@gmail.com', GETDATE()),

-- Peter Novák (7) ima dva emaila
(7, 'peter.novak@gmail.com', GETDATE()),
(7, 'peter.novak@firma.cz', GETDATE()),

-- Olga Ivanova (8) ima jedan email
(8, 'olga.ivanova@mail.ru', GETDATE()),

-- David Johnson (9) ima jedan email
(9, 'david.johnson@hotmail.co.uk', GETDATE()),

-- Emily Brown (10) ima dva emaila
(10, 'emily.brown@gmail.com', GETDATE()),
(10, 'emily.brown@company.ca', GETDATE());
