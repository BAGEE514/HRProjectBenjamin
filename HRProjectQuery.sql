--Join all 3 tables
SELECT * from Absenteeism_at_work A
LEFT JOIN Compensation C ON 
A.ID = C.ID
LEFT JOIN REASONS R ON
a.Reason_for_absence = R.Number;

---find the healthiest employees for bonus
SELECT * from Absenteeism_at_work
where Social_drinker = 0 AND Social_smoker = 0
AND Body_mass_index < 25 AND 
Absenteeism_time_in_hours < (SELECT AVG(Absenteeism_time_in_hours) from Absenteeism_at_work)

---compensation rate increase for non-smoker/ budget is $983,221 a .68 cent increase per hour
SELECT count(*) as Nonsmokers from Absenteeism_at_work
WHERE Social_smoker = 0 

--optimize query (wildcards not recommended)
SELECT 
A.ID, 
R.REASON,
Month_of_absence,
Body_mass_index,
CASE WHEN Body_mass_index < 18.5 then 'Underweight'
     WHEN Body_mass_index between 18.5 AND 25 then 'Healthy'
	 WHEN Body_mass_index between 25 AND 30 then 'Overweight'
     WHEN Body_mass_index > 30 then 'Obese'
		  ELSE 'Unknown' END as BMI_Category,
CASE WHEN Month_of_absence IN (12,1,2) Then 'Winter'
	 WHEN Month_of_absence IN(3,4,5) Then 'Spring'
	 WHEN Month_of_absence IN(6,7,8) Then 'Summer'
	 WHEN Month_of_absence IN(9,10,11) Then 'FALL'
	 ELSE 'Unknown' END as Season_Names, 
Month_of_absence, 
Day_of_the_week,
Transportation_expense,
Education,
Son,
Social_drinker,
Social_smoker,
Pet,
Disciplinary_failure,
Age,
Work_load_Average_day,
Absenteeism_time_in_hours
from Absenteeism_at_work A
LEFT JOIN Compensation C ON 
A.ID = C.ID
LEFT JOIN REASONS R ON
A.Reason_for_absence = R.Number; 
