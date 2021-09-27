--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--������������ �����: ������� ������ ���� ��������� � ������������� � ��������� ���� �������� (pc, printer, laptop). �������: model, maker, type

select product.model, product.maker, product.type
from product join laptop on product.model = laptop.model
union
select product.model, product.maker, product.type
from product join pc on product.model = pc.model
union
select product.model, product.maker, product.type
from product join printer on product.model = printer.model


--task14 (lesson3)
--������������ �����: ��� ������ ���� �������� �� ������� printer ������������� ������� ��� ���, � ���� ���� ����� ������� PC - "1", � ��������� - "0"

select *,
case
    when price > (select avg(price) from pc)
    then 1
    else 0
end flag
from printer

--task15 (lesson3)
--�������: ������� ������ ��������, � ������� class ����������� (IS NULL)

select *
from ships
where class is null


--task17 (lesson3)
--�������: ������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships. 

select name
from ships
where class = 'Kongo'


--task1  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_300) ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ > 300. �� view ��� �������: model, price, flag


create or replace view all_products_flag_300_second_stream as
select product.model, pc.price
from pc join product on pc.model = product.model where price > 300 
union 
select product.model, printer.price
from printer join product on printer.model = product.model where price > 300
union
select product.model, laptop.price
from laptop join product on laptop.model = product.model where price > 300


--task2  (lesson4)
-- ������������ �����: ������� view (��������: pc_with_flag_speed_price) ��� �������� PC c ������: flag = 1 ��� ���, � ���� speed > 500 � price < 900, ��� ��������� flag = 0

create or replace view pc_with_flag_speed_price_second_stream as
select *, 
case 
	when speed > 500 and price < 900
	then 1
	else 0
end flag 
from pc

  
--task2  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_avg_price) ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ c������ . �� view ��� �������: model, price, flag

create or replace view all_products_flag_avg_price_second_stream as
select product.model, pc.price
from pc join product on pc.model = product.model where price > (select avg(price) from pc)
union 
select product.model, printer.price
from printer join product on printer.model = product.model where price > (select avg(price) from printer)
union
select product.model, laptop.price
from laptop join product on laptop.model = product.model where price > (select avg(price) from laptop)



--task3  (lesson4)
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model


select printer.model
from printer join product
on printer.model = product.model
where maker = 'A' and price > (
	select avg(price) 
	from printer 
	join product 
	on product.model = printer.model 
	where maker = 'D'
	) 
and price > 
	(select avg(price) 
	from printer 
	join product 
	on product.model = printer.model 
	where maker = 'C')


--task4 (lesson4)
-- ������������ �����: ������� ��� ������ ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model

select product.model
from printer 
join product 
on product.model = printer.model 
where maker = 'A'
and 
price > 
(
	select avg(price) 
	from printer 
	join product 
	on product.model = printer.model 
	where maker = 'D'
	) 
and price > 
	(select avg(price) 
	from printer 
	join product 
	on product.model = printer.model 
	where maker = 'C')




--task5 (lesson4)
-- ������������ �����: ����� ������� ���� ����� ���������� ��������� ������������� = 'A' (printer & laptop & pc)


Select 
(
  (SELECT sum(distinct price) from printer join product on printer.model = product.model where product.maker = 'A')
  +
  (SELECT sum(distinct price) from laptop join product on laptop.model = product.model where product.maker = 'A')
  +
   (SELECT sum(distinct price) from pc join product on pc.model = product.model where product.maker = 'A')
) 
/ 
(
  (SELECT count(distinct price) from printer join product on printer.model = product.model where product.maker = 'A')
  +
  (SELECT count(distinct price) from laptop join product on laptop.model = product.model where product.maker = 'A')
  +
  (SELECT count(distinct price) from pc join product on pc.model = product.model where product.maker = 'A')
)



--task6 (lesson4)
-- ������������ �����: ������� view � ����������� ������� (�������� count_products_by_makers) �� ������� �������������. �� view: maker, count

create or replace view acount1_products_by_makers_second_stream as
select maker, count (type)
from product
group by maker

select*
from product


--task7 (lesson4)
-- �� ����������� view (count_products_by_makers) ������� ������ � colab (X: maker, y: count)

create or replace view acount_products_by_makers_second_stream as
select maker, count (type) 
from product 
group by maker
limit 2
select * from acount_products_by_makers_second_stream;

--task8 (lesson4)
-- ������������ �����: ������� ����� ������� printer (�������� printer_updated) � ������� �� ��� ��� �������� ������������� 'D'

create table printer_update1_second_stream as
select printer.code, printer.model, printer.color, printer.type, printer.price
from printer join product 
on printer.model = product.model
where maker <> 'D' 
 


--task9 (lesson4)
-- ������������ �����: ������� �� ���� ������� (printer_updated) view � �������������� �������� ������������� (�������� printer_updated_with_makers)

create table printer_updated_with_makers_second_stream as
select printer.code, printer.model, printer.color, printer.type, printer.price, product.maker
from printer join product 
on printer.model = product.model
where maker <> 'D' 



--task10 (lesson4)
-- �������: ������� view c ����������� ����������� �������� � ������� ������� (�������� sunk_ships_by_classes). �� view: count, class (���� �������� ������ ���/IS NULL, �� �������� �� 0)
1)
create view sunk_ships_by_classes as
select class, count(ship)
from outcomes join ships
on outcomes.ship = ships.name
where result = 'sunk'
group by class


2)
create view sunk_ships_by_classes as
select class, count(ship)
from outcomes cross join ships
where result = 'sunk'
group by class



--task11 (lesson4)
-- �������: �� ����������� view (sunk_ships_by_classes) ������� ������ � colab (X: class, Y: count)

create view sunk_ships_by_classes as
select class, count(ship)
from outcomes join ships
on outcomes.ship = ships.name
where result = 'sunk'
group by class

--task12 (lesson4)
-- �������: ������� ����� ������� classes (�������� classes_with_flag) � �������� � ��� flag: ���� ���������� ������ ������ ��� ����� 9 - �� 1, ����� 0

create table classes_with_flag as
select*,
case
    when numguns >= 9
    then 1
    else 0
end flag
from classes

--task13 (lesson4)
-- �������: ������� ������ � colab �� ������� classes � ����������� ������� �� ������� (X: country, Y: count)


select count(class), country
from classes
group by country


select * from classes_with_flag

--task14 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ���������� � ����� "O" ��� "M".

select count(name)
from ships
where name like 'M_%' or name like 'O_%'

--task15 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ������� �� ���� ����.

select count(name)
from ships
where name like '% %'

--task16 (lesson4)
-- �������: ��������� ������ � ����������� ���������� �� ���� �������� � ����� ������� (X: year, Y: count)


select  count(class), launched
from ships
group by launched




