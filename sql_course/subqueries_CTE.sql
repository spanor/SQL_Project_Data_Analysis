/*select count(job_id)
from
    (select * 
    from job_postings_fact
    where extract(month from job_posted_date)= 1)
as job_posted_january


-- The above code is a subquery that counts the number of job postings in January.

with jan AS
(
    select * 
    from job_postings_fact 
    where EXTRACT(month from job_posted_date) = 1
)*/

select 
    job_id, job_no_degree_mention
from 
    job_postings_fact
where 
    job_no_degree_mention = true 

select name as company_name, company_id
from company_dim
where company_id in
(
    select company_id
    from job_postings_fact
    where job_no_degree_mention = true
    order by company_id asc
)


with company_job_count as (
    select company_id,
           count(*) as total_count
    from 
            job_postings_fact
    group by 
            company_id
)


select name as company_name,
         company_job_count.total_count
from company_dim
left join company_job_count 
           on company_dim.company_id = company_job_count.company_id
order by company_job_count.total_count desc

select * from skills_dim
select * from skills_job_dim


select skills_dim.skills as skill_name,
        skills_dim.skill_id,
        top_skills.skill_count
from skills_dim
left join 
(
    select skills_job_dim.skill_id,
        count(*) as skill_count
    from skills_job_dim
    group by skill_job_dim.skill_id
    order by skill_count desc
    limit 5
) as top_skills on skills_dim.skill_id = top_skills.skill_id 


SELECT skills_dim.skills AS skill_name,
       skills_dim.skill_id,
       top_skills.skill_count
FROM skills_dim
LEFT JOIN (
    SELECT skill_id,
           COUNT(*) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY skill_count DESC
    LIMIT 5
) AS top_skills ON skills_dim.skill_id = top_skills.skill_id

-- find count of remote job postings per skill
   -- find top 5 skills per remote job postinss
   -- include skill Id, name and count required the skill 



with remote_job_skills as (
    select skill_id, 
            count(*) as skill_count
    from skills_job_dim as skills_to_job
    inner join job_postings_fact as job_postings 
        on job_postings.job_id = skills_to_job.job_id
    where job_postings.job_work_from_home = true and
          job_postings.job_title_short = 'Data Analyst'
    group by skill_id
)

select skills.skills as skill_name,
    skills.skill_id,
    skill_count
from skills_dim as skills 
left join remote_job_skills as remote_skills
    on remote_skills.skill_id = skills.skill_id
where remote_skills.skill_count is not null
order by skill_count desc
limit 5


