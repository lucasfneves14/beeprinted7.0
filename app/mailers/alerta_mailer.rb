class AlertaMailer < ApplicationMailer
	default from: "contato@beeprinted.com.br"

	def alerta_email(orcamento)
		@orcamento = orcamento
		mail(to: "lucas@beeprinted.com.br", subject: "Alerta de entrega (##{orcamento.identificador}) - BEEPRINTED")
		mail(to: "contato@beeprinted.com.br", subject: "Alerta de entrega (##{orcamento.identificador}) - BEEPRINTED")
	end
end
