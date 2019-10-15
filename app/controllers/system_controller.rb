class SystemController < ApplicationController
	before_action :authenticate_user!, raise: false
	before_action :admin
	layout 'system/navbar'
	def index
		if params[:mes]
			@mes = params[:mes]
		else
			@mes = Date.today.strftime("%m")
		end 
		@orcamentos = Orcamento.where('extract(month  from created_at) = ?', @mes)
		@modelagens = Modeling.where('extract(month  from created_at) = ?', @mes)
		@adicionados = Adicionado.where('extract(month  from created_at) = ?', @mes)
		@planilha = (@modelagens + @orcamentos + @adicionados).sort{|a,b| a.created_at <=> b.created_at }
		@contatos = Contato.where('extract(month  from created_at) = ?', @mes)
		@adicionado = Adicionado.new
		
		@mes_num = @mes
		if @mes=="1"
			@mes="Janeiro"
		elsif @mes=="2"
			@mes="Fevereiro"
		elsif @mes=="3"
			@mes="Março"
		elsif @mes=="4"
			@mes="Abril"
		elsif @mes=="5"
			@mes="Maio"
		elsif @mes=="6"
			@mes="Junho"
		elsif @mes=="7"
			@mes="Julho"
		elsif @mes=="8"
			@mes="Agosto"
		elsif @mes=="9"
			@mes="Setembro"
		elsif @mes=="10"
			@mes="Outubro"
		elsif @mes=="11"
			@mes="Novembro"
		elsif @mes=="12"
			@mes="Dezembro"	
		end
	end

	def uploads
		if params[:mes]
			@mes = params[:mes]
		else
			@mes = Date.today.strftime("%m")
		end
		if params[:tudo] 
			@orcamentos = Orcamento.all
		else
			@orcamentos = Orcamento.where('extract(month  from created_at) = ?', @mes)
		end

		@adicionado = Adicionado.new

		@mes_num = @mes

		if @mes=="1"
			@mes="Janeiro"
		elsif @mes=="2"
			@mes="Fevereiro"
		elsif @mes=="3"
			@mes="Março"
		elsif @mes=="4"
			@mes="Abril"
		elsif @mes=="5"
			@mes="Maio"
		elsif @mes=="6"
			@mes="Junho"
		elsif @mes=="7"
			@mes="Julho"
		elsif @mes=="8"
			@mes="Agosto"
		elsif @mes=="9"
			@mes="Setembro"
		elsif @mes=="10"
			@mes="Outubro"
		elsif @mes=="11"
			@mes="Novembro"
		elsif @mes=="12"
			@mes="Dezembro"	
		end


		respond_to do |format|
		  format.html
		  format.xls
		end


	end



	def modelagens
		if params[:mes]
			@mes = params[:mes]
		else
			@mes = Date.today.strftime("%m")
		end
		if params[:tudo]
			@modelagens = Modeling.all
		else
			@modelagens = Modeling.where('extract(month  from created_at) = ?', @mes)
		end


		@adicionado = Adicionado.new
		
		@mes_num = @mes

		
		if @mes=="1"
			@mes="Janeiro"
		elsif @mes=="2"
			@mes="Fevereiro"
		elsif @mes=="3"
			@mes="Março"
		elsif @mes=="4"
			@mes="Abril"
		elsif @mes=="5"
			@mes="Maio"
		elsif @mes=="6"
			@mes="Junho"
		elsif @mes=="7"
			@mes="Julho"
		elsif @mes=="8"
			@mes="Agosto"
		elsif @mes=="9"
			@mes="Setembro"
		elsif @mes=="10"
			@mes="Outubro"
		elsif @mes=="11"
			@mes="Novembro"
		elsif @mes=="12"
			@mes="Dezembro"	
		end


		respond_to do |format|
		  format.html
		  format.xls
		end


	end


	def upload
		@upload = Orcamento.find(params[:id])
	end


	def modelagem
		@modelagem = Modeling.find(params[:id])
	end

	def adicionado
    	@adicionado = Adicionado.find(params[:id])
  	end



	private
	def admin
    unless current_user.admin
      flash[:alert] = "Acesso negado!"
      redirect_to root_path
    end
  	end
end
