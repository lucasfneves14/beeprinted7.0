class AvaliacaoMailer < ApplicationMailer
	default from: "contato@beeprinted.com.br"

	def avaliacao_email(pedido)
		@pedido = pedido
		mail(to: "#{@pedido.email}", subject: "Formulário de Satisfação - BEEPRINTED")
	end
end
