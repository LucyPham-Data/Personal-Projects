# Baby Names in America through 101 years

![image.png](/baby-names/Images/names.png)

<p> We'll use data from the United States Social Security Administration, which records first names along with the number and gender of babies given each name annually. This data spans 101 years, from 1920 through 2020, and is limited to names given to more than 5,000 American babies in a single year. </p>

## Overview

<br> *Table information*

| Column      | Type | Meanning       |
|-------------|-----|------------|
| <code>year</code>    | int  | year   |
| <code>first_name</code>  | var  | first name |
| <code>sex</code> | var  | sex of babies given **first_name** |
| <code>num</code> | int  | number of babies of **sex** given **first_name** in that **year** |

<br>

This project will answer some analytical questions:
* How have American baby name preferences evolved since 1920?
* Which names have remained popular for over a century?
* How do they compare to today’s most popular names?

<br>

Although the project's core content is credited to DataCamp, I expanded it by writing query explanations and conclusions after every task (details in [notebook](./notebook.ipynb)), creating custom reports in Power BI and conducting further analysis on specific first names I might consider for my children.

<br>

Here’s the to [link](https://app.powerbi.com/view?r=eyJrIjoiZmM5NWQ5OGYtMzBhYi00YTM3LWIxNjUtMjdhNDI3NGQ0NTY0IiwidCI6ImVhOTRjOGU1LTA0YjktNGUwMS05ZWM4LWJkNTVlNDFlYjg4NSJ9) of the Power BI dashboard featuring the baby names report. This interactive dashboard allows you to explore all the names on your list.

![image.png](/baby-names/Images/dashboard.png)

<br>

## Some screenshots from the report:

While the dataset includes more unique female names than male names, the number of baby boys born over the last 100 years has been significantly higher than that of baby girls.

![image.png](/baby-names/Images/chart_6.png)

<br>

The top female names with the highest annual counts over the 101-years period also illustrate how long each name maintained its top-ranking position.

![image.png](/baby-names/Images/chart_7.png)

<br>

To make this visualization, I retrieved data in SQL by this query:
```sql
create view top_female_name as
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
```

<br>

This bar chart displays the top 10 most popular first names for girls over 101 years, with Mary leading at 3.22 million babies given that name.

![image.png](/baby-names/Images/chart_8.png)

<br>

The query for this bar chart:
```sql
create view top_10_female_names as
select rank() over(order by sum(num) desc) as name_rank, first_name, sum(num) as num
from usa_baby_names
where sex = 'F'
group by first_name
order by name_rank
limit 10;
```


<br>

The top male names with the highest annual counts over the 101-years period also illustrate how long each name maintained its top-ranking position.

![image.png](/baby-names/Images/chart_9.png)

<br>

Here is the queries in SQL:

```sql
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
```

<br>

This bar chart displays the top 10 most popular first names for boys over 101 years, with James leading at 4.75 million babies given that name.

![image.png](/baby-names/Images/chart_10.png)

<br>

This time, instead of using SQL queries, I utilized Power BI's filter tool to extract the top 10 male first names.

![image.png](/baby-names/Images/report_2.png)

<br>

## Conclusion

The analysis of baby names in the U.S. over the past century reveals fascinating trends in naming preferences. While some names, like "Mary" and "James" maintained long-term popularity, others fluctuated due to cultural shifts, historical events, and evolving societal influences. The report highlights how names change over time, with new favorites emerging and older ones fading.

By visualizing these patterns, this analysis provides valuable insights for marketers, sociologists, and parents alike. It showcases how names reflect generational identities and broader societal changes, offering a data-driven perspective on naming traditions in the U.S.
