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
		if @upload.items.any?
			
		else
			@upload.arquivos.each do |arquivo|
				@item = @upload.items.build
				@item.name = File.basename(arquivo.attachment.url)
			end
		end
		respond_to do |format|
		  format.html
		  format.pdf do 
		  	render pdf: "teste",
		  	template: "system/upload_pdf.html.erb",
		  	layout: false
		  end
		end
	end

	def update
		tipo = params[:tipo]
		id = params[:id]
		calculo = params[:calculo]
		if tipo == "Orcamento"
			@orcamento = Orcamento.find(params[:id])
			params = upload_params
			path = system_upload_path(@orcamento)
		end
		if tipo == "Modeling"
			@orcamento = Orcamento.find(id)
			params = modelagem_params
			path = system_modelagem_path(@orcamento)
		end
		if tipo == "Adicionado"
			@orcamento = Adicionado.find(id)
			params = adicionado_params
			path = system_adicionado_path(@orcamento)
		end

	    if @orcamento.update(params)
	      puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
	      if calculo
	      	puts 'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBb'
	      	tempo = 0
	      	@orcamento.items.each do |item|
	      		tempo = tempo + item.tempo*item.quantidade
	      	end
	      	@orcamento.tempo_impressao = tempo/60
	      	taxa = 0
	      	if tempo > 1000
	      		taxa = 0.05
	      		if tempo > 2500
	      			taxa = 0.1
	      			if tempo > 5000
	      				taxa = 0.15
	      				if tempo > 10000
	      					taxa = 0.3
	      					if tempo > 15000
	      						taxa = 0.4
	      					end
	      				end
	      			end
	      		end
	      	end
	      	total = 0
	      	@orcamento.items.each do |item|
	      		item.valor_unit = item.tempo*0.24*(1-taxa) + item.massa*0.28
	      		item.valor = item.valor_unit*item.quantidade
	      		total = total + item.valor
	      		item.save
	      	end

	      	@orcamento.valor = total + @orcamento.frete
	      end
	      if @orcamento.save
		      flash[:success] = "Orçamento Editado!"
		      redirect_to(path)
		   else
		   	 	flash.now[:alert] = "Edição falhou! por favor cheque o formulário"
	      		render :upload
	      	end	
	    else
	      flash.now[:alert] = "Edição falhou! por favor cheque o formulário"
	      render :upload
	    end
	end


	def modelagem
		@modelagem = Modeling.find(params[:id])
	end


	def adicionado
    	@adicionado = Adicionado.find(params[:id])
  	end



	private

	def upload_params
    	params.require(:orcamento).permit(:status, :dataretorno, :dataultimo, :tempo_impressao, :tempo_setup, :frete, :prazo, :prazo_desejado, :tempo_execucao, :valor, items_attributes:[:id,:name,:tempo,:massa,:valor_unit,:quantidade,:valor,:resolucao,:infill,:cor,:material,:_destroy])
  	end

  	def modelagem_params
    	params.require(:modeling).permit(:status, :dataretorno, :dataultimo)
  	end
  	def adicionado_params
    	params.require(:adicionado).permit(:status, :dataretorno, :dataultimo)
  	end


	def admin
    unless current_user.admin
      flash[:alert] = "Acesso negado!"
      redirect_to root_path
    end
  	end
end
