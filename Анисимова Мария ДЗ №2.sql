--task1
--�������: ��� ������� ������ ���������� ����� �������� ����� ������, ����������� � ���������. �������: ����� � ����� ����������� ��������.

select class, count(ship)
from outcomes join ships
on outcomes.ship = ships.name
where result = 'sunk'
group by class

--task2
--�������: ��� ������� ������ ���������� ���, ����� ��� ������ �� ���� ������ ������� ����� ������. ���� ��� ������ �� ���� ��������� ������� ����������, ���������� ����������� ��� ������ �� ���� �������� ����� ������. �������: �����, ���.
select ships.class, min (launched)
from ships
group by ships.class
 
--task3
--�������: ��� �������, ������� ������ � ���� ����������� �������� � �� ����� 3 �������� � ���� ������, ������� ��� ������ � ����� ����������� ��������.
select class, count(ship)
from outcomes join ships
on outcomes.ship = ships.name
where result = 'sunk'
group by class
having count(distinct name) >= 3
--task4
--�������: ������� �������� ��������, ������� ���������� ����� ������ ����� ���� �������� ������ �� ������������� (������ ������� �� ������� Outcomes).
  select *
  from outcomes join classes
  on outcomes.ship = classes.class
  order by numguns desc
--task5
--������������ �����: ������� �������������� ���������, ������� ���������� �� � ���������� ������� RAM � � ����� ������� ����������� ����� ���� ��, ������� ���������� ����� RAM. �������: Maker

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
  
  