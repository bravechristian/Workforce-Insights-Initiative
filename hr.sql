CREATE DATABASE hrDatasets;
USE hrDatasets;

SELECT * FROM HR;


--Showing results for employees who are still active

SELECT * FROM HR
WHERE DateofTermination IS NULL;


SELECT
	Employee_Name
	,Salary
	,Position
	,State
	,DOB
	,MaritalDesc
	,RaceDesc
	,DateofTermination
	,ManagerName
	,Department
FROM HR WHERE DateofTermination IS NULL;

--Showing results for employees who are active and in the production department 

SELECT
	Employee_Name
	,Salary
	,Position
	,State
	,DOB
	,MaritalDesc
	,RaceDesc
	,DateofTermination
	,ManagerName
	,Department
FROM HR WHERE DateofTermination IS NULL AND Department = 'Production';
	

--Showing result for the number of employees in production that are active

SELECT
	COUNT(*) AS Employees_in_Production
FROM HR WHERE DateofTermination IS NULL AND Department = 'Production';


--Showing result for Employees in Production who are African-American

SELECT
	Employee_Name
	,Salary
	,Position
	,State
	,DOB
	,MaritalDesc
	,RaceDesc
	,DateofTermination
	,ManagerName
	,Department
FROM HR WHERE DateofTermination IS NULL 
AND Department = 'Production' AND RaceDesc = 'Black or African American'
ORDER BY Employee_Name;

--Showing result for the number of Active African Americans in Production Department

SELECT
	COUNT(*) AS number_of_blacks_in_production
FROM HR WHERE DateofTermination IS NULL 
AND Department = 'Production' AND RaceDesc = 'Black or African American';

