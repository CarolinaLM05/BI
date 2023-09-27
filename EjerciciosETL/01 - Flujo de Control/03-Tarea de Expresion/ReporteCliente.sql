create database datamart1
go

use datamart1
go

use northwnd
go

select * from customers

select top 0 * 
into datamart1.dbo.dcustomers
from customers

select top 0 * 
into datamart1.dbo.dshippers
from shippers

select top 0 * 
into datamart1.dbo.dorders
from orders

select * 
into datamart1.dbo.dcustomers1
from customers
where 1=0

--Agregar la restricción de primary key a la tabla dcustomers

alter table datamart1.dbo.dcustomers
add constraint pk_dcustomers
primary key (customerId)

-- Agregar la restricción de primary key de la tabla shipper
alter table datamart1.dbo.dshippers
add constraint pk_dshippers
primary key (shipperId)

-- Agregar la restricción de primary key de la tabla orders
alter table datamart1.dbo.dorders
add constraint pk_dorders
primary key (orderid)

-- Agregar la restricción de primary key de la tabla shipper
alter table datamart1.dbo.dshippers
add constraint pk_dshippers
primary key (shipperId)

-- Agregar la restricción de foreign key de la tabla dorders
alter table datamart1.dbo.dorders
add constraint fk_dorders
foreign key (ShipVia)
references datamart1.dbo.dshippers (shipperId)

-- Agregar la restricción de foreign key de la tabla dorders
alter table datamart1.dbo.dorders
add constraint fk_dorders_dcustomers2
foreign key (customerid)
references datamart1.dbo.dcustomers(customerid)

alter table datamart1.dbo.dcustomers
drop constraint fk_dorders_dcustomers


select o.OrderID, o.OrderDate,
o.EmployeeID, e.FullName, c.CompanyName,
c.City,c.Country, od.Quantity, od.UnitPrice, od.Discount,
od.Mount, p.ProductName
from Orders as o
inner join (
	select employeeid, 
    CONCAT(FirstName,' ',LastName) 
    as FullName 
    from Employees  
)as e
on o.EmployeeID = e.EmployeeID
inner join (
select CompanyName, City, Country, CustomerID 
from customers 
) as c
on o.CustomerID=c.CustomerID
inner join (
  select UnitPrice, Quantity, Discount, 
  (UnitPrice*Quantity) as
  Mount, OrderID, ProductID
 from [Order Details]
) as od
on o.OrderID = od.OrderID
inner join (
   select ProductID, ProductName from Products
)as p
on od.ProductID = p.ProductID
go
-- Crear la vista de reporte de ventas
create view ReporteVentas1
as 
select o.OrderID, o.OrderDate,
o.EmployeeID, e.FullName, c.CompanyName,
c.City,c.Country, od.Quantity, od.UnitPrice, od.Discount,
od.Mount, p.ProductName
from Orders as o
inner join (
	select employeeid, 
    CONCAT(FirstName,' ',LastName) 
    as FullName 
    from Employees  
)as e
on o.EmployeeID = e.EmployeeID
inner join (
select CompanyName, City, Country, CustomerID 
from customers 
) as c
on o.CustomerID=c.CustomerID
inner join (
  select UnitPrice, Quantity, Discount, 
  (UnitPrice*Quantity) as
  Mount, OrderID, ProductID
 from [Order Details]
) as od
on o.OrderID = od.OrderID
inner join (
   select ProductID, ProductName from Products
)as p
on od.ProductID = p.ProductID


select * from ReporteVentas
where ProductName = 'Queso Cabrales'




truncate table dorders
delete from dcustomers
delete from dshippers


