class AdicionadosController < ApplicationController
  before_action :authenticate_user!, raise: false
  before_action :admin
  def create
  	@adicionado = Adicionado.create(adicionado_params)

    @mes = Date.today.strftime("%m")
    @ano = Date.today.strftime("%Y")

    @orcamentos = Orcamento.where('extract(month  from created_at) = ?', @mes)
    @modelagens = Modeling.where('extract(month  from created_at) = ?', @mes)
    @adicionados = Adicionado.where('extract(month  from created_at) = ?', @mes)
    @planilha = (@modelagens + @orcamentos + @adicionados).sort{|a,b| a.created_at <=> b.created_at }

    identificador = (@ano.to_i*100 + @mes.to_i)*1000 + @planilha.count

    @adicionado.identificador = identificador




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
    	params.require(:adicionado).permit(:name,:canal,:responsavel,:email,:telefone,:estado,:cep,:empresa,:description,:data)
  	end
	def admin
    unless current_user.admin
      flash[:alert] = "Acesso negado!"
      redirect_to root_path
    end
  	end
end
