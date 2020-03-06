class GraphicsController < ApplicationController
  before_action :authenticate_user!, raise: false
  before_action :admin
  layout 'system/navbar'
  def index
  	@orcamentos = Orcamento.where.not(status: "Cancelado")
	@modelagens = Modeling.where.not(status: "Cancelado")
	@adicionados = Adicionado.where.not(status: "Cancelado")

	@planilha = (@modelagens + @orcamentos + @adicionados)
	@planilha = @planilha.group_by_week {|u| u.created_at}.map { |k, v| [k, v.count] }.to_h
  end

  private

  def admin
    unless current_user.admin
      flash[:alert] = "Acesso negado!"
      redirect_to root_path
    end
  	end
end
