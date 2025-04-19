/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/

with demand_skills as (
    select skills_dim.skill_id,
        skills_dim.skills,
        count(*) as skills_count
    from job_postings_fact
    inner join skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
    inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
    where job_title_short = 'Data Scientist' and 
            job_location = 'Anywhere' and
            skills_dim.skills is not null
    group by skills_dim.skills, skills_dim.skill_id

),

average_salary as (
    select skills_dim.skill_id,
        skills_dim.skills,
        round(avg(salary_year_avg),0) as avg_salary
    from job_postings_fact
    inner join skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
    inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
    where job_title_short = 'Data Analyst' and 
            job_location = 'Anywhere' and
            salary_year_avg is not null
    group by skills_dim.skills, skills_dim.skill_id
   
)

select demand_skills.skill_id, 
        demand_skills.skills,
        demand_skills.skills_count,
        average_salary.avg_salary
from
demand_skills 
inner join average_salary on demand_skills.skill_id = average_salary.skill_id


--rewriting the query without using CTEs, meaning more concisely

select skills_dim.skill_id,
    skills_dim.skills,
    count(skills_dim.skill_id) as skills_count,
    round(avg(salary_year_avg),0) as avg_salary
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
where job_title_short = 'Data Analyst' and
    job_location = 'Anywhere' and
    salary_year_avg is not null 
group by skills_dim.skill_id, skills_dim.skills
having count(skills_dim.skill_id) > 10
order by skills_count desc
limit 25

