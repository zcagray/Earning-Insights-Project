![title](Graphs/Earning_Insights.png)

# Earning Insights:
## Dissecting the Drivers of Average Incomes in the US

I’m intrigued by the various ways in which individuals earn their livelihoods and the factors that influence their earnings. The extent to which certain elements contribute to compensation is a topic of great curiosity to me. 

This analysis aims to uncover insights into how geography, gender, education, and experience impact the average salary of an American. 

### Dataset

The dataset utilized in this analysis was sourced from AskAManager.org, a platform hosting a real-time salary survey with a predominant focus on the United States. The survey gathers compensation-related information from anonymous participants and is continuously updated. The dataset used for this analysis was obtained on August 20, 2023, at 15:46 (PST). This timestamp ensures a specific reference point for the data snapshot taken, which aids in maintaining temporal context throughout the analysis.

### Questions

1. What states have the highest salaries within each industry?
2. Which industries offer the highest average salaries within each age group?
3. Does gender have a varying impact on salary in specific states and industries?
4. Is there a correlation between education level, years of professional experience and salary? Specifically, does the highest degree earned correlate with salary differences among individuals with equal professional experience?

### Technical Challenges

1. Messy data:
  * There were multiple free-form answers resulting in spelling, spacing and capitalization errors
  * State, industry and race columns allowed participants to check multiple boxes
  * Annual salary column included a comma and surveyors submitted extreme numbers
2. The industry column allowed an ‘Other’ option (more free-form text to sort)
3. Roughly 16% of the data was from outside of the US
4. The race column allowed for multiple selections and an ‘Other’ option (decided to exclude race as a factor for analysis)

### Approach
#### Data Exploration

In PgAdmin, I set up a new database named 'salary'. Then, I used an SQL command to create a table with 17 distinct columns. After making sure that the data was imported correctly, I began querying the relevant fields in an attempt to answer each one of the questions outlined earlier. This led to many discoveries about the data. Some of which included:
  * About 77% of the responses were from women
  * Around 83% of the people who answered identified as ‘White’
  * Over 25% of responses came from either California, New York or Massachusetts combined

#### Data Cleaning

In Excel, I began by removing duplicates from the entire dataset. I also eliminated the commas from the ‘annual_salary’ column so that I could import that field into PostgreSQL as an integer. I thought it would be more convenient to address the free-form answers using SQL, so I imported the table data back into PostgreSQL. For the ‘country’ column, I standardized all relevant entries to ‘US’. Additionally, I populated empty ‘currency’ fields with ‘USD’ if ‘alt_currency’ had ‘USD’ listed. At this stage, I started deleting data that fell outside of the scope of both the US and USD. Further SQL querying revealed a decent amount of missing values in the ‘us_state’ field.


Back in Excel, I populated the ‘us_state’ column when the state was mistakenly entered into the ‘city’ column or when it was possible to identify a corresponding US city. At this point, additional inconsistencies were removed, as some non-US cities were included. The next step involved the 'industry' column. I manually sorted the responses labeled as ‘Other’ into existing industries and introduced new categories when necessary. Lastly, I removed outliers from the ‘annual_salary’ column in PostgreSQL. This involved excluding values below $10,000 and exceeding a certain threshold calculated using the formula (average salary + 3 * standard deviation).

#### Data Analysis

##### Question 1
![title](Graphs/avg_sal_ind_state.png)
Clearly, states such as California, Washington, D.C., and New York stand out for having notably higher salaries per industry when compared to other states. This isn't really surprising, since these regions are major economic hubs with strong industries. 

##### Question 2
![title](Graphs/avg_sal_ind_age.png)
Among the age groups of 18-24 and 25-34, Computing and Tech emerges as the top-paying industry. There's a slight shift in favor of Pharmaceuticals compared to Computing and Tech for the age ranges of 35-44 and 45-54. Moving on, the highest paying industry for those aged 55-64 is Energy, while Business and Consulting take the lead for individuals aged 65 and above.
























