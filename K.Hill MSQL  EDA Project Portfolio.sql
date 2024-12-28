SELECT * 
FROM world_lo.los2;



SELECT MAX(total_laid_off)
FROM world_lo.los2;


SELECT MAX(percentage_laid_off)
FROM world_lo.los2;


SELECT *
FROM world_lo.los2
Where percentage_laid_off = 1
Order By total_laid_off desc;


SELECT *
FROM world_lo.los2;


SELECT *
FROM world_lo.los2
Where percentage_laid_off = 1
Order By funds_raised_millions desc;



SELECT company, sum(total_laid_off)
FROM world_lo.los2
Group By company 
Order By 2 DESC; 



SELECT min(`date`), max(`date`)
FROM world_lo.los2;



SELECT *
FROM world_lo.los2;



SELECT industry, sum(total_laid_off)
FROM world_lo.los2
Group By industry
Order By 2 DESC; 



SELECT *
FROM world_lo.los2;


SELECT country, sum(total_laid_off)
FROM world_lo.los2
Group By country
Order By 2 DESC; 


SELECT *
FROM world_lo.los2;


SELECT `date`, sum(total_laid_off)
FROM world_lo.los2
Group By `date`
Order By 1 DESC; 

SELECT Year(`date`), sum(total_laid_off)
FROM world_lo.los2
Group By year(`date`)
Order By 1 DESC; 


SELECT company, sum(total_laid_off)
FROM world_lo.los2
Group By company 
Order By 1 DESC; 



SELECT stage, sum(total_laid_off)
FROM world_lo.los2
Group By stage
Order By 1 DESC; 


Select substring(`date`, 6, 2) AS `Month`, SUM(total_laid_off)
From los2
Group By `Month`;


Select substring(`date`, 1, 7) AS `Month`, SUM(total_laid_off)
From los2
Where substring(`date`, 1, 7)  is Not Null
Group By `Month`
Order By 1 ASC;


Select substring(`date`, 1, 7) AS `Month`, SUM(total_laid_off) AS LO_By_Month
From los2
Where substring(`date`, 1, 7)  is Not Null
Group By `Month`
Order By 1 ASC;




With Rolling_Total AS 
(
Select substring(`date`, 1, 7) AS `Month`, SUM(total_laid_off) AS LO_By_Month
From los2
Where substring(`date`, 1, 7)  is Not Null
Group By `Month`
Order By 1 ASC
)
Select `Month`, LO_BY_Month, Sum(LO_By_Month) Over(Order By `Month`) AS R_Total
From Rolling_Total;



SELECT company, sum(total_laid_off)
FROM los2
Group By company 
Order By 2 DESC; 



SELECT company, Year(`date`), sum(total_laid_off)
FROM los2
Group By company, Year(`date`) 
Order By 3 DESC; 


With Company_Year (company, years, total_laid_off) As 
(
SELECT company, Year(`date`), sum(total_laid_off)
FROM los2
Group By company, Year(`date`)
), Company_Y_Rank AS
(Select *, Dense_Rank() Over(Partition BY years Order By total_laid_off DESC) AS Ranking
From Company_Year
Where years IS NOT Null
)
Select * 
From Company_Y_Rank
Where Ranking <= 5
;


Select percentage_laid_off, location, country
From los2
Order By Location
Group By country; 






SELECT *
FROM los2
Limit 5;


Select Distinct location, country, percentage_laid_off
From los2;

With RankData AS 
(
Select Distinct location, Country, percentage_laid_off,
Row_Number() Over(Order By percentage_laid_off ASC) AS Percent_Ranking 
From los2
Where percentage_laid_off IS NOT Null
)
Select location, country, percentage_laid_off, Percent_Ranking
From RankData
Where Percent_Ranking <= 25
Order By Percent_Ranking;

With RankBYFunds AS (
Select 
industry, total_laid_off, percentage_laid_off, funds_raised_millions,
Row_Number() Over(Order By funds_raised_millions DESC) AS Fund_Ranking
From los2
Where funds_raised_millions IS NOT NULL
AND total_laid_off IS NOT NULL
AND percentage_laid_off IS NOT NULL
)
Select industry AS 'Indusrty', total_laid_off AS 'Total Laid Off', percentage_laid_off As '% Laid Off', funds_raised_millions As 'Raised In $MillS', Fund_Ranking AS 'Rankings'
From RankByFunds
Where  Fund_Ranking <= 10
Order By Fund_Ranking;

SELECT *
FROM los2;






