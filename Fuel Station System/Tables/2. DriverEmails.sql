USE [FuelStationDb];

-- One driver can have more than 1 email

CREATE TABLE [DriverEmails]
(
	DriverId INT NOT NULL,
	Email NVARCHAR(180) NOT NULL,
	CreatedAt DATETIME NOT NULL
);

ALTER TABLE DriverEmails
ADD CONSTRAINT PK_DriverEmails 
PRIMARY KEY 
(
	DriverId, 
	Email
);

ALTER TABLE DriverEmails
ADD CONSTRAINT FK_DriverEmails_Drivers
FOREIGN KEY (DriverId) 
REFERENCES Drivers(Id);

CREATE UNIQUE INDEX UQ_DriverEmails_Email
ON DriverEmails(Email);
