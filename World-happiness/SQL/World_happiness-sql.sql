/* create database
Import table worldhappinessindex2015
Double check all data type and load table
*/


-- Double check the table within first 10 rows
select * from worldhappinessindex2015 limit 10


-- Check which columns have null values
select *
from worldhappinessindex2015 w 
where Country = "United States"
-- there are 2 null values

-- Try different country
select *
from worldhappinessindex2015 w 
where Country = "Palestine"
-- find more null values in different columns


/* Since the column is numerical and a null represents a missing value rather than a true zero. 
I'm going to fill column with Median to keeps all rows without skewing averages drastically.
Benefits: Provides a reasonable estimate without removing data.
Median imputation is preferred when the distribution is skewed, 
as the median is less sensitive to outliers than the mean.
*/


-- CLEANNING DATA
-- Calculate MEDIAN

/* Calculating the median in SQL can be a bit tricky because there isn’t a built-in MEDIAN function in most SQL databases. 
 * However, it is still absolutely possible to calculate Median in SQL using window functions or subqueries.
 
First, we should understand the mathematical formula used to calculate Median.
For a dataset having N elements, ordered from smallest to greatest,
Median = (N+1)/2th element, if N is odd
Median = (N/2th element + (N/2 + 1)th element)/2, if N is even
From the above formula, we have keep in mind that the dataset must be ordered and we need to account for odd and even number of datapoints.

 * Right now, I want to find Median for column 'GDP per capita' 
 * 
 * 1. Using Window Functions (Works in SQL Server, PostgreSQL, MySQL 8.0+, etc.)
*/


SELECT AVG(`GDP per capita`) AS median
FROM (
    SELECT `GDP per capita`,
           ROW_NUMBER() OVER (ORDER BY `GDP per capita`) AS row_num,
           COUNT(*) OVER () AS total_count
    FROM worldhappinessindex2015 
) AS sub
WHERE row_num in ((total_count + 1) / 2, (total_count + 2) / 2);


/* Explanation:
The inner query assigns a row number (row_num) to each row, ordered by `GDP per capita`, 
and calculates the total row count (total_count).

The outer query finds the middle row(s):
If total_count is odd, it selects the middle row.
If total_count is even, it selects the two middle rows and averages them.
*/


-- 2. Alternative Approach: Using Percentile
SELECT distinct PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY `GDP per capita`) OVER() AS "Median"
FROM worldhappinessindex2015 

/*
This method calculates the exact 50th percentile, which is the median.
The ORDER BY GDP per capita clause sorts the values in ascending order before calculating the median. 
The DISTINCT keyword ensures that only a single result is returned for the overall median, even if multiple rows contain the median value. 
The OVER() function is used without any partitioning, so PERCENTILE_CONT is applied to the entire dataset.
 */



-- Since other features may contribute to the happiness score, I will find their Medians to make sure that no null values are available



-- nations in top 1 over the years
select year, country, `GDP per capita`, `Happiness score` 
from worldhappinessindex2015 
where rank = 1



-- Top 20 most/least happy countries. change order by desc when showing the least happiness
select country, `GDP per capita`, `Happiness score`
from worldhappinessindex2015 
where year = 2024
order by `Rank`
limit 20


-- Null values have been filled by excel, continue to query using worldhappiness_filled table

-- Number of country has scored more than 6 in happiness by regions in 2015 - 2024.
select year, Region, count(country) as num_of_country
FROM worldhappiness_filled 
where  `Happiness score` > 6
group by year, Region 
order by year, num_of_country desc



-- Average of happiness score in each region over the period
select year, Region, round(avg(`Happiness score`),2) as avg_score
FROM worldhappiness_filled 
group by year, Region 
order by year, avg_score desc



-- Number of country has scored less than 4.5 in happiness by regions in 2015 - 2024.
select year, Region, count(country) as num_of_country
FROM worldhappiness_filled 
where  `Happiness score` < 4.5
group by year, Region 
order by year, num_of_country desc


-- Happiness score and rank over the period. Choose one country represent a region and cross region comparation
select year, `Happiness score` , `Rank` 
from worldhappiness_filled wf 
where country = 'United States'


-- Average score in top 10 most/least happiness countries
-- least happiness
select country as unhappy_country, round(avg(`Happiness score`), 2) as avg_happiness_score
from worldhappiness_filled wf 
group by Country 
having avg_happiness_score < 4.5
order by avg_happiness_score 
limit 10


-- most happiness
select country as happy_country, round(avg(`Happiness score`), 2) as avg_happiness_score
from worldhappiness_filled wf 
group by Country 
having avg_happiness_score > 6
order by avg_happiness_score desc
limit 10




