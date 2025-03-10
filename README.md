# COVID Data Exploration in SQL

## Project Overview
This project explores COVID-19 data using SQL, focusing on trends in cases, deaths, vaccinations, and infection rates worldwide. The dataset used for this analysis was obtained from [Our World in Data](https://ourworldindata.org/covid-deaths).

## Dataset
The project uses the following files:
1. **COVID-DataExploration.sql** - SQL queries for data exploration.
2. **CovidDeaths.xlsx** - Dataset containing COVID-19 cases and deaths.
3. **CovidVaccinations.xlsx** - Dataset containing COVID-19 vaccination data.

## Key SQL Queries
### 1. Initial Data Exploration
- Retrieve all data from `CovidVaccinations` and `CovidDeaths`.
- Sort data for better readability.

### 2. Analyzing COVID-19 Impact in Iran
- Calculate the death percentage from total cases.
- Compute the percentage of the population infected by COVID-19.

### 3. Global Insights
- Identify countries with the highest infection rates.
- Find countries with the highest death counts.
- Analyze global numbers for cases and deaths.

### 4. Vaccination Analysis
- Track vaccination progress over time using rolling sums.
- Use CTEs and temporary tables to calculate the percentage of the population vaccinated.
- Create a SQL view to store vaccination trends for visualization.

## SQL Techniques Used
- Aggregations (`SUM`, `MAX`)
- Joins (`INNER JOIN`)
- Window Functions (`OVER (PARTITION BY ...)`)
- Common Table Expressions (CTEs)
- Temporary Tables (`CREATE TABLE #TempTable`)
- Views (`CREATE VIEW`)

## Acknowledgment
The dataset is sourced from [Our World in Data](https://ourworldindata.org/covid-deaths), and all credit for data collection goes to them.

