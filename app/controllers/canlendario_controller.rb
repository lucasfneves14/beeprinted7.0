class CanlendarioController < ApplicationController
	before_action :authenticate_user!, raise: false
	before_action :admin
	layout 'system/navbar'
	def show
		@orcamentos = Orcamento.where('extract(month  from created_at) = ?', 3).where('extract(YEAR  from created_at) = ?', 2020).where(status: "Fechado")
		@modelagens = Modeling.where('extract(month  from created_at) = ?', 3).where('extract(YEAR  from created_at) = ?', 2020).where(status: "Fechado")
		@adicionados = Adicionado.where('extract(month  from created_at) = ?', 3).where('extract(YEAR  from created_at) = ?', 2020).where(status: "Fechado")

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
