/*
Covid 19 Data Exploration 
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/




select *
From PortfolioProject..['Covid Vaccinations$']
Where continent is not null
order by 3,4 


-- Select Data that will be used

select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..['Covid Deaths$']
Where continent is not null
order by 1,2 


-- Looking at Total Cases vs Total Deaths
-- To show the likelihood of dying if an individual contracts covid in the United Kingdom.

select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..['Covid Deaths$']
Where location like '%United Kingdom%'
Where continent is not null
order by 1,2 


-- Looking at Total Cases vs Population
-- Shows what percentage of population get covid in UK

select Location, date, total_cases, population, (total_cases/population)*100 as PercentofPopulationInfected
From PortfolioProject..['Covid Deaths$']
Where location like '%United Kingdom%'
Where continent is not null
order by 1,2 



-- Looking at countries with highest infection rated compared  to population

select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as
PercentofPopulationInfected
From PortfolioProject..['Covid Deaths$']
Group by location, population
Where continent is not null
order by PercentofPopulationInfected Desc


-- Showing countries with highest death count per population

select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..['Covid Deaths$']
Where continent is not null
Group by location
order by TotalDeathCount Desc


-- Breaking the data into Continents

-- looking at continent with the highest death count per population
select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..['Covid Deaths$']
Where continent is not null
Group by continent
order by TotalDeathCount Desc



-- Global Numbers

select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int)) / SUM(new_cases) * 100 as DeathPercentage
From PortfolioProject..['Covid Deaths$']
Where continent is not null
Group By date
order By 1,2


-- Covid Vaccinations Table

-- Looking at Total Population vs Vaccination

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location,
dea.date) as RollingPeopleVaccinated
--, RollingPeopleVaccinated/population)*100
From PortfolioProject..['Covid Deaths$'] dea
Join PortfolioProject..['Covid Vaccinations$'] vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
order by 2,3


-- USE CTE to perform Calculation on Partition By in previous query

with PopvsVac (continent, location, date, population, new_vaccinations , RollingPeopleVaccinated)
as

(Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location,
dea.date) as RollingPeopleVaccinated
--, RollingPeopleVaccinated/population)*100
From PortfolioProject..['Covid Deaths$'] dea
Join PortfolioProject..['Covid Vaccinations$'] vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
)
select *, (RollingPeopleVaccinated/population)*100 as RollingPeopleVaccinated_Percentage
From PopvsVac



-- Using Temp Table to perform Calculation on Partition By in previous query


Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar (255),
Date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric,
)

Insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location,
dea.date) as RollingPeopleVaccinated
--, RollingPeopleVaccinated/population)*100
From PortfolioProject..['Covid Deaths$'] dea
Join PortfolioProject..['Covid Vaccinations$'] vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null

select *, (RollingPeopleVaccinated/population)*100 as RollingPeopleVaccinated_Percentage
From #PercentPopulationVaccinated




 
 -- Creating View to store data for later visualizations

 Create View PercentPopulationVaccinated as 
 select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location,
dea.date) as RollingPeopleVaccinated
--, RollingPeopleVaccinated/population)*100
From PortfolioProject..['Covid Deaths$'] dea
Join PortfolioProject..['Covid Vaccinations$'] vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
-- order by 2,3


select *
From PercentPopulationVaccinated