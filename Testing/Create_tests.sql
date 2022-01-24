--- testing creations
EXEC createNewClient @Address = 'elo', @PostalCode=45555, @City='Krakow'

EXEC createCompanyClient @Address = 'elo', @PostalCode=45555, @City='Krakow', @CompanyName='uwuowo'

EXEC createIndividualClient @Address = 'elo', @PostalCode=45555, @City='Krakow', @FirstName='uwu', @LastName= 'owo'


select * from Individual
select * from client
select * from company
select * from Client_Discounts


EXEC createReservation 5, '2022-02-01 16:00:00', '2022-02-02 01:00:00', NULL, 3


select * from Reservations
