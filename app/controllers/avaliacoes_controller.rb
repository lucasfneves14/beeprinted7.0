class AvaliacoesController < ApplicationController
	def show
		orcamento = Orcamento.find_by(identificador: params[:pedido])
		modelagem = Modeling.find_by(identificador: params[:pedido])
		adicionado = Adicionado.find_by(identificador: params[:pedido])
		if orcamento
			@pedido = orcamento
		elsif modelagem
			@pedido = modelagem
		elsif adicionado
			@pedido = adicionado
		end
		@pedido.avaliacao = 5
	end

	def update
		identificador = params[:id]
		orcamento = Orcamento.find_by(identificador: identificador)
		modelagem = Modeling.find_by(identificador: identificador)
		adicionado = Adicionado.find_by(identificador: identificador)
		if orcamento
			@pedido = orcamento
			params = upload_params
		elsif modelagem
			@pedido = modelagem
			params = modelagem_params
		elsif adicionado
			@pedido = adicionado
			params = adicionado_params
		end
		if @pedido.update(params)
			if @pedido.avaliacao
				flash[:success] = "Muito Obrigado pelo seu Feedback!"
	      		redirect_to(root_path)
	      	else
	      		flash.now[:alert] = "Por favor preencha o formulário antes de enviar"
	      		render :show
	      	end
		else
			flash.now[:alert] = "Algo de errado ocorreu!"
	      	render :show
		end

	end


	private

	def upload_params
    	params.require(:orcamento).permit(:avaliacao, :avaliacao_txt)
  	end

  	def modelagem_params
    	params.require(:modeling).permit(:avaliacao, :avaliacao_txt)
  	end
  	def adicionado_params
    	params.require(:adicionado).permit(:avaliacao, :avaliacao_txt)
  	end
end
