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
| <code>Dystopia + residual</code>    | double  | The “dystopia” element serves as a benchmark for the lowest achievable level of happiness given the factors included in the model. The "residual" represents the unexplained variance in happiness scores after accounting for the factors included in the model.
   |

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

I used excel to perform Median() and fill all null value with Medians.

<br>

![image.png](/World-happiness/Images/image5.png)

After ensure that no null value is available, I imported the dataset into SQL server to write query and visualize to idenify patterns and insights of the dataset.

## Some screenshots from the dashboard


