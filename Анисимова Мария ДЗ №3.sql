--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--Компьютерная фирма: Вывести список всех продуктов и производителя с указанием типа продукта (pc, printer, laptop). Вывести: model, maker, type

select product.model, product.maker, product.type
from product join laptop on product.model = laptop.model
union
select product.model, product.maker, product.type
from product join pc on product.model = pc.model
union
select product.model, product.maker, product.type
from product join printer on product.model = printer.model


--task14 (lesson3)
--Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех, у кого цена вышей средней PC - "1", у остальных - "0"

select *,
case
    when price > (select avg(price) from pc)
    then 1
    else 0
end flag
from printer

--task15 (lesson3)
--Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)

select *
from ships
where class is null


--task17 (lesson3)
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships. 

select name
from ships
where class = 'Kongo'


--task1  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_300) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше > 300. Во view три колонки: model, price, flag


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
-- Компьютерная фирма: Сделать view (название: pc_with_flag_speed_price) над таблицей PC c флагом: flag = 1 для тех, у кого speed > 500 и price < 900, для остальных flag = 0

create or replace view pc_with_flag_speed_price_second_stream as
select *, 
case 
	when speed > 500 and price < 900
	then 1
	else 0
end flag 
from pc

  
--task2  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_avg_price) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше cредней . Во view три колонки: model, price, flag

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
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model


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
-- Компьютерная фирма: Вывести все товары производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model

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
-- Компьютерная фирма: Какая средняя цена среди уникальных продуктов производителя = 'A' (printer & laptop & pc)


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
-- Компьютерная фирма: Сделать view с количеством товаров (название count_products_by_makers) по каждому производителю. Во view: maker, count

create or replace view acount1_products_by_makers_second_stream as
select maker, count (type)
from product
group by maker

select*
from product


--task7 (lesson4)
-- По предыдущему view (count_products_by_makers) сделать график в colab (X: maker, y: count)

create or replace view acount_products_by_makers_second_stream as
select maker, count (type) 
from product 
group by maker
limit 2
select * from acount_products_by_makers_second_stream;

--task8 (lesson4)
-- Компьютерная фирма: Сделать копию таблицы printer (название printer_updated) и удалить из нее все принтеры производителя 'D'

create table printer_update1_second_stream as
select printer.code, printer.model, printer.color, printer.type, printer.price
from printer join product 
on printer.model = product.model
where maker <> 'D' 
 


--task9 (lesson4)
-- Компьютерная фирма: Сделать на базе таблицы (printer_updated) view с дополнительной колонкой производителя (название printer_updated_with_makers)

create table printer_updated_with_makers_second_stream as
select printer.code, printer.model, printer.color, printer.type, printer.price, product.maker
from printer join product 
on printer.model = product.model
where maker <> 'D' 



--task10 (lesson4)
-- Корабли: Сделать view c количеством потопленных кораблей и классом корабля (название sunk_ships_by_classes). Во view: count, class (если значения класса нет/IS NULL, то заменить на 0)
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
-- Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)

create view sunk_ships_by_classes as
select class, count(ship)
from outcomes join ships
on outcomes.ship = ships.name
where result = 'sunk'
group by class

--task12 (lesson4)
-- Корабли: Сделать копию таблицы classes (название classes_with_flag) и добавить в нее flag: если количество орудий больше или равно 9 - то 1, иначе 0

create table classes_with_flag as
select*,
case
    when numguns >= 9
    then 1
    else 0
end flag
from classes

--task13 (lesson4)
-- Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count)


select count(class), country
from classes
group by country


select * from classes_with_flag

--task14 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название начинается с буквы "O" или "M".

select count(name)
from ships
where name like 'M_%' or name like 'O_%'

--task15 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название состоит из двух слов.

select count(name)
from ships
where name like '% %'

--task16 (lesson4)
-- Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)


select  count(class), launched
from ships
group by launched




