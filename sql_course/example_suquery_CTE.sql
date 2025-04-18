with company_job_count as (
    select  
        company_id,
        count(*) as job_count
    from 
        job_postings_fact 
    group by 
        job_postings_fact.company_id 
)

select c.company_id, c.name, 
     company_job_count.job_count,
       
     case
        when company_job_count.job_count < 10 then 'Small'
        when company_job_count.job_count between 10 and 50 then 'Medium'
        else 'Large'
    end as company_category
        
from company_dim c 
left join company_job_count on company_job_count.company_id = c.company_id 
order by company_job_count.job_count desc
