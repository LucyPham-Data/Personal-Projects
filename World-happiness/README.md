# WORLD HAPPINESS 2015 - 2024

![image.jpg](/World-happiness/Images/image1.jpg)

<p>As the world continues to evolve, understanding the happiness and well-being of people worldwide remains a critical pursuit for governments, organizations, and citizens alike.</p>

<br>

<p>In this report, data from over 150 countries in 10 regions have been analyzed to gauge the complex balance of elements that contribute to happiness. Key indicators such as GDP per capita, life expectancy, and levels of perceived corruption offer a lens through which we can observe shifts in global well-being. 

<br>

![image.png](/World-happiness/Images/image2.png)

<br>

<p> The World Happiness Report, a United Nations initiative, annually assesses happiness in 173 countries through the Gallup World Poll. Using a "Country Ladder Question" rated from 0 to 10, the report ranks countries by average happiness, offering policymakers insights into areas for societal improvement and promoting happiness as a key indicator beyond GDP.

<br> 

*Table information*

| Column      | Type | Meanning       |
|-------------|-----|------------|
| <code>year</code>    | year  | year of survey   |
| <code>rank</code>  | int  | Happiness Rank of each country |
| <code>country</code> | var  | Name of each country |
| <code>Region</code> | var  | Region of each country |
| <code>Happiness score</code>    | double  |  It measures how satisfied individuals are with their lives in different nations.  |
| <code>Whisker-high</code>    | double  | This represents the upper bound of the confidence interval   |
| <code>Whisker-low</code>    | double  | This represents the lower bound of the confidence interval   |
| <code>GDP per capita</code>    | double  | Gross Domestic Product (GDP) of a country divided by its population.   |
| <code>Social Support</code>    | double  | The perception or availability of assistance, care, and resources that individuals receive from their social network.   |
| <code>Healthy life expectancy</code>    | double  | A measure to estimate the number of years a person is expected to live in good health, free from significant illness or disability. |
| <code>Freedom to make life choices</code>    | double  | It reflects the extent to which individuals in a country perceive themselves to have the freedom to make decisions about their lives according to their values, beliefs, and preferences.   |
| <code>Generosity</code>    | double  | The perception of individuals within a country regarding acts of kindness, altruism, and charitable giving.    |
| <code>Perceptions of corruption</code>    | double  | The subjective beliefs and assessments of individuals within a country regarding the prevalence and extent of corruption in various sectors of society, including government, business, and public institutions.    |
| <code>Dystopia + residual</code>    | double  | The “dystopia” element serves as a benchmark for the lowest achievable level of happiness given the factors included in the model. The "residual" represents the unexplained variance in happiness scores after accounting for the factors included in the model. |

<br>

Through this blog, we’ll uncover patterns, compare happiness metrics across regions, and answer the questions:

* Which countries are happiest, and what are the key factors driving their high rankings? 
* How have happiness scores changed over time for developed countries?
* Which countries consistently rank the highest and lowest in happiness? 
* What are the top factors contributing to happiness?
* Have any regions seen consistent improvements in happiness scores?
* Does perception of corruption affect happiness?


## Data cleaning

First look at the dataset, I noticed several null values in feature columns.

![image.png](/World-happiness/Images/image3.png)

<p> Since all feature columns are numerical and a null represents a missing value rather than a true zero. I'm going to fill column with Median to keeps all rows without skewing averages drastically.
<p> Benefits: Provides a reasonable estimate without removing data. Median imputation is preferred when the distribution is skewed, as the median is less sensitive to outliers than the mean.

![image.png](/World-happiness/Images/image4.png)

<br>

I used Excel to calculate the median with the <code>MEDIAN()</code> function and filled all null values with these median values.

<br>

![image.png](/World-happiness/Images/image5.png)

After verifying that no null values remained, I imported the dataset into SQL Server to run queries and create visualizations, uncovering patterns and insights within the data.

## Some screenshots from the dashboard

