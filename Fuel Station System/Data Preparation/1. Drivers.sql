USE [FuelStationDb];

-- Let's insert 20 drivers
SET IDENTITY_INSERT Drivers ON;

INSERT INTO Drivers 
(Id, Name, Surname, DateOfBirth, LicenceNumber, IsActive, CreatedAt, UpdatedAt)
VALUES
(1, 'John', 'Smith', '1985-03-12', 'US12345', 1, GETDATE(), GETDATE()),
(2, 'Maria', 'Gonzalez', '1990-07-25', 'ES54321', 1, GETDATE(), GETDATE()),
(3, 'Hans', 'Müller', '1978-11-02', 'DE98765', 1, GETDATE(), GETDATE()),
(4, 'Sophie', 'Dubois', '1988-01-15', 'FR24680', 1, GETDATE(), GETDATE()),
(5, 'Luca', 'Rossi', '1995-05-30', 'IT13579', 1, GETDATE(), GETDATE()),
(6, 'Anna', 'Kowalska', '1982-09-09', 'PL11223', 1, GETDATE(), GETDATE()),
(7, 'Peter', 'Novák', '1975-12-20', 'CZ99887', 1, GETDATE(), GETDATE()),
(8, 'Olga', 'Ivanova', '1993-04-18', 'RU77665', 1, GETDATE(), GETDATE()),
(9, 'David', 'Johnson', '1987-06-14', 'UK55443', 1, GETDATE(), GETDATE()),
(10, 'Emily', 'Brown', '1991-02-28', 'CA33221', 1, GETDATE(), GETDATE()),
(11, 'Alejandro', 'Martinez', '1980-08-05', 'MX44556', 1, GETDATE(), GETDATE()),
(12, 'Isabella', 'Silva', '1989-10-22', 'BR66778', 1, GETDATE(), GETDATE()),
(13, 'Mateusz', 'Lewandowski', '1977-03-03', 'PL88990', 1, GETDATE(), GETDATE()),
(14, 'Katarzyna', 'Nowak', '1994-12-11', 'PL22334', 1, GETDATE(), GETDATE()),
(15, 'Yuki', 'Tanaka', '1983-07-07', 'JP55667', 1, GETDATE(), GETDATE()),
(16, 'Chen', 'Wei', '1992-09-19', 'CN77889', 1, GETDATE(), GETDATE()),
(17, 'Viktor', 'Horváth', '1986-11-27', 'HU99001', 1, GETDATE(), GETDATE()),
(18, 'Elena', 'Popescu', '1990-05-13', 'RO11224', 1, GETDATE(), GETDATE()),
(19, 'Andreas', 'Papadopoulos', '1984-04-04', 'GR33445', 1, GETDATE(), GETDATE()),
(20, 'Fatima', 'Al-Farsi', '1996-01-21', 'AE55666', 1, GETDATE(), GETDATE());


SET IDENTITY_INSERT 
	Drivers OFF;
