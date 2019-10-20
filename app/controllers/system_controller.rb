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
		if params[:format] != "pdf"
			if !@upload.items.any?
				@upload.arquivos.each do |arquivo|
					@item = @upload.items.build
					@item.name = File.basename(arquivo.attachment.url)
				end
			end
		end
		@orcamento = @upload
		respond_to do |format|
		  format.html
		  format.pdf do 
		  	render pdf: "#{@upload.identificador}",
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
			path = system_upload_path(@orcamento, format: "pdf")
		end
		if tipo == "Modeling"
			@orcamento = Modeling.find(id)
			params = modelagem_params
			path = system_modelagem_path(@orcamento, format: "pdf")
		end
		if tipo == "Adicionado"
			@orcamento = Adicionado.find(id)
			params = adicionado_params
			path = system_adicionado_path(@orcamento, format: "pdf")
		end

	    if @orcamento.update(params)
	      if calculo

#############################    PARTE ITEMS    ################################
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


#############################    PARTE SERVIÇOS    ################################

			if @orcamento.servicos.any?
	      		@orcamento.servicos.each do |servico|
	      			servico.valor = servico.valor_unit*servico.quantidade
	      			servico.save
	      			@orcamento.valor = @orcamento.valor + servico.valor 
	      		end

	      	end
	      end

#############################    FIM    ################################


	      if @orcamento.save
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
		if params[:format] != "pdf"
			if !@modelagem.items.any?
				@item = @modelagem.items.build
			end
			if !@modelagem.servicos.any?
				@servico1 = @modelagem.servicos.build
				@servico1.name = "Design 3D"
				@servico1.prazo = 3
				@servico2 = @modelagem.servicos.build
				@servico2.name = "Impressão 3D"
				@servico2.prazo = 4
			end
		end
		@orcamento = @modelagem
		respond_to do |format|
		  format.html
		  format.pdf do 
		  	render pdf: "#{@modelagem.identificador}",
		  	template: "system/upload_pdf.html.erb",
		  	layout: false
		  end
		end
	end


	def adicionado
    	@adicionado = Adicionado.find(params[:id])
    	if params[:format] != "pdf"
			if !@adicionado.items.any?
				@item = @adicionado.items.build
			end
		end
		@orcamento = @adicionado
		respond_to do |format|
		  format.html
		  format.pdf do 
		  	render pdf: "#{@adicionado.identificador}",
		  	template: "system/upload_pdf.html.erb",
		  	layout: false
		  end
		end
  	end



	private

	def upload_params
    	params.require(:orcamento).permit(:status, :dataretorno, :dataultimo, :tempo_impressao, :tempo_setup, :frete, :prazo_orc, :prazo_desejado, :tempo_execucao, :valor,
    	items_attributes:[:id,:name,:tempo,:massa,:valor_unit,:quantidade,:valor,:resolucao,:infill,:cor,:material,:_destroy],
    	servicos_attributes:[:id, :name, :valor_unit,:quantidade, :valor, :prazo,:_destroy])
  	end

  	def modelagem_params
    	params.require(:modeling).permit(:status, :dataretorno, :dataultimo, :tempo_impressao, :tempo_setup, :frete, :prazo_orc, :prazo_desejado, :tempo_execucao, :valor, 
    		items_attributes:[:id,:name,:tempo,:massa,:valor_unit,:quantidade,:valor,:resolucao,:infill,:cor,:material,:_destroy],
    		servicos_attributes:[:id, :name, :valor_unit, :quantidade, :valor, :prazo,:_destroy])
  	end
  	def adicionado_params
    	params.require(:adicionado).permit(:status, :dataretorno, :dataultimo, :tempo_impressao, :tempo_setup, :frete, :prazo_orc, :prazo_desejado, :tempo_execucao, :valor, 
    		items_attributes:[:id,:name,:tempo,:massa,:valor_unit,:quantidade,:valor,:resolucao,:infill,:cor,:material,:_destroy],
    		servicos_attributes:[:id, :name, :valor_unit, :quantidade, :valor, :prazo,:_destroy])
  	end


	def admin
    unless current_user.admin
      flash[:alert] = "Acesso negado!"
      redirect_to root_path
    end
  	end
end
