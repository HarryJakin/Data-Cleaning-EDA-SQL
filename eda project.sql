select *
from layoffs_workfile1;

select max(total_laid_off)
from layoffs_workfile1;

select *
from layoffs_workfile1
where percentage_laid_off = 1
order by total_laid_off desc;

select *
from layoffs_workfile1
where percentage_laid_off = 1
order by funds_raised_millions desc;

select country,company,sum(total_laid_off)
from layoffs_workfile1
where country = 'United States'
group by company
order by 3 desc;

select max(`date`),min(`date`)
from layoffs_workfile1;

select industry,sum(total_laid_off)
from layoffs_workfile1
group by industry
order by 2 desc;

select country,sum(total_laid_off)
from layoffs_workfile1
group by country
order by 2 desc;

select country,year(`date`),sum(total_laid_off)
from layoffs_workfile1
where country = 'United States'
group by year(`date`)
order by 2 desc;

select year(`date`),sum(total_laid_off)
from layoffs_workfile1
where country = 'United States'
group by year(`date`)
order by 2 desc;

select substring(`date`,6,2) as `month`,sum(total_laid_off)
from layoffs_workfile1
group by `month`;

select substring(`date`,1,7) as `month`,sum(total_laid_off)
from layoffs_workfile1
group by `month`;

with rolling_total as
(select substring(`date`,1,7) as `month`,sum(total_laid_off) as total_off
from layoffs_workfile1
where substring(`date`,1,7) is not null
group by `month`
order by 1 asc)
select `month`, total_off,sum(total_off) over(order by `month`)
from rolling_total;

select company,year(`date`),sum(total_laid_off)
from layoffs_workfile1
group by company,year(`date`)
order by 3 desc;

with company_year(company,years,total_laid_off)as
(
select company,year(`date`),sum(total_laid_off)
from layoffs_workfile1
group by company,year(`date`)
order by 3 asc
),
company_ranking as 
(select * , dense_rank() over(partition by years order by total_laid_off desc) as ranking
from company_year
where years is not null)
select *
from company_ranking
where ranking <=5;

