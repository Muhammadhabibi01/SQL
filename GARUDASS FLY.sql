create database GARUDAFLYE

use GARUDAFLYE

create schema schFLYGARUDA
select * from sys.schemas


create table airline
(
   idairline varchar(50) not null,
   name varchar(50),
   CONSTRAINT PK_airline PRIMARY KEY (idairline)
)

insert into airline (idairline,name) values ('GA-R01','Imam Abdul Hamid')
insert into airline (idairline,name) values ('GA-R09','Amri Hasbullah')
insert into airline (idairline,name) values ('GA-R07','Susi Susanti')
insert into airline (idairline,name) values ('GA-RO7','Ihsan Haris')

select * from airline

create table voucher
(
	idvoucher varchar(25) not null,
	idroute varchar(50),
	voucher numeric(18,0),
	Constraint PK_voucher Primary Key (idvoucher)
)

insert into voucher values ('Free01','GA-R01','250000')
insert into voucher values ('Free02','GA-R07','250000')
insert into voucher values ('Free03','GA-R09','250000')
insert into voucher values ('Free04','GA-R017','250000')

select*from voucher

create table payment
(
   idpayment varchar(50) not null,
   idvoucher varchar(25),
   idroute varchar(50),
   idcustomer numeric(18,0),
   total numeric(18,0),
   voucher numeric(18,0),
   total_price numeric(18,0),
   status_payment varchar(50),
   date_payment date,
   limit_date_payment date,
   Constraint PK_idpayment Primary Key (idpayment)
)
insert into payment(idpayment,idvoucher,idroute,idcustomer,total,voucher,total_price,status_payment,date_payment,limit_date_payment) values ('1','Free01','GA-R01','1','1250000','250000','1000000','CASH','2019-05-28','2019-05-29')
insert into payment(idpayment,idvoucher,idroute,idcustomer,total,voucher,total_price,status_payment,date_payment,limit_date_payment) values ('2','Free02','GA-R09','3','1250000','250000','1000000','CASH','2019-05-26','2019-05-27')
insert into payment(idpayment,idvoucher,idroute,idcustomer,total,voucher,total_price,status_payment,date_payment,limit_date_payment) values ('3','Free03','GA-R07','5','1250000','250000','1000000','TRANFER','2019-05-23','2019-05-24')
insert into payment(idpayment,idvoucher,idroute,idcustomer,total,voucher,total_price,status_payment,date_payment,limit_date_payment) values ('4','Free04','GA-R07','16','1250000','250000','1000000','TRANFER','2019-05-22','2019-05-24')

select*from payment

create table class
(
    idclass varchar(50) not null,
	class varchar(50),
	Constraint PK_idclass Primary key (idclass)
)

insert into class(idclass,class) values ('0011','ekonomi')
insert into class(idclass,class) values ('0013','bisnis')
insert into class(idclass,class) values ('0014','first class')

select*from class

create table employee
(
  idemployee numeric(18,0) not null,
  name varchar(50),
  position varchar(50),
  salary numeric(18,0),
  Constraint PK_idemployee Primary Key (idemployee)
)

insert into employee(idemployee,name,position,salary) values ('1','Amri Hasbullah','employee','1750000')
insert into employee(idemployee,name,position,salary) values ('2','Susi Susanti','employee','1750000')
insert into employee(idemployee,name,position,salary) values ('3','Ihsan Haris','employee','1750000')
insert into employee(idemployee,name,position,salary) values ('4','Fathur Rahman','employee','1750000')
insert into employee(idemployee,name,position,salary) values ('5','Ramadhani','employee','1750000')

select*from employee

create table customer1
(
  idcustomer numeric(18,0) not null,
  idroute varchar(50),
  idemployee numeric(18,0),
  name varchar(50),
  no_telephone varchar(50),
  age numeric(18, 0),
  date_depart date,
  information varchar(50),
  Constraint PK_idcustomer Primary Key (idcustomer)
)

insert into customer1(idcustomer,idroute,idemployee,name,no_telephone,age,date_depart) values ('1','GA-R01','1','Iman Abdul Hamid','0857112890','19','2019-05-28')
insert into customer1(idcustomer,idroute,idemployee,name,no_telephone,age,date_depart) values ('3','GA-R09','4','Amri Hasbullah','0867488892','20','2019-05-29')
insert into customer1(idcustomer,idroute,idemployee,name,no_telephone,age,date_depart) values ('5','GA-R07','3','Susi Susanti','086782920393','20','2019-05-29')
insert into customer1(idcustomer,idroute,idemployee,name,no_telephone,age,date_depart) values('16','GA-RO7','3','Ihsan Haris','086783938882','19','2019-05-30')
 
 select*from customer1

create table route
(
  idroute varchar(50) not null,
  idairline varchar(50),
  home_town varchar(50),
  destination_city varchar(50),
  departure_time varchar(50),
  arrived_time varchar(50),
  class varchar(50),
  price numeric(18,0),
  remaining_capacity numeric(18,0),
  Constraint PK_idroute Primary Key (idroute)
) 

