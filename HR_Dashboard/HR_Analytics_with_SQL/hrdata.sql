-- Testing our PowerBI Dashboard


Create Database HR_Database;

Create Table hrdata
(
	emp_no int8 PRIMARY KEY,
	gender varchar(50) NOT NULL,
	marital_status varchar(50),
	age_band varchar(50),
	age int8,
	department varchar(50),
	education varchar(50),
	education_field varchar(50),
	job_role varchar(50),
	business_travel varchar(50),
	employee_count int8,
	attrition varchar(50),
	attrition_label varchar(50),
	job_satisfaction int8,
	active_employee int8
);


-- Employee Count:
select * from hrdata;

select count(employee_count) from hrdata
-- where education= 'High School';
-- where department = 'R&D';
where education_field = 'medical';



-- Attrition Count:

select count(attrition) from hrdata
where attrition = 'yes';


-- Attrition Rate:

select round(((select count(attrition) from hrdata where attrition = 'yes')/sum(employee_count))*100,2)
from hrdata;



-- Active Employee:
select count(active_employee) from hrdata
where active_employee = 1;


-- Average Age:
select round(avg(age)) from hrdata;



-- Attrition by Gender

select gender, count(attrition) from hrdata
where attrition = 'yes'
group by gender
order by count(attrition) desc;


-- Department wise Attrition:

select Department, count(attrition) as Attrition_Count, 
round(count(attrition)/(select count(attrition) from hrdata where attrition = 'yes')*100,2) as Attrition_Percentage
from hrdata
where attrition = 'yes'
group by department
order by count(attrition) desc;


-- No of Employee by Age Group

select age_band, gender, sum(employee_count) from hrdata
group by age_band, gender
order by age_band, gender;

-- Education Field wise Attrition:

select education_field, count(attrition) from hrdata
where attrition = 'yes'
group by education_field
order by count(attrition) desc;



-- Attrition Rate by Gender for different Age Group

select age_band, gender, count(attrition) As AttritionCount,
round(count(attrition)/(select count(attrition) from hrdata h2 where h2.age_band = h1.age_band and attrition = 'yes')*100,2) as Percentage_AttritionCount
from hrdata h1
where attrition = 'yes'
group by age_band, gender
order by age_band, gender;



-- Job Satisfaction Rating

SELECT 
    job_role,
    SUM(CASE WHEN job_satisfaction = 1 THEN employee_count ELSE 0 END) AS one,
    SUM(CASE WHEN job_satisfaction = 2 THEN employee_count ELSE 0 END) AS two,
    SUM(CASE WHEN job_satisfaction = 3 THEN employee_count ELSE 0 END) AS three,
    SUM(CASE WHEN job_satisfaction = 4 THEN employee_count ELSE 0 END) AS four
FROM hrdata
GROUP BY job_role
ORDER BY job_role;




