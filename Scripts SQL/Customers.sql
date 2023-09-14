-- Seleccionar los datos de la tabla customers
select * from Customers
go

-- Actualizar la tabla customers donde su
-- CustomerId = 'ALFKI'

select * from Customers
where CustomerID='ALFKI'
go

update Customers
set Country='France'
where CustomerID='ALFKI'
go

-- Consulta selecciona el customerId de los customers
-- del pais francia y el nombre de contacto Maria Anders

Select CustomerId from Customers
where Country='France' and ContactName='Maria Anders'