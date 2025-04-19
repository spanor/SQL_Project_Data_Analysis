/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/



select skills_dim.skills,
       round(avg(salary_year_avg),0) as avg_salary
from job_postings_fact
inner join skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
where job_title_short = 'Data Analyst' and 
        job_location = 'Anywhere' and
        salary_year_avg is not null
group by skills_dim.skills
order by avg_salary desc
limit 25


/*
Here are the insights about top-paying data analyst skills, summarized in three bullet points:
Big Data & Cloud: Expertise in big data technologies like PySpark and cloud platforms such as GCP correlate with higher salaries, indicating the importance of processing and managing large datasets.
DevOps & Automation: Skills related to version control (Bitbucket, GitLab) and automation (Airflow, Jenkins) are valuable, pointing towards a trend of integrating data analysis with development operations for streamlined workflows.
Data Science Fundamentals: A solid foundation in data science libraries (Pandas, NumPy, Scikit-learn) remains crucial, highlighting the need for advanced analytical and machine learning capabilities in high-paying data analyst roles.
*/