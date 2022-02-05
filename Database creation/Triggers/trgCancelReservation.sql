CREATE TRIGGER [dbo].[trgCancelReservation] ON [dbo].[Reservations]
AFTER UPDATE
AS
BEGIN
    DECLARE @ClientID int;
    DECLARE @ReservationID int;
    DECLARE @Status tinyint;

    IF ((SELECT COUNT(*) FROM inserted) = 0)
        THROW 51000, 'empty_Update', 1;

    IF ((SELECT COUNT(*) FROM inserted) > 0)
        BEGIN
            SELECT @ClientID = i.Client_ID, @ReservationID = i.Reservation_ID, @Status = i.Status FROM inserted i;
            IF((SELECT COUNT(*) FROM [dbo].[Individual]) > 0
                   AND @Status = 6
                    AND [dbo].getFullReservationCost(@ReservationID) > (SELECT TOP 1 d.Value FROM [dbo].[Discount_Parameters] d))
                UPDATE Individual
                SET OrdersCount += 1
                WHERE Client_ID = @ClientID;
        END
END