CREATE DATABASE youtube_statistics;
USE youtube_statistics;


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



