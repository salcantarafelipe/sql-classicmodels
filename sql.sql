-- 1. Write an SQL query to fetch unique values of “city” from “customers” table using the alias name as “CUSTOMER_CITY”.
select distinct city as CUSTOMER_CITY 
from customers;

-- 2.Write an SQL query to print all details of employees, excluding those with first names “Gerard” and 'Mary'.
select * from employees where firstName not in ('Mary','Gerard');

-- 3.Write an SQL query to print full name as concatenation of first and last name of employees whose last name ends with ‘n’
select concat(firstName,lastName) from employees where lastName like '%n';

-- 4. Write an SQL query to print all details of all employees located in offices within territory “EMEA”.
select * from employees e left join offices o 
on e.officeCode = o.officeCode
where o.territory = 'EMEA';

-- 5. Write an SQL query to fetch the no. of employees for each territory. Sort by no. of employees in the descending order.
select count(e.employeeNumber), o.territory from employees e left join offices o 
on e.officeCode = o.officeCode
group by o.territory
order by count(e.employeeNumber) desc;

-- 6. Write an SQL query to print “productName” from “products” table next to the corresponding “textDescription” with alias “productLine” from the “productlines” table order by “productLine” Ascending and “productName” Descending.
select p.productName, pl.textDescription as productLine from products p left join productlines pl
on p.productLine = pl.productLine
order by pl.textDescription asc, p.productName desc ;

-- 7. Write an SQL query to print top 5 products with highest total quantity sold in April, 2005. Quantities should also be displayed.
select p.productName, sum(od.quantityOrdered) from orders o 
left join orderdetails od
on o.orderNumber = od.orderNumber
left join products p
on p.productCode = od.productCode
where month(o.orderDate) = 4
and year(o.orderDate) = 2005
group by p.productName
order by sum(od.quantityOrdered) desc
limit 5;

-- 8. Write an SQL query to print total revenue (calculated as “quantityOrdered” * “priceEach”) along with product names for all products in the database, including those where no sales were registered (display revenue as 0 in such cases).
select 
p.productName, 
od.priceEach, 
od.quantityOrdered,
coalesce((od.quantityOrdered * od.priceEach),0) as total_revenue
 from orderdetails od
 left join products p
on od.productCode = p.productCode
union
select 
p.productName, 
od.priceEach, 
od.quantityOrdered,
coalesce((od.quantityOrdered * od.priceEach),0) as total_revenue
from orderdetails od
right join products p
on od.productCode = p.productCode




