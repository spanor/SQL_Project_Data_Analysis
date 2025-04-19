/* What are 10 top jobs for Data Analyst where salary_year_avg is not empty and job_location is remote*/

      select  job_id,
            job_title_short,
            name as company_name,
            salary_year_avg,
            job_via,
            job_location,
            job_country,
            job_posted_date
      from job_postings_fact
      left join company_dim on job_postings_fact.company_id = company_dim.company_id
      where job_title_short = 'Data Analyst' and
            job_location = 'Anywhere' and
            salary_year_avg is not null
      order by salary_year_avg desc
      limit 10
