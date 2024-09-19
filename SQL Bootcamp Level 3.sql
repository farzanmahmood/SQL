-- session 3 feb 9
select cast (25.65 as varchar);

select firstname, 2022-cast(hiredate as int) as TimeWorking
from Employee e ;

---dates---
select date('now');

--compute last day of current month
select date('now','start of month', '+1 month', '-1 day') as LastDay

--compute date and time given a unix timestamp '1193961488'
select datetime(1193961488, 'unixepoch');

--compute current timestamp in unixepoch, %s means 'to the second'
select STRFTIME('%s'); 

select DATETIME(1675985554,'unixepoch', 'localtime'); 

--compute number of days since I was born
select round (julianday('now')-julianday('1999-05-02')) as sincebirth;

--calculate total invoices by years
select STRFTIME('%Y', invoicedate) invoiceyear, sum(invoiceid) invoiceamount
from Invoice i group by invoiceyear
order by invoiceyear;

--select STRFTIME('%Y', invoicedate) invoiceyear
--from Invoice i 
--group by STRFTIME('%Y',InvoiceDate) 
--order by invoiceyear;

--DML: Data manipulation language
--DDL: Data definition language

--creating empty database
create table Customers (
CustomerId Integer Not Null Primary Key,
Name text,
Segment text,
City text,
State Text,
PostalCode text,
Region text); 

create table Orders (
OrderId Varchar(20) not null primary key,
OrderDate Date not null,
Sales decimal (6,2),
Quantity int not null,
Cust_ID int not null references Customers (CustomerId),
Product_ID integer not null references Products (Product_ID)
);

create table Products(
Product_ID integer not null primary key,
Category varchar(50) not null,
Sub_Category text not null
);

------- now populate the tables-----

INSERT INTO Customers
(CustomerId, Name, Segment, City, State, PostalCode, Region)
VALUES
(12520,'Claire Gute', 'Consumer', 'Henderson', 'Kentucky', '42420', 'South'),
(13045,'Darrin Van Huff','Corporate','Los Angeles','California','90036','West'),
(20335,'Sean ODonnell','Consumer','Fort Lauderdale','Florida','33311','South'),
(11710,'Brosina Hoffman','Consumer','Los Angeles','California','90032','West'),
(10480,'Andrew Allen','Consumer','Concord','North Carolina','28027','South'),
(15070,'Irene Maddox','Consumer','Seattle','Washington','98103','West'),
(14815, 'Harold Pawlan ', 'Home Office', 'Fort Worth' ,' Texas' , '76106 ',' Central'),
(13868, 'Darrin Van Huff', 'Corporate', NULL, 'California',  '90036', 'West');


INSERT INTO Orders
(OrderID,OrderDate,Sales,Quantity,Cust_ID,Product_ID)
VALUES
('2019-145317',    '3/18/2019',  	22638.48,   6,  	12520,  	'FUR-BO-10001798'),
('2021-118689',    '10/2/2022', 	17499.95,   5,	12520,  	'FUR-CH-10000454'),
('2022-140151',   '3/23/2022',  	13999.96,   4,  	13045,  	'OFF-LA-10000240'),
('2022-127180',   '10/22/2022', 	11199.97,   4,  	20335,  	'FUR-TA-10000577'),
('2022-166709',   '11/17/2022', 	10499.97,   3,  	20335,  	'OFF-ST-10000760'),
('2021-117121',   '12/17/2021', 	9892.74,     13,  11710,  	'FUR-FU-10001487'),
('2019-116904',   '9/23/2019',  	9449.95,      5,  	11710,  	'OFF-AR-10002833');


INSERT INTO Products 
(Product_ID,Category,Sub_Category)
VALUES 
(10001798,'Furniture','Bookcases');

INSERT INTO Products
VALUES
(10002640,'Technology','Phones'),
(10000240,'Office Supplies','Labels'),
(10000577,'Furniture','Tables'),
(10000760,'Office Supplies','Storage'),
(10000562,'Technology','Phones');

select * from Customers c ;
select * from Products p ;

create table People (
CustomerId integer not null primary key,
Name text,
Segment text,
City text,
State text,
PostalCode text,
Region text,
Age integer,
Check (Age >=18)
);

select * from People ;

insert into People 
(CustomerId, Name, Segment, City, State, PostalCode, Region, Age)
Values
(12933, 'Joseph Steve', 'Consumer', 'Toronto', 'Ontario','5420','South',19);

--Unique contrain

create table Orders1 (
OrderId Varchar(20) not null primary key,
OrderDate Date not null,
Sales decimal (6,2),
Quantity int not null,
CustomerID int not null references Customers (CustomerId),
ProductID int not null references Products (Product_ID),
unique (OrderId)
);

alter table Products 
add column Observations text;

select * from Products p ;

alter table Products 
drop Observations;

alter table Products 
rename column Sub_Category to CategoryDesc;

-- review case from notes