--Showing Result for Black Active Employees Who Are Females who earns Above $60000

	SELECT
		Employee_Name
		,GenderID
		,Salary
		,Position
		,State
		,DOB
		,MaritalDesc
		,RaceDesc
		,DateofTermination
		,ManagerName
		,Department
	FROM HR
	WHERE DateofTermination IS NULL AND GenderID = 1
	AND Department = 'Production' AND RaceDesc = 'Black or African American'
	AND Salary > 60000
	ORDER BY Salary DESC;

	--SELECT Employee_Name
	--		,Sex
	--		,COUNT(Sex) OVER (PARTITION BY Sex)
	--	FROM HR;


	--SELECT MAX(Salary) AS max_salary
	--FROM HR;


	--Showing result for black females who earns above $60000 and are married

	SELECT
		Employee_Name
		,GenderID
		,Salary
		,Position
		,State
		,DOB
		,MaritalDesc
		,RaceDesc
		,DateofTermination
		,ManagerName
		,Department
		,COUNT(Sex) OVER (PARTITION BY Sex) AS Total_females_here
	FROM HR
	WHERE DateofTermination IS NULL AND GenderID = 1 AND MaritalDesc = 'Married'
	AND RaceDesc = 'Black or African American'
	AND Salary > 60000
	ORDER BY Salary DESC;

	--Showing result for black men who earns above $60,000 and are married

	SELECT
		Employee_Name
		,GenderID
		,Salary
		,Position
		,State
		,DOB
		,MaritalDesc
		,RaceDesc
		,DateofTermination
		,ManagerName
		,Department
		,COUNT(Sex) OVER (PARTITION BY Sex) AS Total_males_here
	FROM HR
	WHERE DateofTermination IS NULL AND GenderID = 0 AND MaritalDesc = 'Married'
	AND RaceDesc = 'Black or African American'
	AND Salary > 60000
	ORDER BY Salary DESC;

	--Showing result for white married women earning above $60000

	SELECT
		Employee_Name
		,GenderID
		,Salary
		,Position
		,State
		,DOB
		,MaritalDesc
		,RaceDesc
		,DateofTermination
		,ManagerName
		,Department
		,COUNT(Sex) OVER (PARTITION BY Sex) AS Total_females_here
	FROM HR
	WHERE DateofTermination IS NULL AND GenderID = 1 AND MaritalDesc = 'Married'
	AND RaceDesc = 'White'
	AND Salary > 60000
	ORDER BY Salary DESC;


	--Showing result for active employee who earns the maximum salary

	SELECT 
		Employee_Name
		,Department
		,RaceDesc
		,Salary
	FROM HR
	WHERE Salary = (SELECT
		  MAX(Salary)
		  FROM HR WHERE DateofTermination IS NOT NULL);

	--SELECT
	--	Employee_name
	--	,AVG(Salary) OVER(PARTITION BY Salary)
	--FROM HR WHERE DateofTermination IS NULL
	--ORDER BY 1;
		  
	--SELECT 
	--	Employee_name
	--	,Salary
	--FROM HR WHERE DateofTermination IS NULL;


	--SELECT 
	--	Employee_Name
	--	,Department
	--	,RaceDesc
	--	,Salary
	--FROM HR WHERE Salary > 143000 AND DateofTermination IS NOT NULL; 


	
	--Showing result average salary

	SELECT
		  AVG(Salary) AS Avg_Salary
	FROM HR 
	WHERE DateofTermination IS NOT NULL;


	--Showing result for active employees who earns above the average salary

	SELECT
		Employee_Name
		,Department
		,RaceDesc
		,Salary
	FROM HR WHERE Salary >= 	(SELECT AVG(Salary)
								FROM HR 
								WHERE DateofTermination IS NOT NULL);




	SELECT
		COUNT(*)
	FROM HR WHERE Salary >= 	(SELECT AVG(Salary)
								FROM HR 
								WHERE DateofTermination IS NOT NULL);




	--Showing results for average salary for all employee

	SELECT
		Employee_Name
		,Department
		,Salary
		,Sex
		,AVG(Salary) OVER (PARTITION BY Salary) AS Avg_Salary
	FROM HR;


	--Showing results for the total number of males and females in the company

	SELECT 
		Sex
		,COUNT(*) AS GenderTotal
		,AVG(Salary) AS Avg_Salary
		,MAX(Salary) AS Max_Salary
		,MIN(Salary) AS Min_Salary
	FROM HR GROUP BY Sex;

	--Showing result for the active number of males and females
	
	SELECT 
		Sex
		,COUNT(*) AS GenderTotal
		,AVG(Salary) AS Avg_Salary
		,MAX(Salary) AS Max_Salary
		,MIN(Salary) AS Min_Salary
	FROM HR 
	WHERE DateofTermination IS NOT NULL GROUP BY Sex;


	--Showing result for active male and female names together with their average, minimum and maximum 
	--salary divided into different gender

	SELECT 
		Employee_Name 
		,Salary
		,Avg_Salary
		,Max_Salary
		,Min_Salary
		,GenderTotal
		,HR.Sex
	FROM HR
	INNER JOIN
			(SELECT 
				Sex
				,COUNT(*) AS GenderTotal
				,AVG(Salary) AS Avg_Salary
				,MAX(Salary) AS Max_Salary
				,MIN(Salary) AS Min_Salary
			FROM HR WHERE DateofTermination IS NOT NULL
			GROUP BY Sex) AS Genders
	ON Genders.Sex = HR.Sex;


	SELECT 
		Employee_Name
		,Salary
		,Sex
		,COUNT(Sex) OVER(PARTITION BY Sex) AS Gender_Total
		,AVG(Salary) OVER(PARTITION BY Sex) AS Avg_Salary
		,MAX(Salary) OVER(PARTITION BY Sex) AS Max_Salary
		,MIN(Salary) OVER(PARTITION BY Sex) AS Min_Salary
	FROM HR
	WHERE DateofTermination IS NOT NULL;


	--Showing result for females alone who earns above the average salary

	SELECT 
		Employee_Name
		,Sex
		,Salary
		,COUNT(Sex) OVER(PARTITION BY Sex) AS Gender_Total
	FROM HR WHERE Salary > 67786 AND Sex = 'F';


	--Showing results for black people who were voluntarily terminated & counting the males and females

	SELECT * FROM HR;

	SELECT 
		COUNT(Sex) OVER(PARTITION BY Sex) AS Count_of_Females_Males
		,Employee_Name
		,Sex
		,MaritalDesc
	FROM HR WHERE EmploymentStatus = 'Voluntarily Terminated' 
	AND RaceDesc = 'Black or African American';



	--Showing results for black people who are still active in services and counting males and females

	SELECT 
		COUNT(Sex) OVER(PARTITION BY Sex) AS Count_of_Females_Males
		,Employee_Name
		,Sex
		,MaritalDesc
	FROM HR WHERE EmploymentStatus = 'Active' 
	AND RaceDesc = 'Black or African American';


	--Showing results of the maximum and average salary earned in each department
		SELECT * FROM HR;


		SELECT 
			Employee_Name
			,Sex
			,RaceDesc
			,Salary
			,Department
			,MAX(Salary) OVER(PARTITION BY Department) AS Max_Salary
			,AVG(Salary) OVER(PARTITION BY Department) AS Avg_Salary
			,ROW_NUMBER() OVER(ORDER BY Department) AS Rn
		FROM HR;
			
	--Showing results for the first two employees in each department

		SELECT * FROM 
		(SELECT 
			Employee_Name
			,Department
			,EmpID
			,Salary
			,ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Department) AS RN
		FROM HR) H
		WHERE H.RN < 3;


		--SELECT * FROM HR;
		--USE hrDatasets


		--SELECT 
		--	Employee_Name
		--	,Sex
		--	,RaceDesc
		--	,Salary
		--	,Department
		--	,MAX(Salary) OVER(PARTITION BY RaceDesc) AS Max_Salary
		--FROM HR;
			

		--Showing results for the top three employees who earns the highest salary


		SELECT * FROM
		(SELECT
			Employee_Name
			,Salary
			,Department
			,RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS High_Earners
		FROM HR) HN
		WHERE High_Earners < 4;



		SELECT * FROM
		(SELECT
			Employee_Name
			,Salary
			,Department
			,RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS High_Earners
			,DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS Dense_rank_earners
		FROM HR) HN
		WHERE High_Earners < 4;


	--Showing results of employees due for promotion, those whose salaries are lower than the average salary

		SELECT
			Employee_Name
			,Salary
			,Department
			,AVG(Salary) OVER(PARTITION BY Department) AS Avg_Salary
			,RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS High_Earners
			,CASE
				WHEN Salary < AVG(Salary) OVER(PARTITION BY Department) THEN 'Due for Promotion'
				ELSE 'Maintain Status Quo'
			END AS Remarks
		FROM HR;



		--SELECT 
		--	Employee_Name
		--	,Salary
		--	,Department
		--	,AVG(Salary) OVER (PARTITION BY Department)
		--FROM HR;



		--SELECT AVG(Salary) FROM HR 
		--WHERE Department = 'Production';