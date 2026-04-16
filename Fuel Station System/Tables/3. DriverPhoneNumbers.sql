USE [FuelStationDb];

-- One driver can have more than 1 phone number

CREATE TABLE [DriverPhoneNumbers]
(
	DriverId INT NOT NULL,
	PhoneNumber VARCHAR(20) NOT NULL,
	CreatedAt DATETIME NOT NULL
);

ALTER TABLE [DriverPhoneNumbers]
ADD CONSTRAINT PK_DriverPhoneNumbers
PRIMARY KEY 
(
	DriverId, 
	PhoneNumber
);

ALTER TABLE [DriverPhoneNumbers]
ADD CONSTRAINT FK_DriverPhoneNumbers_Drivers
FOREIGN KEY (DriverId) 
REFERENCES Drivers (Id);

CREATE UNIQUE INDEX UQ_DriverPhoneNumbers_PhoneNumber
ON DriverPhoneNumbers(PhoneNumber);
