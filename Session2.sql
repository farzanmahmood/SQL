--Session 2;

--Create view, use "drop view view_name" to delete and remake
Create View v_customer AS 
Select CustomerId, FirstName, LastName, Country
From Customer c 
Limit 5;

Create view v_invoice AS
Select CustomerId, InvoiceId, Total
From Invoice i ;

--concatenate strings ||
create View CanadaCustomer As
Select (FirstName || ' ' || LastName) As CustomerName, City
From Customer c 
Where Country = "Canada";

Select * from CanadaCustomer cc ;

Drop view CanadaCustomer ;

Create view v_CanadaCustomer As
Select (FirstName || ' ' || LastName) As CustomerName, City
From Customer c 
Where Country = "Canada";

Select * from v_CanadaCustomer vcc ;

Create view v_MediaType As
select Mediatypeid, Name
From MediaType mt ;
drop view v_Media ;

Select * from v_MediaType vmt ;

select * from Customer c 
Inner Join Invoice i On c.CustomerId = i.InvoiceId ;

select * from v_customer vc inner join v_invoice vi on vc.CustomerId = vi.InvoiceId ;

--List the number that have more than 5 invoices
select c.lastname, count(i.invoiceid) as NumberofInvoices
from Invoice i inner join Customer c on i.CustomerId = c.CustomerId 
group by lastname having count(i.InvoiceId) > 5;

--List customer from canada, USA, brazil, have 5 or more invoices
select c.lastname, i.billingCountry, count(i.InvoiceId) as NumberofInvoice
from Invoice i inner join Customer c on i.CustomerId = c.CustomerId 
where BillingCountry in ('Canada', 'USA', 'Brazil')
group by lastname having count(i.InvoiceId) > 5;


--Find the total number of invoices for each customer along with the customers full name and country
SELECT FirstName, LastName, Country, count(vi.customerid) as invoices
from v_customer vc inner join v_invoice vi on vc.CustomerId = vi.CustomerId 
group by vc.CustomerId ;

--retrieve the track name, album, artist and track id for all albums
select t.name, Artist.name as Artist, Album.title as Album, t.trackid
from track t inner join Album ON t.AlbumId = Album.AlbumId 
INNER join Artist on Artist.ArtistId = Album.ArtistId;  

--left join clause
select * from v_customer vc 
left join v_invoice vi on vc.CustomerId = vi.CustomerId;

--find the total number of invoices for each customer along with their full name and country
select firstname, lastname, country, count(vi.customerid) as invoices
from v_customer vc left join v_invoice vi on vc.CustomerId = vi.CustomerId 
group by vc.CustomerId ;

--find names of all tracks for the album californication
select t.name, a.albumid from Track t 
left join Album a on t.AlbumId = a.AlbumId 
where Title = ("Californication");

--cross join 
select * from v_customer vc 
cross join v_invoice vi ; 

--group by, list the number of invoices by media type and media name
select t.mediatypeid, mt.name, count(il.invoiceLineId) as NoInvoices
from Track t 
join InvoiceLine il on t.TrackId = il.TrackId 
join MediaType mt on t.MediaTypeId = mt.MediaTypeId 
group by t.MediaTypeId ;

--list the album id, album title, max duration, min duration and
--average duration of tracks in the tracks TABLE 
select t.albumid, a.title, min(milliseconds), max(milliseconds),
round(AVG(milliseconds),2) 
from Track t inner join Album a on a.AlbumId = t.AlbumId 
group by t.AlbumId ;

--union clause
SELECT firstname, lastname from Employee e 
union select firstname, lastname from Customer c 
order by LastName DESC ;

SELECT firstname, lastname, 'employee' as 'Employee/Customer'
from Employee e 
union
select FirstName , LastName , 'customer' as 'Employee/Customer'
from Customer c 
order by LastName desc;

-- create list of all aristIds and album title and names from the artist table, order by artist
SELECT artistid, title
from Album a 
union
select ArtistId , name
from Artist a2 
order by ArtistId ;

--union all, create list of all artist ids and album title and artist names
select artistid, title from Album a 
union all select artistid, name from artist 
order by artistid; 

--subqueries
--write a query to return the genre that starts with 'r' and has an ID greater than 6
SELECT genrename.*
from (select * from genre where name like 'r%') as GenreName
where GenreName.genreId > 6;

--return a list of all artists that contains 'the' in it
select names_the.*
from (select name from artist where name like '%the%') as names_the;

--select the names of the 10 oldest employees
select firstname, lastname, birthdate
from Employee  
where birthdate in (select birthdate from Employee order by birthdate limit 10);

--find percentage of revenue by country, show higher to LOWER
select billingcountry,
(sum(total)/(select sum(total) from invoice))*100 as revenueperct
from Invoice  
group by BillingCountry 
order by revenueperct desc;

--subqueries within the where STATEMENT
--write a query where you return all info from the employee table
--where hiring date is limited to 5 dates
--then order by date the employee is hired

select * from Employee e 
where HireDate in (SELECT HireDate from Employee order by HireDate limit 5);

--return the info of employees that are managers
select employeeid, firstname, lastname
from Employee e 
where EmployeeId in (select distinct reportsto from Employee )




