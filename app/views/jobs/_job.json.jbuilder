json.extract! job, :id, :job_name, :user_id, :address, :salary_start, :salary_end, :work_hours, :job_description, :created_at, :updated_at
json.url job_url(job, format: :json)
