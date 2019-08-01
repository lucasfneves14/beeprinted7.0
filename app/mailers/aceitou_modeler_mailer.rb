class AceitouModelerMailer < ApplicationMailer
	default from: "Beeprinted Modelagem <contato@beeprinted.com.br>"
	def aceitou_modeler(modeler, job)
		@modeler = modeler
		@job = job
		mail(to: @modeler.email, subject: "Você aceitou o job ##{@job.id}")
	end
	def aceitou_admin(modeler, job)
		@modeler = modeler
		@job = job
		mail(to: 'iago@beeprinted.com.br', subject: "O modelador #{@modeler.name} aceitou o job ##{@job.id}")
	end
	def enviou_modeler(modeler, job)
		@modeler = modeler
		@job = job
		mail(to: @modeler.email, subject: "Você enviou os modelos para o job ##{@job.id}")

	end
	def enviou_admin(modeler, job)
		@modeler = modeler
		@job = job
		mail(to: 'iago@beeprinted.com.br', subject: "O modelador #{@modeler.name} enviou os modelos para o job ##{@job.id}")
	end
	def aprovou_modeler(modeler, job)
		@modeler = job.modeler
		@job = job
		mail(to: @modeler.email, subject: "O seu job ##{@job.id} foi aprovado")

	end
	def aprovou_admin(modeler, job)
		@modeler = job.modeler
		@job = job
		mail(to: 'iago@beeprinted.com.br', subject: "O job ##{@job.id} do modelador #{@modeler.name} foi aprovado")
	end
	def reprovou_modeler(modeler, job)
		@modeler = job.modeler
		@job = job
		mail(to: @modeler.email, subject: "O seu job ##{@job.id} foi REPROVADO")

	end
	def reprovou_admin(modeler, job)
		@modeler = job.modeler
		@job = job
		mail(to: 'iago@beeprinted.com.br', subject: "O job ##{@job.id} do modelador #{@modeler.name} foi REPROVADO")
	end

end
