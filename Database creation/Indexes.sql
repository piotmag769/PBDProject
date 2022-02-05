CREATE INDEX Reservation_Status_Index on Reservations (Status);

CREATE INDEX Reserved_Tables_Table on Reserved_Tables(Table_ID);

CREATE INDEX Reserved_Tables_Reservation on Reserved_Tables(Reservation_ID);