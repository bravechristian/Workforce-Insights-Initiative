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
1. What is the general trend in sales?
2. Which product or products are the best-selling and most profitable?
3. When are sales at their peak?

### Analysis Methods
Bulk insert was used to get into data Azure Studio, the following are a few intriguing code snippets:
~~~ SQL
--Inserting data into the table
BULK INSERT Sales_Data
FROM 'C:\Users\camuh\Desktop\Datasets For Analysis\hr.csv'
WITH (FORMAT = 'CSV');


SELECT SUM(price) AS Price ,SUM(qty_ordered) AS Qty 
,ROUND(SUM(price * qty_ordered),2)  AS Cost, 
ROUND(SUM(sales),2) AS sales ,SUM(sales) - SUM(qty_ordered) AS Profit ,b.city 
FROM 
(SELECT
	order_date
	,sales
	,price
	,qty_ordered
	,product_line
	,status_now
FROM Sales_Data) a
LEFT JOIN
(SELECT
	order_date
	,contact_fname
	,customer_name
	,address_line1
	,city
FROM Sales_Data) b
ON a.order_date = b.order_date

GROUP BY b.city;

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
