--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.

select class, count(ship)
from outcomes join ships
on outcomes.ship = ships.name
where result = 'sunk'
group by class

--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.
select ships.class, min (launched)
from ships
group by ships.class
 
--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей.
select class, count(ship)
from outcomes join ships
on outcomes.ship = ships.name
where result = 'sunk'
group by class
having count(distinct name) >= 3
--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).
  select *
  from outcomes join classes
  on outcomes.ship = classes.class
  order by numguns desc
--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker

  select*
  from product
  where model in (select model from pc where ram =(select min(ram) from pc)
  and speed = (select max(speed) from pc where ram = (select min(ram) from pc)))
  and maker in (select maker from product where type='printer')
  
  
  
  
  
  from product join pc
  on product.model = pc.model
  where min(ram) and speed desc
  
  
  
  
  
  select*
  from printer 
  
  
  select*
  from pc
  
  