CREATE VIEW OrdersForToday AS
SELECT p.Name, o.Amount, r.StartDate
FROM dbo.Orders AS o 
INNER JOIN dbo.Products AS p ON p.Product_ID = o.Product_ID 
LEFT OUTER JOIN dbo.Reservations AS r ON r.Reservation_ID = o.Reservation_ID
WHERE (r.Status IN (0, 2)) AND (CAST(r.StartDate AS DATE) = CAST(GETDATE() AS DATE))