insert into route(idroute,idairline,home_town,destination_city,departure_time,arrived_time,class,price,remaining_capacity) values ('GA-R01','GA-R01','jakarta','medan','07.00','09.00','bisnis','1250000','20')
insert into route(idroute,idairline,home_town,destination_city,departure_time,arrived_time,class,price,remaining_capacity) values ('GA-R09','GA-R09','jakarta','medan','08.00','10.00','bisnis','1250000','20')
insert into route(idroute,idairline,home_town,destination_city,departure_time,arrived_time,class,price,remaining_capacity) values ('GA-R07','GA-R07','medan','bali','09.00','11.00','ekonomi','1250000','19')
insert into route(idroute,idairline,home_town,destination_city,departure_time,arrived_time,class,price,remaining_capacity) values ('GA-RO7','GA-R08','bali','jakarta','05.00','08.00','bisnis','1250000','9')

select * from airline
select * from customer1
select * from employee
select * from route
select * from payment
select * from class
select * from voucher
 
 
 ---- trigger potongan harga-----
 
Create trigger tr_insertprice on voucher
after insert
as
begin
	declare @voucher numeric(18,0), @IdR varchar(50)
	select @voucher = voucher, @IdR = idroute
	from inserted
	update route set price = price - @voucher
	where idroute = @IdR
end

insert into route(idroute,idairline,home_town,destination_city,departure_time,arrived_time,class,price,remaining_capacity) values ('GA-R01','GA-R01','jakarta','medan','07.00','09.00','bisnis','1250000','20')
insert into route(idroute,idairline,home_town,destination_city,departure_time,arrived_time,class,price,remaining_capacity) values ('GA-R09','GA-R09','jakarta','medan','08.00','10.00','bisnis','1250000','20')
insert into route(idroute,idairline,home_town,destination_city,departure_time,arrived_time,class,price,remaining_capacity) values ('GA-R07','GA-R07','medan','bali','09.00','11.00','ekonomi','1250000','19')
insert into route(idroute,idairline,home_town,destination_city,departure_time,arrived_time,class,price,remaining_capacity) values ('GA-RO7','GA-R08','bali','jakarta','05.00','08.00','bisnis','1250000','9')

---insert---
insert into voucher values ('Free01','GA-R01','250000')
insert into voucher values ('Free02','GA-R07','250000')
insert into voucher values ('Free03','GA-R09','250000')
insert into voucher values ('Free04','GA-R017','250000')

---Select---
Select * From route
Select * From voucher

---Trigger Update---

Create Trigger Tr_updateprice on voucher
after update
as
begin
		declare @IdR varchar(50), @voucher numeric(18,0), @voucherlama int
		select @voucher = voucher, @IdR = idroute from inserted

		select @voucherlama = voucher
		from deleted

		update route set price = price - @voucherlama - @voucher
		where idroute = @IdR
end

update voucher set voucher = '100000' where idvoucher = 'Free01'

---Trigger Delete---
Create Trigger Tr_deletevchr on voucher
after delete



------ TRIGGER INSERT----
create trigger tambahclass
on class
after insert
as 
begin
	print 'DATA CLASS BERHASIL DITAMBAHKAN'
end

drop trigger tambahclass

create trigger tambahairline
on airline
after insert
as 
begin
	print 'DATA AIRLINE BERHASIL DITAMBAHKAN'
end

drop trigger tambahairline

create trigger tambahvoucher
on voucher
after insert
as 
begin
	print 'DATA Voucher BERHASIL DITAMBAHKAN'
end

drop trigger tambahvoucher


----- TRIGGER DELETE-----

create trigger hapusclass
on class
after delete
as
begin
	print 'DATA CLASS BERHASIL DIHAPUS'
end

create trigger hapusairline
on airline
after delete
as
begin
	print 'DATA AIRLINE BERHASIL DIHAPUS'
end

create trigger hapusvoucher
on voucher
after delete
as
begin
	print 'DATA VOUCHER BERHASIL DIHAPUS'
end


---- TRIGGER Update-----

create trigger perbaruiclass
on class
after update
as
begin
	print 'DATA CLASS BERHASIL DIPERBARUI'
end

create trigger perbaruiairline
on airline
after update
as
begin
	print 'DATA AIRLINE  PERBARUI'
end

create trigger perbaruivoucher
on voucher
after update
as
begin
	print 'DATA VOUCHER BERHASIL DIPERBARUI'
end

---- TRIGGER VOUCHER-----
select * from payment

create procedure prcairline
(
   @idairline varchar(50),
   @name varchar(50)
)
as
	begin
		insert into airline values (@idairline, @name)
end

exec prcairline @idairline = 'GA-R06',@name= 'Agus'
select * from airline


----Procedure Update airline----
create procedure Updateemployee
(
  @idemployee numeric(18,0),
  @name varchar(50),
  @position varchar(50),
  @salary numeric(18,0)
)
as
begin
	update employee set name = @name, position = @position, salary = @salary
	where idemployee = @idemployee
end
exec Updateemployee 1,'Amri Hasbullah','employee','2000000'
select * from employee

----Procedure Delete airline----
create procedure Deleteairline
@idairline varchar(50)
as
Delete from airline where @idairline = idairline

exec Deleteairline @idairline ='GA-R01'
select * from airline


----- store procedure-----
Create Procedure Tampilkanemployee
AS
BEGIN
	SELECT*FROM employee
END

exec Tampilkanemployee

Alter Procedure Tampilkanemployee
AS
BEGIN
	SELECT idemployee, name, position, salary from employee
END

Drop Procedure Tampilkanemployee

------ JOINT-----

SELECT *
FROM customer1
JOIN airline ON airline.name = customer1.name

SELECT *
FROM customer1
INNER JOIN airline ON airline.name = customer1.name

SELECT *
FROM customer1
LEFT JOIN airline ON airline.name = customer1.name