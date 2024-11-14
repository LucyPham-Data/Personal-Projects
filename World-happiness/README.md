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
* How have happiness scores changed over time for individual countries?
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

<p> Analyzing the correlations between Happiness Score and key factors—GDP per capita, Social Support, Freedom of Choice, Healthy Life Expectancy, Generosity, and Perceptions of Corruption—reveals that each of these elements has a positive correlation with happiness. This suggests that higher values in these areas generally contribute to increased happiness levels within a country.

![image.png](/World-happiness/Images/image6.png)

<br>

<p> These are the top 10 happiest countries globally, each column shows an average happiness score above 7 out of 10. Below, a bar chart shows the 10 least happy countries, where average scores fall below 4 out of 10. 

![image.png](/World-happiness/Images/image7.png)

<br>

<p> The world map illustrates levels of happiness: green for happy, yellow for neutral, and red for unhappy areas.

![image.png](/World-happiness/Images/image8.png)

<br>

<p> Canada, where I currently live, ranks 15th among the world's happiest countries as of 2024.

![image.png](/World-happiness/Images/image9.png)

<br>

<p> Vietnam, my home country, ranks 54th and is considered a happy country according to 2024 data.

![image.png](/World-happiness/Images/image13.png)

<br>

<p>Afghanistan, the country-wide war ended in 2021 ranked 143th according to 2024 data.

![image.png](/World-happiness/Images/image12.png)

<br>

<p> Counts of happy countries by region are shown in the left pie chart, while the right pie chart displays counts of the least happy countries. These visuals highlight that the happiest and wealthiest countries are primarily in Europe, Latin America, and East Asia, whereas the least happy countries are largely located in South Asia and Africa.

![image.png](/World-happiness/Images/image14.png)

<br>

<p>These visuals showcase six countries, each representing a different region. The bar chart displays each country's happiness score over the years, while the line chart illustrates their ranking over time (with lower values indicating higher ranks). These charts highlight that a country’s happiness score alone does not determine its global ranking. For example, Germany's score remained steady over the decade, yet its rank dropped below 20 by 2024. Canada similarly experienced a gradual decline in ranking despite relatively stable happiness scores. In contrast, countries like Kenya and Afghanistan show greater fluctuations in their rankings over the period.

![image.png](/World-happiness/Images/image15.png)

<br>

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

<p>The World Happiness Report offers valuable insights into the factors influencing global happiness across different regions. The analysis reveals a strong correlation between happiness and elements like GDP per capita, social support, healthy life expectancy, and freedom to make life choices. However, it also highlights that higher happiness scores don’t necessarily translate into top rankings; even countries with stable scores, like Germany and Canada, saw their ranks decline over time. Conversely, countries with fluctuating scores, such as Kenya and Afghanistan, experienced notable shifts in their global positions. This underscores that while economic and social support factors are essential, other dynamics also play crucial roles in determining happiness and rank stability across nations.

<br>

## Reference
World Happiness Report Data Dashboard. [World Happiness Report]. (https://worldhappiness.report/data/)