jobs = Job.all
jobs.each do |job|
  JobNotification.create(modeler_id:1, job_id:job.id,message:"O job '#{job.title}' foi criado com sucesso")
  JobNotification.create(modeler_id:job.modeler.id, job_id:job.id,message:"O modelador #{job.modeler.name} aceitou o job '#{job.title}'")
  JobNotification.create(modeler_id:job.modeler.id, job_id:job.id,message:"O modelador #{job.modeler.name} enviou arquivos para o job '#{job.title}'")
  JobNotification.create(modeler_id:1, job_id:job.id,message:"O job '#{job.title}' foi reprovado")
end