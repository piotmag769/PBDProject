-- tables
-- Table: Client
CREATE TABLE Client (
    Client_ID int  NOT NULL,
    Email varchar(35)  NULL,
    Phone int  NULL,
    Address varchar(35)  NOT NULL,
    PostalCode int  NOT NULL,
    City varchar(35)  NOT NULL,
    CONSTRAINT Email_check CHECK (Email like '%[a-zA-Z0-9][@][a-zA-Z0-9]%[.][a-zA-Z0-9]%'),
    CONSTRAINT Phone_check CHECK (CAST(Phone as nvarchar) like  '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    CONSTRAINT PostalCode_check CHECK (PostalCode like '[0-9][0-9][0-9][0-9][0-9]'),
    CONSTRAINT Address_check CHECK (Address not like '%[^a-zA-Z0-9. ]%'),
    CONSTRAINT City_check CHECK (City not like '%[^a-zA-Z ]%'),
    CONSTRAINT Client_pk PRIMARY KEY  (Client_ID)
);

-- Table: Client_Discounts
CREATE TABLE Client_Discounts (
    Client_ID int  NOT NULL,
    Discount1 date  NULL,
    Discount2 date  NULL,
    Discount2LastUsed int  NOT NULL,
    CONSTRAINT Discount2LastUsed_Check CHECK (Discount2LastUsed >= 0),
    CONSTRAINT Client_Discounts_pk PRIMARY KEY  (Client_ID)
);

-- Table: Company
CREATE TABLE Company (
    Client_ID int  NOT NULL,
    Company_Name varchar(35)  NOT NULL,
    NIP bigint  NULL,
    REGON varchar(14)  NULL,
    KRS bigint  NULL,
    CONSTRAINT NIP_check CHECK (CAST(NIP as nvarchar) like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    CONSTRAINT REGON_check CHECK (REGON like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    CONSTRAINT KRS_check CHECK (CAST(KRS as nvarchar)  like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    CONSTRAINT Company_pk PRIMARY KEY  (Client_ID)
);

-- Table: Discount_Parameters
CREATE TABLE Discount_Parameters (
    Discount_ID int  NOT NULL,
    OrdersAmount int  NULL,
    Value int  NOT NULL,
    Discount tinyint  NOT NULL,
    Days int  NULL,
    CONSTRAINT OrdersAmount_Check2 CHECK (OrdersAmount > 0),
    CONSTRAINT Value_Check CHECK (Value > 0),
    CONSTRAINT Discount_Check CHECK (Discount > 0 and Discount <= 100),
    CONSTRAINT Days_Check CHECK (Days > 0),
    CONSTRAINT Discount_Parameters_pk PRIMARY KEY  (Discount_ID)
);

-- Table: Individual
CREATE TABLE Individual (
    Client_ID int  NOT NULL,
    FirstName varchar(35)  NOT NULL,
    LastName varchar(35)  NOT NULL,
    OrdersCount int  NOT NULL,
    CONSTRAINT OrdersCount_Check CHECK (OrdersCount >= 0),
    CONSTRAINT Individual_pk PRIMARY KEY  (Client_ID)
);

-- Table: Invoices
CREATE TABLE Invoices (
    Invoice_ID varchar(20)  NOT NULL,
    Date date  NOT NULL,
    PersonalData varchar(50)  NOT NULL,
    Address varchar(35)  NOT NULL,
    City varchar(35)  NOT NULL,
    PostalCode int  NOT NULL,
    CONSTRAINT Invoice_ID_Check CHECK (Invoice_ID not like '%[^0-9/]%'),
    CONSTRAINT Postal_Code_Check_2 CHECK (PostalCode like '[0-9][0-9][0-9][0-9][0-9]'),
    CONSTRAINT Address_Check_2 CHECK (Address not like '%[^a-zA-Z0-9. ]%'),
    CONSTRAINT City_Check_2 CHECK (City not like '%[^a-zA-Z ]%'),
    CONSTRAINT Invoices_pk PRIMARY KEY  (Invoice_ID)
);

-- Table: Menu
CREATE TABLE Menu (
    Menu_ID int  NOT NULL,
    StartDate date  NOT NULL,
    EndDate date  NOT NULL,
    CONSTRAINT Date_Check CHECK (StartDate <= EndDate),
    CONSTRAINT Menu_pk PRIMARY KEY  (Menu_ID)
);

-- Table: Names
CREATE TABLE Names (
    Reservation_ID int  NOT NULL,
    Guest_ID int  NOT NULL,
    FirstName varchar(35)  NOT NULL,
    LastName varchar(35)  NOT NULL,
    CONSTRAINT Names_pk PRIMARY KEY  (Guest_ID,Reservation_ID)
);

-- Table: Orders
CREATE TABLE Orders (
    Reservation_ID int  NOT NULL,
    Menu_ID int  NOT NULL,
    Product_ID int  NOT NULL,
    Amount int  NOT NULL,
    CONSTRAINT Amount_check CHECK (Amount > 0),
    CONSTRAINT Orders_pk PRIMARY KEY  (Reservation_ID,Menu_ID,Product_ID)
);

-- Table: Product_On_Menu
CREATE TABLE Product_On_Menu (
    Menu_ID int  NOT NULL,
    Product_ID int  NOT NULL,
    DailyAmount int  NOT NULL,
    Price money  NOT NULL,
    CONSTRAINT DailyAmount_Check CHECK (DailyAmount > 0),
    CONSTRAINT Price_Check CHECK (Price > 0),
    CONSTRAINT Product_On_Menu_pk PRIMARY KEY  (Menu_ID,Product_ID)
);

-- Table: Products
CREATE TABLE Products (
    Product_ID int IDENTITY NOT NULL,
    Name varchar(35)  NOT NULL,
    IsSeafood tinyint  NOT NULL,
    CONSTRAINT Name_Check CHECK (Name not like '%[^a-zA-Z ]%'),
    CONSTRAINT IsSeafood_Check CHECK (IsSeafood in (0, 1)),
    CONSTRAINT Products_pk PRIMARY KEY  (Product_ID)
);

-- Table: Reservation_Parameters
CREATE TABLE Reservation_Parameters (
    OrdersAmount int  NOT NULL,
    OrderValue int  NOT NULL,
    CONSTRAINT OrdersAmount_Check CHECK (OrdersAmount > 0),
    CONSTRAINT OrderValue_Check CHECK (OrderValue > 0)
);

-- Table: Reservations
CREATE TABLE Reservations (
    Reservation_ID int  NOT NULL,
    Client_ID int  NOT NULL,
    StartDate datetime  NOT NULL,
    EndDate datetime  NOT NULL,
    DiscountType tinyint  NULL,
    Status tinyint  NOT NULL,
    Invoice_ID varchar(20)  NULL,
    CONSTRAINT Date_Check2 CHECK (StartDate <= EndDate),
    CONSTRAINT DiscountType_Check CHECK (DiscountType in (NULL, 0, 1)),
    CONSTRAINT Status_Check CHECK (Status in (0, 1, 2, 3, 4, 5, 6)),
    CONSTRAINT Reservations_pk PRIMARY KEY  (Reservation_ID)
);

-- Table: Reserved_Tables
CREATE TABLE Reserved_Tables (
    Reservation_ID int  NOT NULL,
    Table_ID int  NOT NULL,
    CONSTRAINT Reserved_Tables_pk PRIMARY KEY  (Reservation_ID,Table_ID)
);

-- Table: Tables
CREATE TABLE Tables (
    Table_ID int  NOT NULL,
    NumberOfChairs int  NOT NULL,
    Active tinyint  NOT NULL,
    CONSTRAINT Active_check CHECK (Active in (0, 1)),
    CONSTRAINT Chairs_check CHECK (NumberOfChairs > 0),
    CONSTRAINT Tables_pk PRIMARY KEY  (Table_ID)
);

-- foreign keys
-- Reference: Client_Discounts_Clients (table: Client_Discounts)
ALTER TABLE Client_Discounts ADD CONSTRAINT Client_Discounts_Clients
    FOREIGN KEY (Client_ID)
    REFERENCES Individual (Client_ID);

-- Reference: Company_Client (table: Company)
ALTER TABLE Company ADD CONSTRAINT Company_Client
    FOREIGN KEY (Client_ID)
    REFERENCES Client (Client_ID);

-- Reference: Individual_Client (table: Individual)
ALTER TABLE Individual ADD CONSTRAINT Individual_Client
    FOREIGN KEY (Client_ID)
    REFERENCES Client (Client_ID);

-- Reference: Menu_Menu_date (table: Product_On_Menu)
ALTER TABLE Product_On_Menu ADD CONSTRAINT Menu_Menu_date
    FOREIGN KEY (Menu_ID)
    REFERENCES Menu (Menu_ID);

-- Reference: Orders_Product_On_Menu (table: Orders)
ALTER TABLE Orders ADD CONSTRAINT Orders_Product_On_Menu
    FOREIGN KEY (Menu_ID,Product_ID)
    REFERENCES Product_On_Menu (Menu_ID,Product_ID);

-- Reference: Orders_Reservations (table: Orders)
ALTER TABLE Orders ADD CONSTRAINT Orders_Reservations
    FOREIGN KEY (Reservation_ID)
    REFERENCES Reservations (Reservation_ID);

-- Reference: Product_On_Menu_Products (table: Product_On_Menu)
ALTER TABLE Product_On_Menu ADD CONSTRAINT Product_On_Menu_Products
    FOREIGN KEY (Product_ID)
    REFERENCES Products (Product_ID);

-- Reference: Reservations_Client (table: Reservations)
ALTER TABLE Reservations ADD CONSTRAINT Reservations_Client
    FOREIGN KEY (Client_ID)
    REFERENCES Client (Client_ID);

-- Reference: Reservations_Invoices (table: Reservations)
ALTER TABLE Reservations ADD CONSTRAINT Reservations_Invoices
    FOREIGN KEY (Invoice_ID)
    REFERENCES Invoices (Invoice_ID);

-- Reference: Reservations_Names (table: Names)
ALTER TABLE Names ADD CONSTRAINT Reservations_Names
    FOREIGN KEY (Reservation_ID)
    REFERENCES Reservations (Reservation_ID);

-- Reference: Reserved_Tables_Reservations (table: Reserved_Tables)
ALTER TABLE Reserved_Tables ADD CONSTRAINT Reserved_Tables_Reservations
    FOREIGN KEY (Reservation_ID)
    REFERENCES Reservations (Reservation_ID);

-- Reference: Reserved_Tables_Tables (table: Reserved_Tables)
ALTER TABLE Reserved_Tables ADD CONSTRAINT Reserved_Tables_Tables
    FOREIGN KEY (Table_ID)
    REFERENCES Tables (Table_ID);
