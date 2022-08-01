/*
Link to the COVID-19 Dashbaord on Tableau:
https://public.tableau.com/app/profile/ayub.benlahcene/viz/Covid-19Dashboard_16551639135110/Dashboard1
Queries for the Tableau Project
*/


-- First Query: Find the Global Numbers for the total cases, total deaths and the death percantage.
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..['Covid Deaths$']
where continent is not null 
--Group By date
order by 1,2


-- Second Query: Find the total death per continent
-- We take these out as they are not inluded in the above queries and want to stay consistent, European Union is part of Europe

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From PortfolioProject..['Covid Deaths$']
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc


-- Third Query: Percent Population Infected Per Country

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..['Covid Deaths$']
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc


-- Four Query: Find Percent Population Infection

Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..['Covid Deaths$']
--Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc
