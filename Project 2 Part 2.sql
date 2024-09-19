--Team Members: Farzan Mahmood (individual)

--1. Show for each zoo the number of different species represented by its captive animals. 
select Zoo, count(distinct species) as 'No. of Unique Species' from Animal
group by Zoo;

--2. List the zoo name, employee name and salary of each employee that is a world’s best expert in a species. Sequence the output by employee name within zoo name.
select Zoo, EmpName, Salary from employee e inner join species s
on e.EmpNo = s.WorldBestExpertEmpNo
order by zoo, EmpName;

--3. List the detail of animals that are in captivity in any zoo and whose mother is currently in the "Garden Zoo" in Boston.
select * from animal
where MotherAnimalId in
(select AnimalID from animal
where zoo = 'Garden Zoo');

--4. Show for each zoo in Canada a count of captive animals.  Sequence the output by highest to lowest count.
Select z.ZooName, count(*) as 'No. of Captive Animals' from zoo z inner join animal a
On z.zooname = a.zoo
Where country = 'Canada'
Group by z.ZooName
Order by count(*) desc;

--5. Show for each species a count of the experts that are employed by any zoos in the USA.
Select SpeciesExperise, count(SpeciesExperise) as 'No. of Experts in USA Zoos' from employee e inner join zoo z
On e.zoo = z.ZooName
Where country = 'USA'
Group by SpeciesExperise;

--6. List the details for employees in any zoo in Canada that have either a salary of at least 75000 or are an expert in the Tiger species. Sequence the output by employee name.
select e.* from Employee e inner join zoo z
on e.Zoo = z.ZooName
where country = 'Canada' and (Salary >= 75000 or SpeciesExperise = 'Tiger')
order by EmpName;

--7. List the details for all animals born in 2016 that belong to an endangered species (status = E). 
select a.* from Animal a inner join Species s
on a.Species = s.SpeciesName
where Year(DateOfBirth) = 2016 and Status = 'E';

--8. List the details for the zoos in China that have more than 2 animals that belong to the Panda species.
select distinct * from zoo
where Country = 'China' and ZooName in
(select zoo from Animal
where Species = 'Panda'
group by Zoo
having count(*) > 2);

--9. List the names, gender and salaries of all male employees that are the world’s best expert for a threatened species (status = T).
select EmpName, Gender, Salary from Employee
where Gender = 'M' and EmpNo in
(select worldbestexpertempno from Species
where Status = 'T');

--10. List the details of the zoo that has the employee with the highest salary in any zoo.
select * from zoo 
where ZooName in
(select zoo from Employee
where salary =
(select max(salary) from Employee));

--11. List the details for any species for which there animals held in any zoo in China.
select distinct s.* from species s inner join animal a
on s.SpeciesName = a.Species inner join zoo z
on a.Zoo = z.ZooName
where country = 'China';

--12. List the details for the zoos that have animals belonging to more than 3 different species. Sequence the output alphabetically by zoo within city.
select * from zoo
where ZooName in
(select  Zoo from animal
group by Zoo
having count(distinct Species) > 3)
order by City, ZooName;

--13. List details for the animals that have a mother that is in a zoo that is different from their child's current zoo.
select child.* from animal child inner join animal mother
on child.MotherAnimalId = mother.AnimalID
where child.Zoo != mother.Zoo;

--14. Show the name of any country that has the more than 2 zoos.
select Country from zoo
group by Country
having count(*) > 2;

--15. List the species details for the species that have a world’s best expert working in a zoo that also has animals of that same species. Show each species only once.
select distinct s.* from species s inner join Employee e
on s.WorldBestExpertEmpNo = e.EmpNo inner join animal a
on s.SpeciesName = a.Species
where e.Zoo = a.Zoo;

--16. List the details for the employee that has the lowest salary for an expert in the Tiger species.
select * from Employee
where SpeciesExperise = 'Tiger' and salary =
(select min(salary) from Employee where SpeciesExperise = 'Tiger');

--17. List the details for any endangered species for which there are more than 2 individual animals in total in Canadian zoos.
select * from species 
where speciesname in 
(select Species from Species s inner join animal a
on s.SpeciesName = a.Species inner join Zoo z
on a.Zoo = z.ZooName
where Status = 'E' and Country = 'Canada'
group by species
having count(*) > 2);

--18. List the details of any zoo that has more than 2 Lions born in 2016.
select * from zoo
where ZooName in
(select Zoo from animal
where Species = 'Lion' and year(dateofbirth) = 2016
group by Zoo
having count(Species) > 2);

--19. Show the count of how many species experts are employed at the "Metro Zoo" in Toronto.
select count(*) as 'No. of Species Experts at Metro Zoo' from Employee
where Zoo = 'Metro Zoo' and SpeciesExperise is not null;

--20 List the details of mothers that have more than 2 offspring in total in all Canadian zoos. 
select * from animal where AnimalID in
(select MotherAnimalId from animal a inner join zoo z
on a.Zoo = z.ZooName
where country = 'Canada' and MotherAnimalId is not null
group by MotherAnimalId
having count(*) > 2);