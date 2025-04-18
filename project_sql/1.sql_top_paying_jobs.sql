select job_title_short,
        name as company_name,
        job_location,
        job_country,
        job_via,
        job_work_from_home,
        salary_year_avg,
        job_posted_date at time zone 'UTC' at time zone 'EST'
        as posted_date_est_zone
from job_postings_fact
left join company_dim on job_postings_fact.company_id = company_dim.company_id
where job_title_short = 'Data Analyst' and
      job_location = 'Anywhere' and
      salary_year_avg is not null
limit 10