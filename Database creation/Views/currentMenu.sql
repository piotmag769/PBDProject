CREATE VIEW currentMenu AS
SELECT POM.Product_ID, POM.Menu_ID, M.StartDate, M.EndDate, POM.Price
FROM dbo.Menu AS M 
INNER JOIN dbo.Product_On_Menu AS POM ON M.Menu_ID = POM.Menu_ID
WHERE (CAST(M.EndDate AS DATE) >= CAST(GETDATE() AS DATE))