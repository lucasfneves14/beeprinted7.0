class JobCriadoMailer < ApplicationMailer
	default from: "contato@beeprinted.com.br"
	def job_criado(modeler, job)
		@modeler = modeler
		@job = job
		mail(to: @modeler.email, subject: "Job #{@job.title} criado com sucesso!")
	end
end
