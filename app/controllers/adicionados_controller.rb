class AdicionadosController < ApplicationController
  before_action :authenticate_user!, raise: false
  before_action :admin
  def create
  	@adicionado = Adicionado.create(adicionado_params)
    if @adicionado.save
      flash[:success] = "O pedido foi adicionado!"
      redirect_to system_path
    else
      flash[:alert] = "O pedido não pode ser salvo! Por favor, cheque o formulário."
      redirect_to system_path
    end
  end


  private

  	def adicionado_params
    	params.require(:adicionado).permit(:name,:canal,:email,:telefone,:estado,:empresa,:description,:data)
  	end
	def admin
    unless current_user.admin
      flash[:alert] = "Acesso negado!"
      redirect_to root_path
    end
  	end
end
