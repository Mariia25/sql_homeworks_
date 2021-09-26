������� 1: ������� name, class �� ��������, ���������� ����� 1920
select name, class 
from ships
where launched > 1920

������� 2: ������� name, class �� ��������, ���������� ����� 1920, �� �� ������� 1942
select name, class
from ships
where launched > 1920 and launched < 1942

������� 3: ����� ���������� �������� � ������ ������. ������� ���������� � class  ---

select class, count (ships)
from ships
group by class



������� 4: ��� ������� ��������, ������ ������ ������� �� ����� 16, ������� ����� � ������. (������� classes)

SELECT class, country
From classes
WHERE bore >= 16

������� 5: ������� �������, ����������� � ��������� � �������� ��������� (������� Outcomes, North Atlantic). �����: ship.

select ship
from outcomes
where result = 'sunk'
and battle = 'North Atlantic'


select ship
from battles
left join outcomes on battle = name 
where name = 'North Atlantic' and result = 'sunk'

������� 6: ������� �������� (ship) ���������� ������������ �������

select name
from ships
order by launched desc
limit 1

������� 7: ������� �������� ������� (ship) � ����� (class) ���������� ������������ �������

select name, class
from ships
order by launched desc
limit 1


������� 8: ������� ��� ����������� �������, � ������� ������ ������ �� ����� 16, � ������� ���������. �����: ship, class

select ship, classes.class
  from outcomes 
  join classes 
  on outcomes.ship = classes.class
  where result = 'sunk' and bore >= 16
  
������� 9: ������� ��� ������ ��������, ���������� ��� (������� classes, country = 'USA'). �����: class

select class
from classes
where country = 'USA'

������� 10: ������� ��� �������, ���������� ��� (������� classes & ships, country = 'USA'). �����: name, class

select name, classes.class
from classes join ships 
on classes.class = ships.name
Where country = 'USA'