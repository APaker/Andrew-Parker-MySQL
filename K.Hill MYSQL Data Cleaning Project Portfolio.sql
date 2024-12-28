Select * 
From layoffs;

Create Table LOS
Like layoffs;

Insert LOS 
Select *
From layoffs; 

Select * 
From LOS;

Select *,
Row_Number() OVER(
Partition By company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS R_Num 
From LOS; 

With duplicate_cte AS 
(
Select *,
Row_Number() OVER(
Partition By company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS R_Num 
From LOS
)
Select * 
From duplicate_cte 
Where R_Num > 1; 

Select * 
From LOS
Where company = 'casper'; 


With duplicate_cte AS 
(
Select *,
Row_Number() OVER(
Partition By company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS R_Num 
From LOS
)
Delete  
From duplicate_cte 
Where R_Num > 1;  


CREATE TABLE `los2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `R_Num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

Select * 
From LOS2
Where R_Num > 1;


Insert Into LOS2
Select *,
Row_Number() OVER(
Partition By company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS R_Num 
From LOS;

Delete 
From LOS2 
Where R_Num > 1; 

Select * 
From LOS2;


Select company, Trim(company)
From LOS2;

Update los2
Set company = trim(company); 

Select * 
From LOS2;

Select  Distinct industry 
From LOS2
Order By 1;

Select * 
From LOS2
where industry Like 'Crypto%';

Update los2
Set industry = 'Crypto' 
Where industry Like 'Crypto%'; 

Select * 
From LOS2;

Select Distinct industry 
From LOS2;

Select *
From LOS2
where country Like 'United States'
Order By 1;

Select Distinct country, Trim(Trailing '.' From country)
From LOS2
where country Like 'United States%'
Order By 1;


Select Distinct country, Trim(Trailing '.' From country)
From LOS2
Order By 1;


Update los2
Set country = Trim(Trailing '.' From country)
Where country Like 'United States%';

Alter Table los2
Modify `date` varchar(10);

Select `date`
From los2; 


Select `date`,
Str_To_Date(`date`, '%m/%d/%Y') 
From los2; 

Update los2
set `date` = date_format(str_to_date(`date`, '%Y-%m-%d'), '%m/%d/%Y'); 

Select `date`
From los2; 

Update los2
set `date` = Str_To_Date(`date`, '%m/%d/%Y');

Alter Table los2
Modify `date` varchar(10);



Alter Table los2
Modify Column `date` Date;

Select * 
From los2;


Select * 
From los2
Where total_laid_off IS Null
And percentage_laid_off IS Null;

Update  los2
Set industry = null
Where industry = '';

Select *
From los2
Where industry IS Null 
or industry = '';

Select *
From los2
Where company Like 'Bally%';


Select WLO.industry, WLO2.industry
From los2 WLO
Join los2 WLO2
	ON WLO.company = WLO2.company
    AND WLO.location = WLO2.location
Where (WLO.industry IS Null or WLO.industry = '')
AND WLO2.industry IS NOT Null;

Update los2 WLO
Join los2 WLO2
	ON WLO.company = WLO2.company
Set WLO.industry = WLO2.industry
Where WLO.industry IS Null 
AND WLO2.industry IS NOT Null;

Select *
From los2;


Select *
From los2
Where total_laid_off IS Null
AND percentage_laid_off IS Null; 


Delete 
From los2
Where total_laid_off IS Null
AND percentage_laid_off IS Null; 

Select *
From los2;

Alter Table los2
Drop Column R_Num;

Select *
From los2;

-- 1.) Removed Duplicates 
-- 2.) Standardized The Data 
-- 3.) Null/Blannk Values 
-- 4.) Removed Uneeded Columns 

