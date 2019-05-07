class OrcamentoMailer < ApplicationMailer
	default from: "contato@beeprinted.com.br"

	def orcamento_email(user, orcamento)
		@user = user
		@orcamento = orcamento
		mail(to: @user.email, subject: "Pedido de Orçamento (#{orcamento.id}) - BEEPRINTED")
end
