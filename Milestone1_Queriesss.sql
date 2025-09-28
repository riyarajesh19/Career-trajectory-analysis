use riya;
show tables;
select * from employee_insights_csv;
select count(*) from employee_insights_csv;

# 1. Average salary by industry and gender:
SELECT 
    Industry,
    Gender,
    AVG(`Final_salary`) AS avg_salary
FROM 
    employee_insights_csv
GROUP BY 
    Industry, Gender;
    
# 2. Total salary compensation by job title:
SELECT 
    `Job_Title`,
    SUM(`Annual_Salary` + `Additional_Monetary_Compensation`) AS total_compensation
FROM 
    employee_insights_csv
GROUP BY 
    `Job_Title`;
    
# 3. Salary distribution by education level:
SELECT 
    `Highest_level_of_education_completed` AS education_level,
    AVG(`Final_salary`) AS avg_salary,
    MIN(`Final_salary`) AS min_salary,
    MAX(`Final_salary`) AS max_salary
FROM 
    employee_insights_csv
GROUP BY 
    education_level;
    
# 4. Number of employees by industry and year of experience:
SELECT 
    Industry,
    `Years_of_professional_experience_overall` AS experience_level,
    COUNT(*) AS num_employees
FROM 
    employee_insights_csv
GROUP BY 
    Industry, experience_level;

# 5. Median salary by age range and gender:
 SELECT 
    `Age_Range`,
    Gender,
    ROUND(AVG(`Final_salary`), 2) AS median_salary
FROM (
    SELECT 
        `Age_Range`,
        Gender,
        `Final_salary`,
        ROW_NUMBER() OVER (PARTITION BY `Age_Range`, Gender ORDER BY `Final_salary`) AS rn,
        COUNT(*) OVER (PARTITION BY `Age_Range`, Gender) AS cnt
    FROM 
        employee_insights_csv
) AS ranked
WHERE 
    rn IN (FLOOR((cnt + 1) / 2), CEIL((cnt + 1) / 2))
GROUP BY 
    `Age_Range`, Gender;

 
# 6 Job Titles with the Highest Salary in Each Country
SELECT Country, Job_Title, MAX(Final_salary) AS Max_Salary
FROM employee_insights_csv
GROUP BY Country, Job_Title
ORDER BY Country, Max_Salary DESC;

# 7. Average Salary by City and Industry
SELECT 
    City,
    Industry,
    AVG(`Final_salary`) AS avg_salary
FROM 
    employee_insights_csv
GROUP BY 
    City, Industry;
    
# 8. Percentage of Employees with Additional Monetary Compensation by Gender
SELECT 
    Gender,
    ROUND(
        SUM(CASE WHEN `Additional_Monetary_Compensation` > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS percent_with_additional_comp
FROM 
    employee_insights_csv
GROUP BY 
    Gender;
    
# 9. Total Compensation by Job Title and Years of Experience
SELECT 
    `Job_Title`,
    `Years_of_professional_experience_overall` AS experience_level,
    SUM(`Annual_Salary` + `Additional_Monetary_Compensation`) AS total_compensation
FROM 
    employee_insights_csv
GROUP BY 
    `Job_Title`, experience_level;
    
# 10. Average Salary by Industry, Gender, and Education Level
SELECT 
    Industry,
    Gender,
    `Highest_level_of_education_completed` AS education_level,
    AVG(`Final_salary`) AS avg_salary
FROM 
    employee_insights_csv
GROUP BY 
    Industry, Gender, education_level;
