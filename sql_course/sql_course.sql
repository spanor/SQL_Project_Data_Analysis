select * from job_postings_fact
limit 10;

select '2025-04-16 16:38:00' ::Date,
       '123' ::integer,
       'true'::boolean,
        '13.4'::real


select job_title_short as title,
        job_location as location,
        job_posted_date at time zone 'UTC' at time zone 'EST' as posted_date_etc,
        extract(month from job_posted_date) as month
from job_postings_fact
limit 5

select count(job_id) as job_count,
       extract(month from job_posted_date) as month
from job_postings_fact
where job_title_short = 'Data Analyst'
group by month
order by count(job_id) desc


create table january_jobs as 
    select *
    from job_postings_fact
    where extract(month from job_posted_date) = 1


create table february_jobs as
    select *
    from job_postings_fact
    where extract(month from job_posted_date) = 2

create table march_jobs as
    select *
    from job_postings_fact
    where extract(month from job_posted_date) = 3

    select * from march_jobs

select count(job_id) as job_count,
 
    case 
        when job_location = 'New York, NY' then 'Local'
        when job_location = 'Anywhere' then 'Remote'
        else 'Onsite'
    end as category_locations
    
from job_postings_fact
where job_title_short = 'Data Analyst'
group by category_locations


 



