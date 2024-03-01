# Workforce Insights Initiative: Unveiling the Human Capital Mosaic <br/><br/>
### Overview: 
In today's dynamic business landscape, organizations are increasingly recognizing the strategic importance of human resources (HR) in achieving their objectives. The HR Insights 360 project aims to leverage advanced data analytics techniques to unlock the potential of HR data and provide actionable insights to support organizational decision-making.
 <br/><br/>

### Data Source
The "hr.csv" file, which includes comprehensive details of the company's workforce, is the main dataset used in this analysis.
<br/><br/>

### Tools & Software
-  MIcrosoft SQL Studio
-  Power BI
<br/><br/>

### Data Preparation
During the first stage of data preparation, I completed the following tasks:
1.  Data Inspection
2.  Handling Missing Values
3.  Data Formatting
<br/><br/>

### Exploratory Data Analysis (EDA)
Exploratory analysis sought to answer the following questions:
1. What is the current workforce composition in terms of full-time vs. part-time employees, contractors, 
2. What are the trends in the workforce
3. Are there any disparities in compensation based on factors such as gender, ethnicity, or job role?
4. What is the overall level of employee engagement and satisfaction within the organization?
5. Are there any correlations between employee engagement scores and factors such as workload, leadership, or company culture?

### Analysis Methods
Bulk insert was used to get into data Azure Studio, the following are a few intriguing code snippets:
~~~ SQL
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
		COUNT(Sex) OVER(PARTITION BY Sex) AS Count_of_Females_Males
		,Employee_Name
		,Sex
		,MaritalDesc
	FROM HR WHERE EmploymentStatus = 'Voluntarily Terminated' 
	AND RaceDesc = 'Black or African American';


SELECT 
		COUNT(Sex) OVER(PARTITION BY Sex) AS Count_of_Females_Males
		,Employee_Name
		,Sex
		,MaritalDesc
	FROM HR WHERE EmploymentStatus = 'Active' 
	AND RaceDesc = 'Black or African American';


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

~~~
Microsoft Power BI was used extensively in this project, demonstrating the beneficial application of business intelligence in project work.
<br/><br/>

### Result & Findings
The analysis's outcome revealed the following:
- Every year in the fourth quarter, the store made more sales than during the first two years of its existence.
- Despite being the best-selling product category, classic cars lost money in the two territories.
- All year long, planes and ships suffered total losses.







This is a HR analytical project for an organization. 
In this project I started by using simple SQL queries to retrieve data and then gradually progressed to complex queries. 
Segmenting the data into departments and retrieving information
Used case statements to inform management about employees due for promotion with simple logic
