-- staff role
CREATE ROLE staff

GRANT EXECUTE ON [dbo].[addDishToProducts] to Staff
GRANT EXECUTE ON [dbo].[AddOrderToReservation] to staff
GRANT EXECUTE ON [dbo].[AddPersonToReservation] to staff
GRANT EXECUTE ON [dbo].[addProductToMenu]to staff
GRANT EXECUTE ON [dbo].[AddReservationToInvoice]to staff
GRANT EXECUTE ON [dbo].[AddTableToReservation]to staff
GRANT EXECUTE ON [dbo].[cancelReservation]to staff
GRANT EXECUTE ON [dbo].[ChangeReservationStatus]to staff
GRANT EXECUTE ON [dbo].[createCompanyClient]to staff
GRANT EXECUTE ON [dbo].[createIndividualClient]to staff
GRANT EXECUTE ON [dbo].[CreateInvoice]to staff
GRANT EXECUTE ON [dbo].[createNewClient]to staff
GRANT EXECUTE ON [dbo].[createReservation]to staff
GRANT EXECUTE ON [dbo].[editDatesOfMenuSet]to staff
GRANT EXECUTE ON [dbo].[EditProductAmountInReservation]to staff
GRANT EXECUTE ON [dbo].[endReservation]to staff
GRANT EXECUTE ON [dbo].[OrdersForTodaySortedByDate]to staff
GRANT EXECUTE ON [dbo].[SelectSumOfAllProductsBetween]to staff
GRANT EXECUTE ON [dbo].[ShowAllFreeTablesBetweenDates]to staff

GRANT SELECT ON dbo.CurrentMenu to staff
GRANT SELECT ON dbo.OrdersForToday to staff

GRANT SELECT ON [dbo].[getFreeTablesBetweenDates] to staff
GRANT SELECT ON [dbo].[menuUntil] to staff

GRANT EXECUTE ON [dbo].[CountOfAllFreeTablesBetweenDates] to staff
GRANT EXECUTE ON [dbo].[getActualStatus] to staff
GRANT EXECUTE ON [dbo].[getAmountOfFreeTables] to staff
GRANT EXECUTE ON [dbo].[getFullReservationCost] to staff

-- manager role
CREATE ROLE manager

GRANT EXECUTE to manager
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER to manager

-- customer role
CREATE ROLE customer

GRANT EXECUTE ON [dbo].[AddPersonToReservation] to customer
GRANT EXECUTE ON [dbo].[cancelReservation]to customer
GRANT EXECUTE ON [dbo].[createCompanyClient]to customer
GRANT EXECUTE ON [dbo].[createIndividualClient]to customer
GRANT SELECT ON dbo.CurrentMenu to customer
