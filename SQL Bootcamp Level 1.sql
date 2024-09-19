--session 1

SELECT * FROM Customer c ;
SELECT 4+2;
SELECT SQRT(25) ;
--this is a comment
/* this is another way to insert a comment */

SELECT FirstName, LastName from Customer c ;
SELECT firstname, lastname from Customer c limit 5;

SELECT * from Customer c 
limit 5;
-- displaus only 5 rows from the customer table

SELECT * from Customer c 
order by CustomerId DESC 
limit 5;
-- shows last five now

SELECT Title as JobTitle FROM Employee;
--set an alias for title to jobtitle

SELECT Title as 'Job Title' FROM Employee;
--quotations if you want column name to include any sql function words or spaces

--display the entire record (entire row) for the employee whose ID number is 1
SELECT * from Employee e 
where EmployeeId = 1;
SELECT * from Employee e 
where EmployeeId is 1;

--display the entire record (entire row) for the employee whose ID number is NOT 1
SELECT * from Employee e 
where EmployeeId != 1;
-- is not OR != both WORK 

SELECT * from Employee e 
where EmployeeId != 1 and EmployeeId != 2 and EmployeeId != 3;

SELECT * from Customer c 
where CustomerId > 1 and CustomerId <= 20;

SELECT * from Employee e;

select * from Employee e where title like 'Sales%';
-- shows anyone who has word sales in their job title, % used to find anything that has 1st 5 letters as sales and anything else after it 

SELECT * from Employee e where title like 'sales manager';

SELECT * from Employee e where title like '%Agent';

SELECT * from Employee e where title like '%Agent%';
-- shows titles with agent at front, middle, end, anywhere in the title

SELECT * from Employee e where FirstName like '__r%';
--shows employees with firstname whose third character is r, so 2 underscores before r and % after 

--DISTINCT removes duplicates
SELECT * from Customer c ;
SELECT DISTINCT country from Customer c ;

--not in 
--fetch the details for all customers who are not 'johannes', 'luis', and 'joakim'
SELECT * from Customer c where FirstName not in ('Johannes', 'Luis', 'Joakim');

--between is inclusive
SELECT * from Customer c where CustomerId BETWEEN 2 and 20;

--NULL values are empty in the table, not 0; dont use '=' use 'is'
SELECT * from Customer c where Company is NULL ;
SELECT * from Invoice i where billingstate is NULL ;
SELECT * from Invoice i where billingstate ISNULL ;
SELECT * from Invoice i where BillingState is not null;

SELECT * from Customer c;
SELECT count(*) from Customer c ;
-- counts number of rows in table;

SELECT sum(Total) from Invoice i ;
--adds up all rows to give a total of total column

SELECT count(*), sum(total) from Invoice i ;
-- use comma to show multiple values;
SELECT count(*) as InvoiceCount, sum(total) as InvoiceDollar from Invoice i ;

--rounding total to 0 decimal places
SELECT round(sum(total),0) as invoicedollar from Invoice i ;

--display the average of the invoices that were issued in 2007
SELECT round(AVG(total),2) from Invoice i where InvoiceDate like '2007%' ; -- use like because date formatted with month and day after YEAR

SELECT * from Invoice i ;

SELECT max(total) from Invoice i ;

SELECT * from Invoice i ;
SELECT * from Invoice i where InvoiceDate like '2007%';
SELECT * from Invoice i where SUBSTRING(InvoiceDate,1,4) = '2007';

SELECT CustomerId, SUBSTRING(InvoiceDate ,1,4) from Invoice i;

--group by
--count how many employees report to each manager
SELECT ReportsTo , count(*) from Employee e group by ReportsTo; 

SELECT reportsto from Employee e ;

--display number of customers that live in each country
SELECT country, count(*) from customer group by country;

--get total song duration and size of album in bytes of each album, 
SELECT * from Track t  ;
SELECT albumid, sum(milliseconds), sum(bytes) from Track t group by AlbumId ;

--order by
SELECT * from Employee e 
order by city ASC ;

SELECT country, count(country) from Customer c group by Country order by count(*) desc;
--count(*) is same as count(country) here I believe because of group by;

--having clause, similar to where, but used to filter aggregated/calculation DATA 
--where used for raw data like column names 
SELECT country, count(*) from Customer c 
group by Country
having count(*) > 5
order by count(*) desc;

SELECT reportsto, count(*) from Employee e 
group by ReportsTo 
having count(*) > 2;


--display total revenue in each country but only countries with revenue more than 
SELECT * from Invoice i ;
SELECT BillingCountry, sum(total) from Invoice i 
group by BillingCountry 
having sum(total) > 100;

SELECT BillingCountry, sum(total) from Invoice i 
where BillingCountry like 'U%'
group by BillingCountry 
having sum(total) > 100 ;

--inner joins, combines 2 tables together if they have a same column 
SELECT * from Track t ;
SELECT * from Genre g ;
SELECT * from Track t 
inner join Genre g on t.GenreId = g.GenreId;

