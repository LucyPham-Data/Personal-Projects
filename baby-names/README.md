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

This bar chart displays the top 10 most popular first names for girls over 101 years, with Mary leading at 3.22 million babies given that name.

![image.png](/baby-names/Images/chart_8.png)

<br>

The top male names with the highest annual counts over the 101-years period also illustrate how long each name maintained its top-ranking position.

![image.png](/baby-names/Images/chart_9.png)

<br>

This bar chart displays the top 10 most popular first names for girls over 101 years, with James leading at 4.75 million babies given that name.

![image.png](/baby-names/Images/chart_10.png)

