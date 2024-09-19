--1. List the details for all orders for the customer named "Charlie" that contained sales for the item "Apples"
select o.* from orders o inner join Customer c
on o.CustId = c.CustId inner join SaleItem s
on o.OrderNo = s.OrderNo inner join Item i
on s.ItemId = i.ItemId
where c.CustName = 'Charlie' and i.ItemDesc = 'Apples';

--2. List the order no. for orders that have placed more than 2 sale items in 2022
select o.OrderNo from SaleItem s inner join orders o
on s.OrderNo = o.OrderNo
where YEAR(o.OrderDate) = 2022
group by o.OrderNo
having count(o.orderno) > 2;

--3. List the customers details for customers who have placed  orders items in the "Fruit" (FR)  or "Vegetable" (VG) catgeory in 2022. Show each customer only once
select distinct c.* from orders o inner join Customer c
on o.CustId = c.CustId inner join SaleItem s
on o.OrderNo = s.OrderNo inner join Item i
on s.ItemId = i.ItemId
where (ItemCategory = 'FR' or ItemCategory = 'VG') and YEAR(OrderDate) = 2022;

--4.  List the id , description and category of items where the QOH is less than the reorder level.  Sequence by item id within category
select ItemId, ItemDesc, ItemCategory from Item
where QtyOnHand < ReOrderLevel
order by ItemCategory, ItemId;

--5.  List the details for the items that have been sold at a discount on any order (Where the sale price less than list price).
select distinct i.* from item i inner join SaleItem s
on i.ItemId = s.ItemId
where SalePrice < ItemListPrice;

--6.  List the details for all customers that have ordered items with characters "Bananas" anywhere in its description. 
select distinct c.* from orders o inner join Customer c
on o.CustId = c.CustId inner join SaleItem s
on o.OrderNo = s.OrderNo inner join Item i
on s.ItemId = i.ItemId
where ItemDesc like '%Bananas%';

--7.  List the maximum quantity on hand for any item in the "Fruit" (FR) category
select max(QtyOnHand) as 'Max Fruit QtyOnHand' from item
where ItemCategory = 'FR';

--8.  List the total quantity sold for the item with the description "Green Bananas" in Ontario in 2022
select sum(QtySold) as 'Total Green Bananas Sold in ON in 2022' from orders o inner join Customer c
on o.CustId = c.CustId inner join SaleItem s
on o.OrderNo = s.OrderNo inner join Item i
on s.ItemId = i.ItemId
where ItemDesc = 'Green Bananas' and Prov = 'ON' and year(OrderDate) = 2022;

--9.  List the item details for all sold items in 2019 Sequence the output by item description. 
select distinct i.* from orders o inner join SaleItem s
on o.OrderNo = s.OrderNo inner join Item i
on s.ItemId = i.ItemId
where year(OrderDate) = 2019
order by ItemDesc;

--10.  Count the number of times an item in the vegetable (VG) category has appeared on an order in 2022
select count(*) as '# of Orders with Vegetables in 2022' from item i inner join SaleItem s
on s.ItemId = i.ItemId inner join Orders o
on s.OrderNo = o.OrderNo
where ItemCategory = 'VG' and year(OrderDate) = 2022;

--11.  Count the number of different item categories represented by sales in Quebec in August 2019
select count(distinct ItemCategory) as '# of Item Categories represented by sales in QC in Aug. 2019' from orders o inner join Customer c
on o.CustId = c.CustId inner join SaleItem s
on o.OrderNo = s.OrderNo inner join Item i
on s.ItemId = i.ItemId
where Prov = 'QC' and (year(OrderDate) = 2019 and month(OrderDate) = 08);

--12.  List the details for the customers that purchased the item "Broccoli" in 2022. Show each customer only once and sequence alphabetically by customer name
select distinct c.* from orders o inner join Customer c
on o.CustId = c.CustId inner join SaleItem s
on o.OrderNo = s.OrderNo inner join Item i
on s.ItemId = i.ItemId
where ItemDesc = 'Broccoli' and year(OrderDate) = 2022
order by CustName;

--13. List for each item by item id, the highest sale value (sale price * qty sold ) appearing on any order.
select s.itemid, max(saleprice*qtysold) as 'Highest Single Sale Order' from SaleItem s inner join item i
on s.ItemId = i.ItemId
group by s.ItemId;

--14. List the total value of sales (sale price * qty sold) for each item category in 2022. Order the output by greatest value to lowest value
select ItemCategory, sum(saleprice*qtysold) as 'Total Sales in 2022' from item i inner join SaleItem s
on s.ItemId = i.ItemId inner join Orders o
on s.OrderNo = o.OrderNo
where year(OrderDate) = 2022
group by ItemCategory
order by sum(saleprice*qtysold);

--15. List the customer id for the Ontario customers that have placed  2 or more orders in 2022
select c.CustId from Customer c inner join orders o
on c.CustId = o.CustId
where prov = 'ON' and year(OrderDate) = 2022
group by c.CustId
having count(c.custid) > 1;

--16. List in alphabetic sequence by item description the details of any items ordered by the customer named "Jones".  Show each item only once
select distinct i.* from orders o inner join Customer c
on o.CustId = c.CustId inner join SaleItem s
on o.OrderNo = s.OrderNo inner join Item i
on s.ItemId = i.ItemId
where CustName = 'Jones'
order by ItemDesc;

--17. List the customer details for those customers who have bought broccoli in 2022  and  who reside in either Ontario or Quebec
select distinct c.* from orders o inner join Customer c
on o.CustId = c.CustId inner join SaleItem s
on o.OrderNo = s.OrderNo inner join Item i
on s.ItemId = i.ItemId
where ItemDesc = 'Broccoli' and year(orderdate) = 2022 and (Prov = 'ON' or Prov = 'QC'); 

--18. Show by item id the total value (sale price * qty sold) for each sale item in August 2022 where that item appeared on at least 2 orders in that same time period
select i.ItemId, sum(saleprice*qtysold) as 'Total Sales in August 2022' from SaleItem s inner join Item i 
on s.ItemId = i.ItemId inner join orders o
on s.OrderNo = o.OrderNo
where year(orderdate) = 2022 and month(orderdate) = 08
group by i.itemid
having count(i.itemid) > 1;

--19. List the total inventory value (item cost  * qty on hand ) for each item in the "VG" category 
select ItemDesc, (itemcost*qtyonhand) as 'Total Inventory Value' from Item
where ItemCategory = 'VG';

--20. Write the following commands. I must be able to test run i), ii) and iii) below in sequence.

--20 a). Add a new item to the database 
insert into Item
(ItemId, ItemDesc, ItemCategory, ItemListPrice, QtyOnHand, ReOrderLevel, ItemCost)
Values ('0011', 'Potatoes', 'VG', 5.00, 150, 50, 2.50);

--20 b). Update the qtyonhand by adding 50 new units (Use a formula. Don't directly hard code the new value)
update Item
set QtyOnHand = (QtyOnHand + 50)
where ItemId = '0011';

--20 c) Delete the item
delete from Item
where ItemId = '0011';

--Note: I must be able to test run i), ii) and iii) above in sequence.
