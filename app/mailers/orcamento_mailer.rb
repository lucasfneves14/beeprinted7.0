class OrcamentoMailer < ApplicationMailer
	default from: "contato@beeprinted.com.br"

	def orcamento_email(orcamento, visit)
		@info = visit
		@orcamento = orcamento
		mail(to: "thierre@beeprinted.com.br", subject: "Pedido de Orçamento (#{orcamento.identificador}) - BEEPRINTED")
	end
end
