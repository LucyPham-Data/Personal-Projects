-- Number of country has scored more than 6 in happiness by regions in 2015 - 2024. (pie chart)
create view score_above_6 as
select year, Region, count(country) as num_of_country
FROM worldhappiness_filled 
where  `Happiness score` > 6
group by year, Region 
order by year, num_of_country desc


-- Number of country has scored less than 4.5 in happiness by regions in 2015 - 2024. (pie chart)
create view score_below_5 as
select year, Region, count(country) as num_of_country
FROM worldhappiness_filled 
where  `Happiness score` < 4.5
group by year, Region 
order by year, num_of_country desc


-- Average of happiness score in each region over the period (multiple line chart)
create view avg_score_by_region as
select year, Region, round(avg(`Happiness score`),2) as avg_score
FROM worldhappiness_filled 
group by year, Region 
order by year, avg_score desc


-- Happiness score and rank over the period. Choose one country represent a region and cross region comparation (line + bar chart)
-- North America
create view score_in_canada as
select year, `Happiness score` , `Rank` 
from worldhappiness_filled wf 
where country = 'Canada'

-- Asia
create view score_in_china as
select year, `Happiness score` , `Rank` 
from worldhappiness_filled wf 
where country = 'China'


-- Africa
create view score_in_kenya as
select year, `Happiness score` , `Rank` 
from worldhappiness_filled wf 
where country = 'Kenya'


-- South America
create view score_in_brazil as
select year, `Happiness score` , `Rank` 
from worldhappiness_filled wf 
where country = 'Brazil'


-- Europe
create view score_in_germany as
select year, `Happiness score` , `Rank` 
from worldhappiness_filled wf 
where country = 'Germany'


-- East Asia
create view score_in_afghanistan as
select year, `Happiness score` , `Rank` 
from worldhappiness_filled wf 
where country = 'afghanistan'


-- Average score in top 10 most/least happiness countries (bar chart)
-- least happiness
create view unhappy_country as
select country as unhappy_country, round(avg(`Happiness score`), 2) as avg_happiness_score
from worldhappiness_filled wf 
group by Country 
having avg_happiness_score < 4.5
order by avg_happiness_score 
limit 10


-- most happiness
create view happy_country as
select country as happy_country, round(avg(`Happiness score`), 2) as avg_happiness_score
from worldhappiness_filled wf 
group by Country 
having avg_happiness_score > 6
order by avg_happiness_score desc
limit 10