Link to the report [here](https://app.powerbi.com/view?r=eyJrIjoiNmM1YTVjNjMtZjFjZC00MmE0LTllZWItYmRiYzA5MzYyMmQwIiwidCI6ImVhOTRjOGU1LTA0YjktNGUwMS05ZWM4LWJkNTVlNDFlYjg4NSJ9 ).

<br>

The report consists of two dashboards. The first dashboard highlights the top 10 happiest countries and the 10 least happy ones, along with regional insights showing the percentage distribution of happy nations by region. Two buttons on the left allow users to navigate to the next report.

![image.png](/World-happiness/Images/image6.png)

The second dashboard is interactive, allowing users to click on each country on the map to view its happiness score and rank in 2024. It also highlights the correlation between happiness scores and key factors influencing national well-being. 

![image.png](/World-happiness/Images/image7.png)

<br>

<p> The top 10 happiest countries are shown in a green bar chart, each with an average happiness score above 7 out of 10. Finland ranked first with a score of 7.7, followed by Denmark at 7.6. Israel and Australia both scored 7.2, placing 9th and 10th respectively.

In contrast, the bottom bar chart displays the 10 least happy countries, all with average scores below 4. Afghanistan ranked last with a score of 2.9, reflecting the impact of ongoing conflict, extreme poverty, and restrictions on women’s rights.

<br>

![image.png](/World-happiness/Images/image8.png)

<p> The pie chart displays the distribution of happy countries by region, revealing that the happiest and wealthiest nations are mainly located in Europe, Latin America, and East Asia. In contrast, the least happy countries tend to be in regions not prominently represented in the chart, such as South Asia and Africa.

![image.png](/World-happiness/Images/image9.png)

<br> 

The bar chart shows each country's happiness score over time, while the line chart tracks changes in their global ranking using an inverted scale. These visuals emphasize that happiness scores alone don't determine a country’s rank—for instance, the country in the screenshot maintained a steady score, yet its ranking declined gradually over the years.

![image.png](/World-happiness/Images/image10.png)

<br>

<p> Analyzing the correlations between the Happiness Score and key factors such as GDP per capita, Social Support, Freedom of Choice, Healthy Life Expectancy, Generosity, and Perceptions of Corruption reveals meaningful insights. When each of these elements shows a positive correlation with happiness, it suggests that higher values in these areas generally contribute to greater happiness levels within a country. In contrast, a negative correlation would indicate that as the value of a particular factor increases, happiness tends to decrease, highlighting potential areas where improvements may not necessarily lead to better well-being or might even have adverse effects.


![image.png](/World-happiness/Images/image11.png)

<br>

### Screenshots of some countries from the dashboard

Vietnam, my home country, ranks 54th and is considered a happy nation according to 2024 data. Its rising happiness score over the years reflects improvements in life expectancy and economic development.

![image.png](/World-happiness/Images/image12.png)

<br>

Canada, where I currently live, ranks 15th among the world's happiest countries in 2024. Over the past decade, both its happiness score and rank have gradually declined, influenced by negative trends in key factors like GDP per capita, social support, and freedom of choice.

![image.png](/World-happiness/Images/image13.png)

<br>

India's ranking has fluctuated over the past 10 years, showing no clear trend in the correlation between key factors and its happiness score, indicating a complex relationship between these variables.

![image.png](/World-happiness/Images/image14.png)

<br>

Yemen is an example of an unhappy country, with its ranking fluctuating over the past decade. In 2024, key factors like GDP per capita, social support, and healthy life expectancy remained low, indicating ongoing challenges to national well-being.

![image.png](/World-happiness/Images/image15.png)


## Pivot table to get information

Ranking by region.

![image.png](/World-happiness/Images/image16.png)

<br>

Average Happiness score by regions.

![image.png](/World-happiness/Images/image17.png)

<br>

Elements over the year.

![image.png](/World-happiness/Images/image18.png)

<br>

## Conclusion

<p>The world's happiest countries in 2024 include Finland, Denmark, and Iceland—nations that consistently rank high due to strong GDP per capita, social support, freedom of choice, and healthy life expectancy. 

<p> Developed countries have seen relatively stable happiness scores over the past decade, though some, like Canada and Germany, have experienced slight declines in rankings despite steady scores. At the opposite end, countries like Afghanistan and Yemen remain among the least happy, often due to low economic performance, poor healthcare, and weak social systems. 

<p>Across all nations, key contributors to happiness are social support, economic stability, personal freedom, and health. Regions such as Latin America and parts of East Asia have shown steady improvement, reflecting positive developments in these areas. 

<br>

## Reference
World Happiness Report Data Dashboard. [World Happiness Report](https://worldhappiness.report/data/)