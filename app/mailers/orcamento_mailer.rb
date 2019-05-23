class OrcamentoMailer < ApplicationMailer
	default from: "contato@beeprinted.com.br"

	def orcamento_email(user, orcamento)
		@user = user
		@orcamento = orcamento
		mail(to: "iago@beeprinted.com.br", subject: "Pedido de Orçamento (#{orcamento.id}) - BEEPRINTED")
	end
end
