SELECT 
Youtuber as youtuber,
Subscribers as subs
INTO youtuber_subs
FROM cleaned_data
ORDER BY Subscribers DESC

SELECT 
Category as category,
SUM(Video_Views) as views
INTO total_views
FROM cleaned_data
GROUP BY Category
ORDER BY SUM(Video_Views) DESC

SELECT 
Category,
CAST(SUM(CAST(Video_Views AS float)) / SUM(CAST(Uploads AS float)) / SUM(CAST(Subscribers AS float)) AS FLOAT) as view_subs_ratio
INTO views_subs
FROM cleaned_data
GROUP By Category
ORDER BY 2 DESC

SELECT 
Category,
CAST(SUM(CAST(Video_Views_For_The_Last_30_Days AS float)) / SUM(CAST(Uploads AS float)) / SUM(CAST(Subscribers_For_Last_30_Days AS float)) AS FLOAT) as view_subs_ratio
INTO views_subs_30days
FROM cleaned_data
WHERE Subscribers_For_Last_30_Days > 0
GROUP By Category
ORDER BY 2 DESC

SELECT
Category AS category,
AVG(Highest_Yearly_Earnings + Lowest_Yearly_Earnings) as avg_earning
INTO avg_earning
FROM cleaned_data
GROUP BY Category
ORDER BY 2 DESC

SELECT 
YEAR(complete_date) as yr,
CAST(AVG(Video_Views) AS BIGINT) as views
INTO year_views
FROM cleaned_data
GROUP BY YEAR(complete_date)
ORDER BY 1

SELECT 
Country, 
AVG(Gross_Tertiary_Education_Enrollment) / 100 as tertiary_enrollment
INTO tertiary_ratio
FROM cleaned_data
GROUP BY Country
ORDER BY AVG(Gross_Tertiary_Education_Enrollment) DESC

SELECT 
Country, 
AVG(Unemployment_Rate) / 100 as Unemployment_Rate
INTO unemployment_rate
FROM cleaned_data
GROUP BY Country
ORDER BY AVG(Unemployment_Rate) DESC

SELECT
Country,
AVG(Highest_Yearly_Earnings + Lowest_Yearly_Earnings) as avg_earnings
INTO earnings_country
FROM cleaned_data
GROUP BY Country
ORDER BY 2 DESC
