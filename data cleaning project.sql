select *
from layoffs;

create table layoffs_workfile
like layoffs;

select *
from layoffs_workfile;


with duplicate_cte as
(select *,
 row_number() over(partition by company,location,
 industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
 from layoffs_workfile)
select *
from duplicate_cte
where row_num > 1;


CREATE TABLE `layoffs_workfile1` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into layoffs_workfile1
select *,
row_number() over(partition by company,location,
 industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
 from layoffs_workfile;
 
 select *
 from layoffs_workfile1
where row_num > 1;

 delete 
from layoffs_workfile1
where row_num > 1;

select company
from layoffs_workfile1;

update layoffs_workfile1
set company = trim(company);

select distinct industry
from layoffs_workfile1;

update layoffs_workfile1
set industry = 'Crypto'
where industry like 'Crypto%';

update layoffs_workfile1
set country = 'United States'
where country like 'United states%';

select distinct country
from layoffs_workfile1
order by 1;

select `date`,
str_to_date (`date`, '%m/%d/%Y')
from layoffs_workfile1;

update layoffs_workfile1
set date = str_to_date (`date`, '%m/%d/%Y');

select *
from layoffs_workfile1;

update layoffs_workfile1
set industry = null
where industry = 'NULL';

select distinct industry
from layoffs_workfile1;



select *
from layoffs_workfile1 t1
join layoffs_workfile1 t2
    on t1.company = t2.company
    and t1.location= t2.location
where t1.industry is null
and t2.industry is not null;

select t1.industry,t2.industry
from layoffs_workfile1 t1
join layoffs_workfile1 t2
    on t1.company = t2.company
where t1.industry is null
and t2.industry is not null;

select *
from layoffs_workfile1
where company = 'Airbnb';

update layoffs_workfile1 t1
join layoffs_workfile1 t2
    on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;

delete
From layoffs_workfile1
where percentage_laid_off is null and total_laid_off is null;

select row_num
from layoffs_workfile1;

alter table layoffs_workfile1
drop column row_num;

alter table layoffs_workfile1
modify column `date` DATE;

SELECT *
FROM layoffs_workfile1;


