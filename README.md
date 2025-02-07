# Youtube-Statistics-2023
This is a data analysis project for the Youtube Statistics for 2023.

## Project Overview

## Author
* cedbdeguzman

## Table of Contents
* [Methods](#Methods)
* [Data Cleaning Process](#Data-Cleaning-Process)
* [SQL_EDA_Implementation](#SQL-EDA-Implementation)
* [Overview_of_the_Results](#Overview-of-the-Results)
* [Insights](#Insights)

## Data Source
* The CSV file was downloaded from the kaggle website.

## Tools 
* Python - Data Cleaning 
* SQL Server - Exploratory Data Analysis
* Power BI - Data Visualization

  
## Methods
The data cleaning was performed using the Python Jupiter notebook. Afterwards, the cleaned data was loaded to SQL Server for Exploratory Data Analysis. Finally, the data visualization was performed on PowerBI. 

### First Phase 
 In the initial phase of data preparation, the following tasks were performed: 

 1. Loading of the CSV file using Python
 3. Removed the duplicate rows, changed the format of column names, detecting and replacing outliers, and filling missing values
 4. Sending of the cleaned data to SQL Server for Exploratory Data Analysis

### Second Phase
 The Exploratory Data Analysis involves exploring the sales data to answer some of the following questions:

 1. Which Youtuber has the most subscribers and video views? 
 2. What video category has high views to subscribers ratio? 
 3. Which country has the highest unemployment rate and gross tertiary enrollment ratio?

### Last Phase
For each question, group-by with aggregation method was used and tables were created for it. Each resulting table was transferred to Power BI for Data Visualization. 

## Data Cleaning Process 
Notebook file for the data cleaning is uploaded in the repository section. 

Steps: 

1. Load the CSV file using pd.read_csv().
2. Remove any unecessary characters on column title and capitalize each word.
3. Repeat step 2 for each category columns.
4. Select necessary columns for analysis.
5. Drop duplicate rows.
6. Detect outliers by graphing each numeric column using boxplot.
7. If the graph is skewed distribution and has potential outliers, use inter quartile rule for removing outliers.
8. If the graph is symmetric distribution, use standard deviation rule for removing outliers.
9. If the outliers are valid values for each column, just retain them.
10. If the count of outliers are almost 10% of the total values on that column, retain them. Removing the outliers or replacing them can affect the accuracy of the result since 10% is significant.
11. Detect null values and replace them with zero or median value.
12. If the numeric column has null values with extreme outliers, use the median value as a replacement for null values instead of the mean value since it can be affected due to presence of extreme outliers.
13. For the categorical column, if the number of null values is significant, replace those with 'Others' category for country and channel type column.
14. Check if each column has correct data types.
15. Combine the month, day, and year into one column then convert it to datetime format.
16. Transfer the cleaned dataframe to SQL Server for Exploratory Data Analysis.

## SQL_EDA_Implementation 

The below code was used on the EDA implementation on SQL.

Create a Database
```
CREATE DATABASE youtube_statistics;
USE youtube_statistics;
```

Create a Table
```
CREATE TABLE cleaned_data (
Youtuber nvarchar(255),
Subscribers int,
Video_Views float, 
Category nvarchar(50),
Uploads int,
Country nvarchar(50),
Channel_Type nvarchar(50),
Video_Views_Rank float,
Country_Rank float,
Channel_Type_Rank float,
Video_Views_For_The_Last_30_Days float,
Lowest_Monthly_Earnings float,
Highest_Monthly_Earnings float,
Lowest_Yearly_Earnings float, 
Highest_Yearly_Earnings float,
Subscribers_For_Last_30_Days float,
Gross_Tertiary_Education_Enrollment float, 
total_population float,
Unemployment_Rate float,
Urban_Population float,
complete_date datetime2,
Latitude float, 
Longitude float
)
```

Rank youtuber by subscriber counts 
```
SELECT 
Youtuber as youtuber,
Subscribers as subs
INTO youtuber_subs
FROM cleaned_data
ORDER BY Subscribers DESC
```

Rank category by total video views 
```
SELECT 
Category as category,
SUM(Video_Views) as views
INTO total_views
FROM cleaned_data
GROUP BY Category
ORDER BY SUM(Video_Views) DESC
```

Views to Subs to Ratio
```
SELECT 
Category,
CAST(SUM(CAST(Video_Views AS float)) / SUM(CAST(Uploads AS float)) / SUM(CAST(Subscribers AS float)) AS FLOAT) as view_subs_ratio
INTO views_subs
FROM cleaned_data
GROUP By Category
ORDER BY 2 DESC
```

Views to Subs to Ratio the last 30 days
```
SELECT 
Category,
CAST(SUM(CAST(Video_Views_For_The_Last_30_Days AS float)) / SUM(CAST(Uploads AS float)) / SUM(CAST(Subscribers_For_Last_30_Days AS float)) AS FLOAT) as view_subs_ratio
INTO views_subs_30days
FROM cleaned_data
WHERE Subscribers_For_Last_30_Days > 0
GROUP By Category
ORDER BY 2 DESC
```

Average Highest Yearly Earnings per category
```
SELECT
Category AS category,
AVG(Highest_Yearly_Earnings + Lowest_Yearly_Earnings) as avg_earning
INTO avg_earning
FROM cleaned_data
GROUP BY Category
ORDER BY 2 DESC
```

Number of uploads per year
```
SELECT 
YEAR(complete_date) as yr,
CAST(AVG(Video_Views) AS BIGINT) as views
INTO year_views
FROM cleaned_data
GROUP BY YEAR(complete_date)
ORDER BY 1
```

Gross Tertiary Enrollment Ratio 
```
SELECT 
Country, 
AVG(Gross_Tertiary_Education_Enrollment) / 100 as tertiary_enrollment
INTO tertiary_ratio
FROM cleaned_data
GROUP BY Country
ORDER BY AVG(Gross_Tertiary_Education_Enrollment) DESC
```

Unemployment Rate
```
SELECT 
Country, 
AVG(Unemployment_Rate) / 100 as Unemployment_Rate
INTO unemployment_rate
FROM cleaned_data
GROUP BY Country
ORDER BY AVG(Unemployment_Rate) DESC
```

Avg Earnings by Country
```
SELECT
Country,
AVG(Highest_Yearly_Earnings + Lowest_Yearly_Earnings) as avg_earnings
INTO earnings_country
FROM cleaned_data
GROUP BY Country
ORDER BY 2 DESC

```

## Overview_of_the_Results

![Image](https://github.com/user-attachments/assets/adfe40b5-cbfc-418f-acac-e31f889d7214)
![Image](https://github.com/user-attachments/assets/87dbb076-a630-42d6-b12a-98b8505aeeec)
![Image](https://github.com/user-attachments/assets/36501f8a-4c3a-41a6-a1c9-dbdf7d7fae83)



## Insights

1. From the graph, we can see that Music has the most views while Travel and Events categories has the least views.
2. Year 2006 has the highest amount of views.
3. In terms of the demographic information, First World Countries has the highest tertiary enrollment ratio and this is expected since they
have more developed industries leading to higher wages that can support education expenses.
4. From the scatter plot, the unemployment rate has no linear relationship with the enrollment ratio, which means that it has nothing to do with the students enrolling in university or college. There are a lot of factors that can affect the tertiary enrollment rate. It can be financial supporting capability of a family, the decision of the student of not going the university, and many more.
