class ContatosController < ApplicationController
	def create
		@contato = Contato.create(contato_params)
		if @contato.save
			flash[:success] = "Seu pedido de contato foi enviado! Em breve, entraremos em contato por email."
			redirect_back fallback_location: root_path
		else
			flash[:alert] = "Seu pedido de contato não pôde ser salvo! Por favor, cheque o formulário."
			redirect_back fallback_location: root_path
		end
	end

	private
	def contato_params
    	params.require(:contato).permit(:name, :email, :mensagem)
  	end



end
