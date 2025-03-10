Select * 
From CovidProject..CovidVaccinations
Order By 3,4

Select * 
From CovidProject..CovidDeaths
Order By 3,4

-- Select Data that we are going to be starting with

Select location, date, total_cases, new_cases, total_deaths, population
From CovidProject..CovidDeaths
Order By 1, 2

-- Looking at Total Cases Vs Total Deathes
-- Shows what percentage of all cases have died in Iran.

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 As [Death Persentage]
From CovidProject..CovidDeaths
Where location like '%iran%'
Order By 1, 2

-- Looking at Total cases Vs Total Population
-- Shows what persentage of population got COVID

Select location, date, population, total_cases, (total_cases/population)*100 As [Total Cases Persentage]
From CovidProject..CovidDeaths
Where location like '%iran%'
Order By 1, 2

-- Countries with Highest Infection Rate compared to Population

Select location, population, Max(total_cases) As [Highest Infection Count], Max((total_cases/population))*100 As [Percent Population Infected]
From CovidProject..CovidDeaths
--Where location like '%iran%'
Group By location, population
Order By 4 desc

-- See Only Countries

Select * 
From CovidProject..CovidDeaths
Where continent Is Not Null
Order By 3,4

-- Countries with Highest Death Count per Population

Select location, Max(Cast(total_deaths As int)) As [Total Deaths Count]
From CovidProject..CovidDeaths
--Where location like '%iran%'
Where continent Is Not Null
Group By location
Order By 2 desc


-- BREAKING THINGS DOWN BY CONTINENT

Select location, Max(Cast(total_deaths As int)) As [Total Deaths Count]
From CovidProject..CovidDeaths
--Where location like '%iran%'
Where continent Is Null
Group By location
Order By 2 desc


-- GLOBAL NUMBERS

Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From CovidProject..CovidDeaths
--Where location like '%iran%'
where continent is not null 
Group By date
order by 1,2

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From CovidProject..CovidDeaths
--Where location like '%iran%'
where continent is not null 
--Group By date
order by 1,2


-- Looking at Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(Convert(int, vac.new_vaccinations)) Over (Partition By dea.location Order By dea.location, 
	dea.date) As [Rolling People Vaccinated]
From CovidProject..CovidDeaths dea
Join CovidProject..CovidVaccinations vac
	On dea.location = vac.location
	And dea.date = vac.date
Where dea.continent Is Not Null
Order By 2, 3

-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidProject..CovidDeaths dea
Join CovidProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac


-- Using Temp Table to perform Calculation on Partition By in previous query

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From CovidProject..CovidDeaths dea
Join CovidProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date


Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated

-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidProject..CovidDeaths dea
Join CovidProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 



Select *
From PercentPopulationVaccinated