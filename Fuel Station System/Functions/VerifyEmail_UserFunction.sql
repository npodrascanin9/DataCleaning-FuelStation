USE [FuelStationDb];

GO

CREATE FUNCTION [VerifyEmail] 
(
	@Email NVARCHAR(200)
)
RETURNS BIT
AS
BEGIN
	IF ISNULL(@Email, '') = ''
		RETURN 1;

	IF @Email NOT LIKE '%_@_%.__%' AND PATINDEX('%[^a-z,0-9,@,.,_,\-]%', @Email) = 0
		RETURN 0;
	
	RETURN 1;
END
