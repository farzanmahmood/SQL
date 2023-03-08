--Challenge Start

-- 1. How many people participated in the survey?
select distinct count(surveyID) as 'Total Surveyed' 
from MH_survey m;

--2. How many people were surveyed per month? ;
SELECT substring(Timestamp,1,4) as 'Year', substring(Timestamp,6,2) as 'Month', count(surveyId) as 'People Surveyed' 
FROM MH_survey m 
group by substring(Timestamp,1,7);

--3. How many of those surveyed were 30 and younger?
SELECT count(surveyID) as 'Number of People Aged 30 and Younger'
from Age a 
where Age <= 30;

--4. How many people were surveyed by Gender?
SELECT gender, COUNT(surveyID) as 'Amount Surveyed'
from Gender g 
group by gender
order by COUNT(surveyID) desc;

--5. How many females that participated in the survey are self-employed?
select count(m.SurveyID) as 'Number of self-employed Females'
from MH_survey m  
inner Join Gender g On m.SurveyID  = g.SurveyID 
where g.Gender = 'Female' and m.self_employed = 'Yes';

--6. Write a query that returns all the survey details from females 
--that work in tech companies from Canada that participated in the survey?
select * 
from MH_survey m 
inner Join Gender g On m.SurveyID  = g.SurveyID
inner Join Location l On m.SurveyID  = l.SurveyID 
inner Join Age a  On m.SurveyID  = a.SurveyID 
where g.Gender = 'Female' and m.tech_company = 'Yes' and l.Country = 'Canada';

--7. How many males from the United States have mental issues interfering 
--with their work often? 
select count(*) as 'Number of males from US whose mental issues interfere with their work often'
from MH_survey m 
inner Join Gender g On m.SurveyID  = g.SurveyID
inner Join Location l On m.SurveyID  = l.SurveyID
where g.Gender = 'Male' and l.Country = 'United States' and m.work_interfere = 'Often';

--8. How many males were under 30, worked remotely, and had a history of 
--mental issues in their family?
select count(*) as 'Number of males under 30 who work remotely and have a history of mental issues in their family'
from MH_survey m 
inner Join Gender g On m.SurveyID  = g.SurveyID
inner Join Age a  On m.SurveyID  = a.SurveyID 
where g.Gender = 'Male' and a.Age < 30 and m.remote_work = 'Yes' and m.family_history = 'Yes';
			
--9. Create a view that contains all survey details from participants that are 50 years-old and over.
create view v_SurveyOver50 as
select * 
from MH_survey m 
inner join Age a  On m.SurveyID  = a.SurveyID
where a.Age >= 50 and a.Age != "";

select * from v_SurveyOver50 vso ;

/*SELECT count(*) from Age a 
where Age is "";*/


--10. Write a query that returns the number of people in Canada that have sought 
--treatment for a mental health condition and the number of people that haven't?
select m.treatment, count(*)
from MH_survey m 
inner Join Location l On m.SurveyID  = l.SurveyID
where l.Country = "Canada"
group by m.treatment
order by m.treatment desc;

--11. Write a query to display participants that have benefits that include the care option, 
--and are participating or not on wellness programs? Show how many participants, don't participate, 
--or don't know.
SELECT 
CASE 
	when m.wellness_program = 'Yes' then "Participate"
	when m.wellness_program = 'No' then "Don't Participate"
	when m.wellness_program = "Don't know" then "Don't Know"
		END as ProgramParticipation,
count(m.SurveyID) as "People with Benefits and Care Options"
from MH_survey m 
where benefits = 'Yes' and care_options = 'Yes'
group by ProgramParticipation
order by ProgramParticipation desc;


--12. How many people have mental or physical consequences by age group?
--age groups = < 25; 26 to 49, and >50
SELECT 
CASE 
	when a.age <= 25 then '25 and under'
	when a.age between 26 and 49 then '26-49'
	when a.age > 50 then 'Over 50'
		END as AgeGroups,
count(*) as "People Experiencing Mental or Physical Tolls"
from Age a 
inner join MH_survey m  On a.SurveyID  = m.SurveyID
where AgeGroups is not null and a.age != "" and (m.mental_health_consequence = 'Yes' or m.phys_health_consequence = 'Yes')
group by AgeGroups
order by AgeGroups;

/*select count(*) from Age a 
inner join MHSurvey m on a.SurveyID = m.SurveyID 
where a.age >= 50 and a.age != "" and (m.mental_health_consequence = 'Yes' or m.phys_health_consequence = 'Yes')*/

/*SELECT SUM(CASE WHEN age <= 25 THEN 1 ELSE 0 END) AS [25 and under],
        SUM(CASE WHEN age BETWEEN 26 AND 49 THEN 1 ELSE 0 END) AS [26-49],
        SUM(CASE WHEN age > 50 THEN 1 ELSE 0 END) AS [Over 50]
FROM Age a
inner join MHSurvey m  On a.SurveyID  = m.SurveyID
where m.mental_health_consequence = 'Yes' or m.phys_health_consequence = 'Yes';*/


