/* What skills are required for the top paying Data Analyst job postings?
use query from the first exercise to get the top 10 paying Data Analyst jobs.
Then, use the job_id to get the skills required for each job posting.
*/

with top_paying_jobs as (
      select  job_id,
            job_title_short,
            name as company_name,
            salary_year_avg
      from job_postings_fact
      left join company_dim on job_postings_fact.company_id = company_dim.company_id
      where job_title_short = 'Data Analyst' and
            job_location = 'Anywhere' and
            salary_year_avg is not null
      order by salary_year_avg desc
      limit 10
)

select top_paying_jobs.*,
      skills_dim.skills
from top_paying_jobs
inner join skills_job_dim on skills_job_dim.job_id = top_paying_jobs.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id


/*Insights and Conclusions:

Key Insights:

SQL is the most in-demand skill, followed by Python and Tableau.

Other highly sought-after skills include R, Excel, Pandas, Snowflake, Azure, Power BI, and Go.

The chart clearly shows a strong preference for data querying, programming, and data visualization tools among top-paying roles.

This visualization highlights the essential technical stack for data analysts aiming for the highest-paying positions.
*/ 