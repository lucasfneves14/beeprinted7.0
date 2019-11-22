class FechadoMailer < ApplicationMailer
	default from: "contato@beeprinted.com.br"
	def fechado_email(orcamento)
		@orcamento = orcamento
		mail(to: "thierre@beeprinted.com.br", subject: "Fechado - Pedido #{orcamento.identificador} - BEEPRINTED")
	end
end
