class ModelingMailer < ApplicationMailer
	default from: "contato@beeprinted.com.br"

	def modeling_email(user, modeling)
		@user = user
		@modeling = modeling
		mail(to: "iago@beeprinted.com.br", subject: "Pedido de Modelagem (#{modeling.id}) - BEEPRINTED")
	end
end
