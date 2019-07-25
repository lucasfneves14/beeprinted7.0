class AceitouModelerMailer < ApplicationMailer
	default from: "contato@beeprinted.com.br"
	def aceitou_modeler(modeler, job)
		@modeler = modeler
		@job = job
		mail(to: @modeler.email, subject: "Você aceitou o job ##{@job.id}")
	end
	def aceitou_admin(modeler, job)
		@modeler = modeler
		@job = job
		mail(to: 'contato@beeprinted.com.br', subject: "O modelador #{@modeler.name} aceitou o job ##{@job.id}")
	end
end
