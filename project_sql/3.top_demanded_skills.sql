/*
Question: What are the most in-demand skills for data scientist?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/



select skills_dim.skills,
count(*) as skills_count
from job_postings_fact
inner join skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
where job_title_short = 'Data Scientist' and 
        job_location = 'Anywhere' and
        skills_dim.skills is not null
group by skills_dim.skills
order by skills_count desc
limit 5

/*

Here are the insights for the top 5 skills for Data Scientist jobs based on the provided JSON data:
Python is the most in-demand skill, appearing in 10,390 job postings.
SQL is also highly valued, with 7,488 mentions.
R is the third most common skill, appearing in 4,674 job postings.
AWS and Tableau are also significant, with 2,593 and 2,458 mentions respectively.
This data underscores the importance of programming skills (Python and R), database management (SQL), and cloud computing (AWS) for data scientist positions. Data visualization skills with Tableau are also highly valued.
[
  {
    "skills": "python",
    "skills_count": "10390"
  },
  {
    "skills": "sql",
    "skills_count": "7488"
  },
  {
    "skills": "r",
    "skills_count": "4674"
  },
  {
    "skills": "aws",
    "skills_count": "2593"
  },
  {
    "skills": "tableau",
    "skills_count": "2458"
  }
]
*/