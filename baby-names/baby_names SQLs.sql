/* to import baby_names table from csv file
create a database, right click, task, import flat file
choose csv file, preview data, change data type, choose primary key
next until csv file is loaded */


/* Overview
American baby name preferences have evolved significantly since 1920. Some names have maintained popularity for over a century, 
while others have risen and fallen with changing trends. Comparing timeless names to recent favorites offers insights into shifting tastes. 
This analysis uses data from the U.S. Social Security Administration, which tracks baby names, their frequency, 
and gender associations from 1920 to 2020. To streamline the data, only names given to over 5,000 babies in a single year are included, 
helping to spot long-term patterns and trends.
 */


select * from usa_baby_names
limit 10;

/* Task 1:
Find names that have been given to over 5,000 babies of either sex every year for the 101 years from 1920 through 2020; 
recall that names only show up in our dataset when at least 5,000 babies have been given that name in a year.

Select first_name and the total number of babies that have ever been given that name.
Group by first_name and filter for those names that appear in all 101 years.
Order the results by the total number of babies that have ever been given that name, descending. */


select first_name, sum(num) as num
from usa_baby_names
group by first_name
having count(year) = 101
order by sum(num) desc;


/* Task 2:
Classify each name's popularity according to the number of years that the name appears in the dataset.

Select first_name, the sum of babies who've ever been given that name, and popularity_type.
Classify all names in the dataset as 'Classic,' 'Semi-classic,' 'Semi-trendy,' or 'Trendy' 
based on whether the name appears in the dataset more than 80, 50, 20, or 0 times, respectively.
Alias the new classification column as popularity_type.
Order the results alphabetically by first_name. */

SELECT first_name, 
       SUM(num) AS num,
       CASE 
           WHEN COUNT(year) > 80 THEN 'Classic'
           WHEN COUNT(year) > 50 THEN 'Semi-Classic'
           WHEN COUNT(year) > 20 THEN 'Semi-Trendy'
           ELSE 'Trendy'
       END AS popularity_type
FROM usa_baby_names
GROUP BY first_name
ORDER BY first_name;


/* Task 3: 
Let's take a look at the ten highest-ranked American female names in our dataset.

Select name_rank, first_name, and the sum of babies who've ever had that name.
RANK the first_name by the sum of babies who've ever had that name, 
aliasing as name_rank and showing the names in descending order by name_rank.
Filter the data to include only results where sex equals 'F'.
Limit to ten results. */


select rank() over(order by sum(num) desc) as name_rank, first_name, sum(num) as num
from usa_baby_names
where sex = 'F'
group by first_name
order by name_rank
limit 10;


/* Task 4:
Return a list of first names which meet this friend's baby name criteria.

Select only the first_name column.
Filter the data for results where sex equals 'F', the year is greater than 2015, and the first_name ends in an 'a.'
Group the data by first_name and order by the total number of babies ever given that first_name, descending. */

select first_name
from usa_baby_names
where sex = 'F' and year > 2015 and first_name like '%a'
group by first_name
order by sum(num) desc;


/* Task 5: 
Find the cumulative number of babies named Olivia over the years since the name first appeared in our dataset.

Select year, first_name, num of Olivias in that year, and cumulative_olivias.
Using a window function, sum the cumulative number of babies who have ever been named Olivia up to that year; 
alias as cumulative_olivias.
Filter the results so that only data for the name Olivia is returned.
Order the results by year from the earliest year Olivia appeared in the dataset to the most recent. */

select year, first_name, num, 
        sum(num) over (order by year) as cumulative_olivias -- "order by year" sum cumulatively by year
from usa_baby_names
where first_name = 'Olivia'
order by year;


/* Task 6:
Write a query that selects the year and the maximum num of babies given any male name in that year.

Select the year and the maximum num of babies given any one male name in that year; alias the maximum as max_num.
Filter the data to include only results where sex equals 'M'. */

select year, max(num) as max_num
from usa_baby_names
where sex = 'M'
group by year;


/* Task 7:
Using the previous task's code as a subquery, 
look up the first_name that corresponds to the maximum number of babies given a specific male name in a year.

Select year, the first_name given to the largest number of male babies, and num of babies given the first_name that year.
Join baby_names to the code in the last task as a subquery, using whatever alias you like and joining on both columns in the subquery.
Order the results by year, starting with the most recent year. */

select b.year, b.first_name, b.num
from usa_baby_names as b
join (
    select year, max(num) as max_num
    from usa_baby_names
    where sex = 'M'
    group by year) as sub
on b.year = sub.year
and sub.max_num = b.num
order by year desc;


/* Task 8:
Return a list of first names that have been the top male first name 
in any year along with a count of the number of years that name has been the top name.

Select first_name and a count of the number of years that the first_name 
appeared as a year's top name in the last task; alias this count as count_top_name.
To do this, use the code from the previous task as a common table expression.
Group by first_name and order the results from the name with the most years at the top to the name with the fewest. */

with top_name as (
    select b.year, b.first_name, b.num
    from usa_baby_names as b
    join (
        select year, max(num) as max_num
        from usa_baby_names
        where sex = 'M'
        group by year) as sub
    on b.year = sub.year
    and sub.max_num = b.num
    )
select first_name, count(year) as count_top_name
from top_name
group by first_name
order by count_top_name desc;


-- My English name is Lucy, and I would like to know its rank in the dataset.
select distinct first_name
from usa_baby_names
where first_name like 'L%' and sex = 'F'
-- Turned out 'Lucy' doesn't exist in the list.


-- I'm trying to choose a name for my future daughter, so I filtered the data to find the most popular girl names by year.
select b.year, b.first_name, b.num
from usa_baby_names b
join (select year, max(num) as num
				from usa_baby_names
				where sex = 'F'
				group by year) max
on b.year = max.year and b.num = max.num
order by b.year desc


-- I'd like my daughter to have a name that starts with 'H' or ends with 'y'. 
-- Let's check which names from the popular girls' names list fit this criteria.

with girl_name as (
		select b.year, b.first_name, b.num
		from usa_baby_names b
		join (select year, max(num) as num
						from usa_baby_names
						where sex = 'F'
						group by year) max
		on b.year = max.year and b.num = max.num
		order by b.year desc)

select distinct first_name
from girl_name
where first_name like '%y';


-- Since no names starting with 'H' are in the list, and I don't like the results either, 
-- I wrote another query to find a list of girls' names that begin with 'H'.

select distinct first_name
from usa_baby_names
where first_name like 'H%' and sex = 'F'


-- Let's see how many times these baby girl names have appeared over a 100-year period.
select first_name, count(year) as year_count, sum(num) as num
from usa_baby_names
where first_name like 'H%' and sex = 'F'
group by first_name
order by num desc
-- For the past 100 years, most parents have named their daughters 'Helen,' 
-- which is actually my favorite 'H' name for a girl.


/* which girl name is the most popular since 2018, it must be either starting H or ending y. Choose top 10
with top_name as 
 (select first_name, sex, sum(num) as total
	from usa_baby_names
	where year > 2018 
	and first_name like 'h%' or first_name like '%y'
	group by first_name, sex
	--order by sum(num) desc
	)
select top 10 first_name, sex, total
from top_name
where sex = 'F'
order by total desc */


-- If I have a son, I want his name starts with 'H' as well. 
-- Let's filter the dataset and see which boy name starting letter H
select first_name, count(year) as year_count, sum(num) as total
from usa_baby_names
where first_name like 'H%' and sex = 'M'
group by first_name
order by total desc
-- 
