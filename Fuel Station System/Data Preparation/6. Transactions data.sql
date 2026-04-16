USE [FuelStationDb];

SET IDENTITY_INSERT Transactions ON;

INSERT INTO Transactions 
(Id, FuelStationId, PumpNumber, TransactionDate, TransactionDateUtc, TotalAmount, PaymentMethod, DiscountTotal, ItemRecordsXml, CreatedAt, UpdatedAt)
VALUES
(1001, 1, 3, GETDATE(), GETUTCDATE(), 57.75, 'Cash', NULL,
'<Items>
    <Item>
        <FuelTypeId>101</FuelTypeId>
        <Liters>35</Liters>
        <PricePerLiter>1.65</PricePerLiter>
    </Item>
</Items>', GETDATE(), GETDATE()),

(1002, 1, 5, GETDATE(), GETUTCDATE(), 34.00, 'Card', 2.00,
'<Items>
    <Item>
        <FuelTypeId>102</FuelTypeId>
        <Liters>20</Liters>
        <PricePerLiter>1.70</PricePerLiter>
    </Item>
</Items>', GETDATE(), GETDATE()),

(1003, 2, 2, GETDATE(), GETUTCDATE(), 46.25, 'Loyalty', NULL,
'<Items>
    <Item>
        <FuelTypeId>103</FuelTypeId>
        <Liters>25</Liters>
        <PricePerLiter>1.85</PricePerLiter>
    </Item>
</Items>', GETDATE(), GETDATE()),

(1004, 2, 4, GETDATE(), GETUTCDATE(), 28.50, 'Cash', NULL,
'<Items>
    <Item>
        <FuelTypeId>104</FuelTypeId>
        <Liters>30</Liters>
        <PricePerLiter>0.95</PricePerLiter>
    </Item>
</Items>', GETDATE(), GETDATE());

SET IDENTITY_INSERT Transactions OFF;
