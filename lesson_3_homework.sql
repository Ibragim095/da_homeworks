--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.
    select  s."class" , count(s."name")  
    from ships s 
    join outcomes o 
    on s."name"  = o.ship 
    where o."result" = 'sunk'
    group by s."class" 
--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.
   select s.class, s.launched 
     from ships s
      left join battles b 
      on s.name = b."name" 
    where s.launched = (select min(s2.launched)
                                 from ships s2)

--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей.
  select count(s."name"), s."class" 
   from ships s 
   left join outcomes o 
   on s."name" = o.ship 
   where o."result" = 'damaged'
   group by s."class"


--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).
  select *
  from classes c 
  where numguns = (select max(c2.numguns)
                    from classes c2)
--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker

  select t.maker
  from (
  select min(p.ram) , max(p.speed), pp.maker 
  from pc p 
   inner join product pp 
  on p.model  = p.model  
  group by pp.maker
   ) t

