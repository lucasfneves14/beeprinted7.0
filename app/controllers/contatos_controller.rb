class ContatosController < ApplicationController
	
	def sucesso

	end

	def create
		@contato = Contato.create(contato_params)

		@mes = Date.today.strftime("%m")
    	@ano = Date.today.strftime("%Y")

    	@orcamentos = Orcamento.where('extract(month  from created_at) = ?', @mes)
    	@modelagens = Modeling.where('extract(month  from created_at) = ?', @mes)
    	@adicionados = Adicionado.where('extract(month  from created_at) = ?', @mes)
    	@planilha = (@modelagens + @orcamentos + @adicionados).sort{|a,b| a.created_at <=> b.created_at }

    	identificador = (@ano.to_i*100 + @mes.to_i)*1000 + @planilha.count + 1



		@adicionado = Adicionado.new(name: @contato.name, email: @contato.email,estado: "-", description: @contato.mensagem, responsavel: "Iago", identificador: identificador, canal: "Contato")
		puts @contato.captcha


		if @contato.save && @adicionado.save(validate: false)
			@adicionado.data = @contato.created_at.strftime("%d/%m/%Y")
			@adicionado.save
			ContatoMailer.contato_email(@contato, @adicionado.identificador).deliver
			flash[:success] = "Seu pedido de contato foi enviado! Em breve, entraremos em contato por email."
			redirect_to contato_sucesso_path
		else
			flash[:alert] = "Seu pedido de contato não pôde ser salvo! Por favor, cheque o formulário."
			redirect_back fallback_location: root_path
		end
	end

	private
	def contato_params
    	params.require(:contato).permit(:name, :email, :mensagem, :captcha)
  	end



end
