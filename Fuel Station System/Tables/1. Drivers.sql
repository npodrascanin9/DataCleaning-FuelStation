USE [FuelStationDb];

CREATE TABLE Drivers
(
	Id INT IDENTITY(1, 1) PRIMARY KEY,
	Name NVARCHAR(150) NOT NULL,
	Surname NVARCHAR(150) NOT NULL,
	DateOfBirth DATE NULL,
	LicenceNumber VARCHAR(20) NULL,
	IsActive BIT NOT NULL,
	CreatedAt DATETIME NOT NULL,
	UpdatedAt DATETIME NOT NULL
);


CREATE UNIQUE INDEX
	UQ_Drivers_LicenceNumber
ON
	[Drivers]
	(
		LicenceNumber
	)
WHERE
	LicenceNumber IS NOT NULL
	AND LicenceNumber <> '';
