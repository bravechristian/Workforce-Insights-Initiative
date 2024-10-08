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
Bulk insert was used to get into data Microsoft SQL Studio, the following are a few intriguing code snippets: Views created were exported to Microsoft PowerBI were DAX measures were written and visuals created.
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

<br/><br/>
### Visuals
![Screenshot 2024-08-11 144904](https://github.com/user-attachments/assets/285d86ab-4478-458a-93ac-7f3298728544)

![Screenshot 2024-08-11 145054](https://github.com/user-attachments/assets/876fae58-49f1-4ce8-b506-afed57fccf1b)


<br/><br/>
### DAX Snippets Used in the Power BI Project

Here are some of the DAX formulas used in the project:

```dax
Active Employees = 
//This measure evaluates the total staff in active service
// IF(
//     COUNTX('HR', 'HR'[EmploymentStatus] = "Active"),
//     COUNTROWS('HR')
// )
CALCULATE(
    COUNT('HR'[EmploymentStatus]),
    FILTER(
        HR,'HR'[EmploymentStatus] = "Active"
    )
)



Exceeds(Managers) = CALCULATE(
    DISTINCTCOUNT('HR'[ManagerName]),
    FILTER(
        HR, 'HR'[PerformanceScore] = "Exceeds"
    )
)


% Female Employees = 
DIVIDE(
    CALCULATE(
    COUNT('HR'[Sex]),
    'HR'[Sex] = "F"
),
CALCULATE(
    COUNT('HR'[EmploymentStatus]),
    FILTER(
        HR,'HR'[EmploymentStatus] = "Active"
    )
)
)

% Male Employees = 
DIVIDE(
    CALCULATE(
    COUNT('HR'[Sex]),
    'HR'[Sex] = "M"
),
CALCULATE(
    COUNT('HR'[EmploymentStatus]),
    FILTER(
        HR,'HR'[EmploymentStatus] = "Active"
    )
)
)

Needs Improvement = CALCULATE(
    DISTINCTCOUNT('HR'[ManagerName]),
    FILTER(
        HR, 'HR'[PerformanceScore] = "Needs Improvement"
    )
)


Terminated Employees = 
CALCULATE(
    COUNT('HR'[EmploymentStatus]),
    FILTER(
        HR,'HR'[EmploymentStatus] = "Terminated For Cause" ||
        'HR'[EmploymentStatus] = "Voluntarily Terminated"
    )
)


Total All Time Employees = 
COUNTROWS(HR

```
<br/><br/>
### Findings
1. The data shows the distribution of the workforce based employees on Full Time, Part Time and Contract engagements. 56% of the staff is composed of part time employees, another 22% is Full Time and 22% is contract engagement
2. The report also shows, that the organization tends to hire more females than males, it also shows gender with the highest contract termination to males. The highest termination exercise been carried out in 2011 and highest recruitment carried out in 2014.
3. The data shows that white females who work part time are the highest earners followed by black and asian women. Managers earn significantly more than every other categpry of employees.
4. 36.23% of the total employees are reported to be neutral towrads their work, another 33.33% are very satisfied, 27.05% and satisfied, 2.42% are dissatisfied and 0.97% are very dissatisfied.
5. Correlation exist between employee engagement scores, leadership roles, race and whether person is a US citizen or not. Most US citizen seems to be doing very well most of which are caucasians. Summarily, most managers exceeds expectation as compared others who needs improvement. It also seems that when people become eligible Non-Citizen in the USA, their performance improve.

<br/><br/>
### Limitations
1. Inconsistent or inaccurate data can lead to misleading insights.
2. Missing data points can limit the scope and depth of analysis.
3. My interpretation of data could have introduce bias in the result.

<br/><br/>
### Recommendations
#### Re-evaluate workforce structure: 
The high percentage of part-time employees might indicate a reliance on flexible labor or potential cost-cutting measures. Explore the impact of this structure on productivity, employee satisfaction, and overall business performance.
#### Investigate gender disparities: 
The overrepresentation of females and higher termination rates for males warrant further investigation. Analyze factors contributing to these imbalances, such as hiring practices, promotion opportunities, and work-life balance policies.
#### Examine turnover trends: 
The peak termination year of 2011 requires deeper analysis to identify underlying causes. Implement retention strategies to prevent future high turnover periods.
#### Conduct a compensation equity analysis: 
The significant pay gap between managers and other employees, as well as disparities among different demographic groups, requires careful examination. Ensure fair compensation practices are in place.
#### Enhance employee engagement: 
The relatively high percentage of neutral employees suggests a need to improve engagement levels. Implement initiatives to boost employee satisfaction, such as recognition programs, career development opportunities, and improved work-life balance.

<br/><br/>


### Summary
The workforce analysis reveals a predominantly part-time workforce with a higher proportion of female employees, particularly white women in part-time roles, who also tend to be top earners. The organization faces challenges with employee engagement, as indicated by a significant neutral sentiment. Additionally, the data highlights disparities in pay, termination rates, and employee satisfaction across gender, race, and employment status. These findings necessitate strategic interventions to optimize workforce composition, enhance employee engagement, and address compensation inequities


<br/><br/>

### References
1. <a href="https://dev.mysql.com/doc/">MySQL Documentation</a>
2. <a href="https://dax.guide/">DAX Formula Language </a>



<br/><br/>

