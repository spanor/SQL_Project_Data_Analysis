--union and union all statements
select job_title_short,
    company_id,
    job_location
from january_jobs

union all

select job_title_short,
    company_id,
    job_location
from february_jobs

union all

select job_title_short,
    company_id,
    job_location
from march_jobs

select * from skills_dim

-- using union find the corresponding skill and skill type (these are in skills_dim) for each job_posting in q1 (quarter 1).
-- include those without any skill.

select j.job_id,
    s.skills as skill_name,
    s.type as skill_type
from job_postings_fact as j
join skills_job_dim as sj on j.job_id = sj.job_id
join skills_dim as s on s.skill_id = sj.skill_id
where extract(quarter from j.job_posted_date) = 1

union

select j.job_id,
    NULL as skill_name,
    NULL as skill_type
from job_postings_fact as j
left join skills_job_dim sj on j.job_id = sj.job_id
where extract(quarter from job_posted_date) = 1
    and sj.skill_id is null


select job_title_short,
    company_id,
    job_via,
    job_location,
    salary_year_avg
from 
(
    select * 
    from job_postings_fact
    where extract(quarter from job_posted_date) = 1
) as quarter_job_postings

where salary_year_avg > 70000
    and job_title_short = 'Data Analyst'
    order by salary_year_avg desc
