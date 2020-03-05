class CanlendarioController < ApplicationController
	before_action :authenticate_user!, raise: false
	before_action :admin
	layout 'system/navbar'
	def show
		@orcamentos = Orcamento.where(status: "Fechado")
		@modelagens = Modeling.where(status: "Fechado")
		@adicionados = Adicionado.where(status: "Fechado")

		@planilha = (@modelagens + @orcamentos + @adicionados).sort{|a,b| a.identificador <=> b.identificador }.reverse
	end


	private
	def admin
    unless current_user.admin
      flash[:alert] = "Acesso negado!"
      redirect_to root_path
    end
  	end
end
