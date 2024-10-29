-- Task 1
-- Find names that have been given to over 5,000 babies of either sex every year for the 101 years from 1920 through 2020


create view names_through_101_years as
select first_name, sum(num) as num
from usa_baby_names
group by first_name
having count(year) = 101
order by sum(num) desc;


/* Task 2:
Classify each name's popularity according to the number of years that the name appears in the dataset. */

create view name_popularity as
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
 */

create view top_10_female_names as
select rank() over(order by sum(num) desc) as name_rank, first_name, sum(num) as num
from usa_baby_names
where sex = 'F'
group by first_name
order by name_rank
limit 10;



/* Task 4:
Return a list of first names ends in an 'a'.
 */

select first_name
from usa_baby_names
where sex = 'F' and year > 2015 and first_name like '%a'
group by first_name
order by sum(num) desc;


/* Task 5: 
Find the cumulative number of babies named Olivia over the years since the name first appeared in our dataset.
 */

create view cumulative_olivias as
select year, first_name, num, 
        sum(num) over (order by year) as cumulative_olivias -- "order by year" sum cumulatively by year
from usa_baby_names
where first_name = 'Olivia'
order by year;


/* Task 6:
Write a query that selects the year and the maximum num of babies given any male name in that year.
*/


select year, max(num) as max_num
from usa_baby_names
where sex = 'M'
group by year;


/* Task 7:
Using the previous task's code as a subquery, 
look up the first_name that corresponds to the maximum number of babies given a specific male name in a year.
 */

create view top_male_name as
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


alter view top_female_name as
select b.year, b.first_name, b.num
from usa_baby_names as b
join (
    select year, max(num) as max_num
    from usa_baby_names
    where sex = 'F'
    group by year) as sub
on b.year = sub.year
and sub.max_num = b.num
order by year desc;



-- top name since 2000

create view top_names as
select b.year, b.first_name, b.num, b.sex
from usa_baby_names as b
join (
    select year, max(num) as max_num
    from usa_baby_names
--     where year >= 2000
    group by year) as sub
on b.year = sub.year
and sub.max_num = b.num
order by year desc;


/* Task 8:
Return a list of first names that have been the top male first name 
in any year along with a count of the number of years that name has been the top name.
*/

create view count_top_male_name as
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



-- My English name is Lucy, and I would like to know other female first name begins with 'L'.
select distinct first_name
from usa_baby_names
where first_name like 'L%' and sex = 'F'



-- girl's name ending a
select distinct first_name
from usa_baby_names
where first_name like '%a' and sex = 'F'



-- I'm trying to choose a name for my future daughter, so I filtered the data to find the most popular girl names by year.
-- same view as top_female_name above
select b.year, b.first_name, b.num
from usa_baby_names b
join (select year, max(num) as num
				from usa_baby_names
				where sex = 'F'
				group by year) max
on b.year = max.year and b.num = max.num
order by b.year desc;


-- top female first names
create view count_top_female_name as
with top_name as (
    select b.year, b.first_name, b.num
    from usa_baby_names as b
    join (
        select year, max(num) as max_num
        from usa_baby_names
        where sex = 'F'
        group by year) as sub
    on b.year = sub.year
    and sub.max_num = b.num
    )
select first_name, count(year) as count_top_name
from top_name
group by first_name
order by count_top_name desc;


-- I'd like my daughter to have a name that starts with 'H' or ends with 'a'. 
-- Let's check which names from the popular girls' names list fit this criteria.

with girl_name as (
		select b.year, b.first_name, b.num
		from usa_baby_names b
		join (select year, max(num) as num
						from usa_baby_names
						where sex = 'M'
						group by year) max
		on b.year = max.year and b.num = max.num
		order by b.year desc)

select distinct first_name
from girl_name
where first_name like '%a' or first_name like 'H%';


/* Since no names starting with 'H' are in the list, 
I wrote another query to find a list of girls' names that begin with 'H'.
Let's see how many times these baby girl names have appeared over a 100-year period. */

alter view H_girl_name as
select first_name, count(year) as year_count, sum(num) as total
from usa_baby_names
where first_name like 'H%' and sex = 'F'
group by first_name
order by num desc;

-- For the past 100 years, most parents have named their daughters 'Helen' 
-- which is actually my favorite 'H' name for a girl.

alter view cumulative_helens as
select year, first_name, num, 
        sum(num) over (order by year) as cumulative_helens -- "order by year" sum cumulatively by year
from usa_baby_names
where first_name = 'Helen' 
order by year;



create view cumulative_emmas as
select year, first_name, num, 
        sum(num) over (order by year) as cumulative_emmas -- "order by year" sum cumulatively by year
from usa_baby_names
where first_name = 'Emma' 
order by year;


select year, num
from usa_baby_names
where first_name = 'Emma';

------------------------------------------------------------------------------------------

-- If I have a son, I want his name starts with 'H' as well. 
-- Let's filter the dataset and see which boy name starting letter H

create view H_male_name as
select first_name, count(year) as year_count, sum(num) as total
from usa_baby_names
where first_name like 'H%' and sex = 'M'
group by first_name
order by total desc;
-- I always choose Harry as my boy's name because of the famous Harry Potter series.

create view cumulative_harrys as
select year, first_name, num, 
        sum(num) over (order by year) as cumulative_harrys -- "order by year" sum cumulatively by year
from usa_baby_names
where first_name = 'Harry'
order by year;


create view cumulative_james as
select year, first_name, num, 
        sum(num) over (order by year) as cumulative_james -- "order by year" sum cumulatively by year
from usa_baby_names
where first_name = 'James'
order by year;