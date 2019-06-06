class OrcamentoMailer < ApplicationMailer
	default from: "contato@beeprinted.com.br"

	def orcamento_email(orcamento)
		@orcamento = orcamento
		mail(to: "thierre@beeprinted.com.br", subject: "Pedido de Orçamento (#{orcamento.id}) - BEEPRINTED")
	end
end
