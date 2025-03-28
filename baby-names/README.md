# Baby Names in America through 101 years

![image.png](/baby-names/Images/names.png)

<p> We'll use data from the United States Social Security Administration, which records first names along with the number and gender of babies given each name annually. This data spans 101 years, from 1920 through 2020, and is limited to names given to more than 5,000 American babies in a single year. </p>


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
Here’s the [link](https://app.powerbi.com/view?r=eyJrIjoiZmM5NWQ5OGYtMzBhYi00YTM3LWIxNjUtMjdhNDI3NGQ0NTY0IiwidCI6ImVhOTRjOGU1LTA0YjktNGUwMS05ZWM4LWJkNTVlNDFlYjg4NSJ9) to the Power BI dashboard featuring the baby names report. This interactive dashboard allows you to explore all the names on your list.

<br>

## Some screenshots from the report:

While the dataset includes more unique female names than male names, the number of baby boys born over the last 100 years has been significantly higher than that of baby girls.

![image.png](/baby-names/Images/chart_6.png)

<br>

The names with the highest annual counts over the 101-years period also illustrate how long each name maintained its top-ranking position.

![image.png](/baby-names/Images/chart_7.png)

<br>

I prefer my daughter's first name to start with the letter H, so the bar charts display the total number of female names beginning with H in the dataset. As a result, it’s clear that most parents have chosen "Helen" for their daughters. However, the dotted line shows that the number of girls named "Helen" has gradually declined over the 101-year period.

![image.png](/baby-names/Images/chart_8.png)

![image.png](/baby-names/Images/chart_9.png)

<br>

For boys, I would choose a name from the top male list (shown in the funnel chart). However, since Michael is very common, I've decided on James instead. The dotted line displays the number of babies named "James," which surged during the Baby Boomer generation (1940–1960), then declined significantly around the 2000s and has remained steady since.

![image.png](/baby-names/Images/chart_4.png)

![image.png](/baby-names/Images/chart_10.png)
