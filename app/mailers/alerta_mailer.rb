class AlertaMailer < ApplicationMailer
	default from: "contato@beeprinted.com.br"

	def alerta_email(orcamento, email)
		@orcamento = orcamento
		mail(to: email, subject: "Alerta de entrega (##{orcamento.identificador}) - BEEPRINTED")
	end
end
