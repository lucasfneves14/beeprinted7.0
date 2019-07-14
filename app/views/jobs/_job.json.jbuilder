json.extract! job, :id, :title, :description, :x, :y, :z, :type, :value, :observations, :created_at, :updated_at
json.url job_url(job, format: :json)
