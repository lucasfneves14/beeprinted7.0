class SystemController < ApplicationController
	before_action :authenticate_user!, raise: false
	before_action :admin
	layout 'system/navbar'
	def index
		if params[:mes]
			@mes = params[:mes]
			@ano = params[:ano]
		else
			@mes = Date.today.strftime("%m")
			@ano = Date.today.strftime("%Y")
		end 

		if params[:email]
			@sem_mes = true
			email = params[:email]
			@orcamentos = Orcamento.where(email: email)
			@modelagens = Modeling.where(email: email)
			@adicionados = Adicionado.where(email: email)
		elsif params[:name]
			@sem_mes = true
			name = params[:name]
			@orcamentos = Orcamento.where("name || ' ' || sobrenome ILIKE ?", "#{name}")
			@modelagens = Modeling.where("name || ' ' || sobrenome ILIKE ?", "#{name}")
			@adicionados = Adicionado.where("name || ' ' ILIKE ?", "#{name}")
		elsif params[:query]
			@sem_mes = true
			query = params[:query]
			@orcamentos = Orcamento.where("'#' || identificador || ' ' || email || ' ' || name || ' ' || sobrenome ILIKE ?", "%#{query}%")
			@modelagens = Modeling.where("'#' || identificador || ' ' || email || ' ' || name || ' ' || sobrenome ILIKE ?", "%#{query}%")
			@adicionados = Adicionado.where("'#' || identificador || ' ' || email || ' ' || name || ' ' ILIKE ?", "%#{query}%")
		else
			@orcamentos = Orcamento.where('extract(month  from created_at) = ?', @mes).where('extract(YEAR  from created_at) = ?', @ano)
			@modelagens = Modeling.where('extract(month  from created_at) = ?', @mes).where('extract(YEAR  from created_at) = ?', @ano)
			@adicionados = Adicionado.where('extract(month  from created_at) = ?', @mes).where('extract(YEAR  from created_at) = ?', @ano)
		end

		if params[:responsavel]
			@orcamentos = @orcamentos.where(responsavel: params[:responsavel])
			@modelagens = @modelagens.where(responsavel: params[:responsavel])
			@adicionados = @adicionados.where(responsavel: params[:responsavel])
		end

		if params[:status]
			@orcamentos = @orcamentos.where(status: params[:status])
			@modelagens = @modelagens.where(status: params[:status])
			@adicionados = @adicionados.where(status: params[:status])
		end



		@planilha = (@modelagens + @orcamentos + @adicionados).sort{|a,b| a.identificador <=> b.identificador }.reverse
		
		@adicionado = Adicionado.new
		
		@mes_num = @mes
		if @mes=="01"
			@mes="Janeiro"
		elsif @mes=="02"
			@mes="Fevereiro"
		elsif @mes=="03"
			@mes="Março"
		elsif @mes=="04"
			@mes="Abril"
		elsif @mes=="05"
			@mes="Maio"
		elsif @mes=="06"
			@mes="Junho"
		elsif @mes=="07"
			@mes="Julho"
		elsif @mes=="08"
			@mes="Agosto"
		elsif @mes=="09"
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
		  format.xls { headers["Content-Disposition"] = "attachment; filename=\"relatorio_system_#{@mes_num}.xls\"" }
		end


	end




	def localizacao

		@mes = params[:mes]
		@ano = params[:ano]

		@estados = Array.new

		@fechado = params[:fechado]
		@conversao = params[:conversao]
		@faturamento = params[:faturamento]
		@orcamentos = Orcamento.where('extract(month  from created_at) = ?', @mes).where('extract(YEAR  from created_at) = ?', @ano).where.not(status: 'Cancelado')
		@modelagens = Modeling.where('extract(month  from created_at) = ?', @mes).where('extract(YEAR  from created_at) = ?', @ano).where.not(status: 'Cancelado')
		@adicionados = Adicionado.where('extract(month  from created_at) = ?', @mes).where('extract(YEAR  from created_at) = ?', @ano).where.not(status: 'Cancelado')

		@planilha = (@modelagens + @orcamentos + @adicionados).sort{|a,b| a.created_at <=> b.created_at }
		estados_nomes = ["Acre", "Alagoas", "Amapá", "Amazonas", "Bahia", "Ceará", "Distrito Federal", 
			"Espírito Santo", "Goiás", "Maranhão", "Mato Grosso", "Mato Grosso do Sul", "Minas Gerais",
			"Pará", "Paraíba", "Paraná", "Pernambuco", "Piauí", "Rio de Janeiro", "Rio Grande do Norte",
			"Rio Grande do Sul", "Rondônia", "Roraima",  "Santa Catarina", "São Paulo", "Sergipe", "Tocantins",""]

		@siglas = ["BR-AC","BR-AL","BR-AP","BR-AM","BR-BA","BR-CE","BR-DF","BR-ES","BR-GO","BR-MA","BR-MT","BR-MS",
			"BR-MG","BR-PA","BR-PB","BR-PR","BR-PE","BR-PI","BR-RJ","BR-RN","BR-RS","BR-RO","BR-RR","BR-SC",
			"BR-SP","BR-SE","BR-TO",""]


		estados_nomes.each_with_index do |nome,index|
			estado = Estado.new
			if nome == ""
				estado.name = "|Sem Estado|"
			else
				estado.name = nome
			end
			fechados = @planilha.select{|orcamento| (orcamento.estado == nome)&&((orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Finalizado")||(orcamento.status == "Produzindo"))}
			estado.faturamento = 0
			fechados.each do |fechado|
				estado.faturamento = estado.faturamento + fechado.valor
			end
			estado.faturamento = '%.2f' % estado.faturamento
			estado.fechado = fechados.count
			estado.pedido = @planilha.select{|orcamento| (orcamento.estado == nome)}.count
			if estado.fechado == 0
				estado.conversao = 0
			else
				estado.conversao = ((Float(estado.fechado)/estado.pedido)*100).round(1)
			end
			estado.sigla = @siglas[index]
			@estados << estado
		end

		@estados = @estados.sort {|a, b| a[:pedido] <=> b[:pedido]}.reverse
		if @fechado
			@estados = @estados.sort {|a, b| a[:fechado] <=> b[:fechado]}.reverse
		elsif @conversao 
			@estados = @estados.sort {|a, b| a[:conversao] <=> b[:conversao]}.reverse
		elsif @faturamento 
			@estados = @estados.sort {|a, b| a[:faturamento] <=> b[:faturamento]}.reverse
		end




		@mes_num = @mes
		if @mes=="01"
			@mes="Janeiro"
		elsif @mes=="02"
			@mes="Fevereiro"
		elsif @mes=="03"
			@mes="Março"
		elsif @mes=="04"
			@mes="Abril"
		elsif @mes=="05"
			@mes="Maio"
		elsif @mes=="06"
			@mes="Junho"
		elsif @mes=="07"
			@mes="Julho"
		elsif @mes=="08"
			@mes="Agosto"
		elsif @mes=="09"
			@mes="Setembro"
		elsif @mes=="10"
			@mes="Outubro"
		elsif @mes=="11"
			@mes="Novembro"
		elsif @mes=="12"
			@mes="Dezembro"	
		end

	end

	def farol

		######### GERAL (ATUAL) #########

		@mes = params[:mes].to_i
		@ano = params[:ano].to_i

		orcamentos = Orcamento.where('extract(month  from created_at) = ?', @mes).where('extract(YEAR  from created_at) = ?', @ano).where.not(status: 'Cancelado')
		modelagens = Modeling.where('extract(month  from created_at) = ?', @mes).where('extract(YEAR  from created_at) = ?', @ano).where.not(status: 'Cancelado')
		adicionados = Adicionado.where('extract(month  from created_at) = ?', @mes).where('extract(YEAR  from created_at) = ?', @ano).where.not(status: 'Cancelado')

		planilha = (modelagens + orcamentos + adicionados).sort{|a,b| a.created_at <=> b.created_at }

		@atendimentos = planilha.count
		
		if @atendimentos == 0
			@propostas = 0
			@propostas_por = 0
			@atrasados = 0
		else
			@propostas_por = '%.2f' %  ((Float(planilha.select{|orcamento| (orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado")}.count) / @atendimentos) * 100)
			@propostas = '%.2f' %  ((Float(planilha.select{|orcamento| ((orcamento.status == "No Bid")&&(orcamento.proposta_enviada))||(orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado")||(orcamento.status == "Proposta Env") || (orcamento.status == "Negociação")}.count) / @atendimentos) * 100)
			@atrasados = planilha.select{|orcamento| (orcamento.dataretorno!= "-")&&((DateTime.parse(orcamento.dataretorno).strftime('%a, %b %d %H:%M:%S %Z').to_time - orcamento.created_at) < 2.days)}.count
			@atrasados = '%.2f' % ((Float(@atrasados)/planilha.select{|orcamento| (orcamento.status != 'New')}.count)*100)
		end
		@convertidos = (planilha.select{|orcamento| (orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado")}.count)

		@vendidos = 0.0

		planilha.select{|orcamento| ((orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado"))&&(orcamento.valor!=nil)}.each do |planilha|
			@vendidos = @vendidos + planilha.valor
		end

		if @convertidos == 0
			@ticket_medio = 0
		else
			@ticket_medio = '%.2f' % (@vendidos/@convertidos)
		end

		########## THIAGO #########

			@vendidos_thiago = @vendidos
			@convertidos_thiago = @convertidos

		####################################

		@vendidos = '%.2f' % @vendidos


		############# Avaliacao ########################
		avaliacao_total = 0
		planilha.select{|orcamento| (orcamento.avaliacao != nil)}.each do |planilha|
			avaliacao_total = avaliacao_total + orcamento.avaliacao
		end
		@avaliacao_count = planilha.select{|orcamento| (orcamento.avaliacao != nil)}.count
		if @avaliacao_count == 0
			@avaliacao_media = 0
		else
			@avaliacao_media = avaliacao_total/@avaliacao_count
		end



##########################################################################################################################

		######### THIERRE e IAGO (ATUAL) #########

		planilha = planilha.select{|orcamento| (orcamento.responsavel == "Iago")}

		@atendimentos_iago = planilha.count

		if @atendimentos_iago == 0
			@propostas_iago = 0
			@atrasados_iago = 0
			@propostas_por_iago = 0
		else
			@propostas_por_iago = '%.2f' %  ((Float(planilha.select{|orcamento| (orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado")}.count) / @atendimentos_iago) * 100)
			@propostas_iago = '%.2f' %  ((Float(planilha.select{|orcamento| ((orcamento.status == "No Bid")&&(orcamento.proposta_enviada))||(orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado")||(orcamento.status == "Proposta Env") || (orcamento.status == "Negociação")}.count) / planilha.count) * 100)
			@atrasados_iago = planilha.select{|orcamento| (orcamento.dataretorno!= "-")&&((DateTime.parse(orcamento.dataretorno).strftime('%a, %b %d %H:%M:%S %Z').to_time - orcamento.created_at) < 2.days)}.count
			@atrasados_iago = '%.2f' % ((Float(@atrasados_iago)/planilha.select{|orcamento| (orcamento.status != 'New')}.count)*100)
		end

		@convertidos_iago = (planilha.select{|orcamento| (orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado")}.count)

		@vendidos_iago = 0.0

		planilha.select{|orcamento| ((orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado"))&&(orcamento.valor!=nil)}.each do |planilha|
			@vendidos_iago = @vendidos_iago + planilha.valor
		end

		if @convertidos_iago == 0
			@ticket_medio_iago = 0
		else
			@ticket_medio_iago = '%.2f' % (@vendidos_iago/@convertidos_iago)
		end

		########## THIAGO #########

			@vendidos_thiago = @vendidos_thiago - @vendidos_iago
			@convertidos_thiago = @convertidos_thiago - @convertidos_iago

		#######################################

		@vendidos_iago = '%.2f' % @vendidos_iago




		planilha = (modelagens + orcamentos + adicionados).sort{|a,b| a.created_at <=> b.created_at }
		planilha = planilha.select{|orcamento| (orcamento.responsavel == "Thierre")}

		@atendimentos_thierre = planilha.count

		if @atendimentos_thierre == 0
			@propostas_thierre = 0
			@atrasados_thierre = 0
			@propostas_por_thierre = 0
		else
			@propostas_por_thierre = '%.2f' %  ((Float(planilha.select{|orcamento| (orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado")}.count) / @atendimentos_thierre) * 100)
			@propostas_thierre = '%.2f' %  ((Float(planilha.select{|orcamento| ((orcamento.status == "No Bid")&&(orcamento.proposta_enviada))||(orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado")||(orcamento.status == "Proposta Env") || (orcamento.status == "Negociação")}.count) / planilha.count) * 100)
			@atrasados_thierre = planilha.select{|orcamento| (orcamento.dataretorno!= "-")&&((DateTime.parse(orcamento.dataretorno).strftime('%a, %b %d %H:%M:%S %Z').to_time - orcamento.created_at) < 2.days)}.count
			@atrasados_thierre = '%.2f' % ((Float(@atrasados_thierre)/planilha.select{|orcamento| (orcamento.status != 'New')}.count)*100)
		end

		@convertidos_thierre = (planilha.select{|orcamento| (orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado")}.count)

		@vendidos_thierre = 0.0

		planilha.select{|orcamento| ((orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado"))&&(orcamento.valor!=nil)}.each do |planilha|
			@vendidos_thierre = @vendidos_thierre + planilha.valor
		end

		if @convertidos_thierre == 0
			@ticket_medio_thierre = 0
		else
			@ticket_medio_thierre = '%.2f' % (@vendidos_thierre/@convertidos_thierre)
		end

		########## THIAGO #########

			@vendidos_thiago = @vendidos_thiago - @vendidos_thierre
			@convertidos_thiago = @convertidos_thiago - @convertidos_thierre

			if @convertidos_thiago == 0
				@ticket_medio_thiago = 0
			else
				@ticket_medio_thiago = '%.2f' % (@vendidos_thiago/@convertidos_thiago)
			end

			@vendidos_thiago = '%.2f' % @vendidos_thiago

		###########################################

		@vendidos_thierre = '%.2f' % @vendidos_thierre




######################################################################################################################################
		
		######### GERAL (ANTERIOR) #########
		if @mes == 1
			orcamentos = Orcamento.where('extract(month  from created_at) = ?', 12).where('extract(YEAR  from created_at) = ?', @ano-1).where.not(status: 'Cancelado')
			modelagens = Modeling.where('extract(month  from created_at) = ?', 12).where('extract(YEAR  from created_at) = ?', @ano-1).where.not(status: 'Cancelado')
			adicionados = Adicionado.where('extract(month  from created_at) = ?', 12).where('extract(YEAR  from created_at) = ?', @ano-1).where.not(status: 'Cancelado')
		else
			orcamentos = Orcamento.where('extract(month  from created_at) = ?', @mes-1).where('extract(YEAR  from created_at) = ?', @ano).where.not(status: 'Cancelado')
			modelagens = Modeling.where('extract(month  from created_at) = ?', @mes-1).where('extract(YEAR  from created_at) = ?', @ano).where.not(status: 'Cancelado')
			adicionados = Adicionado.where('extract(month  from created_at) = ?', @mes-1).where('extract(YEAR  from created_at) = ?', @ano).where.not(status: 'Cancelado')

		end

		planilha = (modelagens + orcamentos + adicionados).sort{|a,b| a.created_at <=> b.created_at }

		@atendimentos_ant = planilha.count
		
		if @atendimentos_ant == 0
			@propostas_ant = 0
			@propostas_por_ant = 0
			@atrasados_ant = 0
		else
			@propostas_por_ant = '%.2f' %  ((Float(planilha.select{|orcamento| (orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado")}.count) / @atendimentos_ant) * 100)
			@propostas_ant = '%.2f' %  ((Float(planilha.select{|orcamento| ((orcamento.status == "No Bid")&&(orcamento.proposta_enviada))||(orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado")||(orcamento.status == "Proposta Env") || (orcamento.status == "Negociação")}.count) / @atendimentos_ant) * 100)
			@atrasados_ant = planilha.select{|orcamento| (orcamento.dataretorno!= "-")&&((DateTime.parse(orcamento.dataretorno).strftime('%a, %b %d %H:%M:%S %Z').to_time - orcamento.created_at) < 2.days)}.count
			@atrasados_ant = '%.2f' % ((Float(@atrasados_ant)/planilha.select{|orcamento| (orcamento.status != 'New')}.count)*100)
		end
		@convertidos_ant = (planilha.select{|orcamento| (orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado")}.count)

		@vendidos_ant = 0.0

		planilha.select{|orcamento| ((orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado"))&&(orcamento.valor!=nil)}.each do |planilha|
			@vendidos_ant = @vendidos_ant + planilha.valor
		end

		if @convertidos_ant == 0
			@ticket_medio_ant = 0
		else
			@ticket_medio_ant = '%.2f' % (@vendidos_ant/@convertidos_ant)
		end

		########## THIAGO #########
			@vendidos_ant_thiago = @vendidos_ant
			@convertidos_ant_thiago = @convertidos_ant
		#############################


		@vendidos_ant = '%.2f' % @vendidos_ant


		############# Avaliacao ########################
		avaliacao_total_ant = 0
		planilha.select{|orcamento| (orcamento.avaliacao != nil)}.each do |planilha|
			avaliacao_total_ant = avaliacao_total_ant + orcamento.avaliacao
		end
		@avaliacao_count_ant = planilha.select{|orcamento| (orcamento.avaliacao != nil)}.count
		if @avaliacao_count_ant == 0
			@avaliacao_media_ant = 0
		else
			@avaliacao_media_ant = avaliacao_total_ant/@avaliacao_count_ant
		end

		

##########################################################################################################################################

		######### THIERRE e IAGO (ANTERIOR) #########

		planilha = planilha.select{|orcamento| (orcamento.responsavel == "Iago")}

		@atendimentos_ant_iago = planilha.count

		if @atendimentos_ant_iago == 0
			@propostas_iago_ant = 0
			@atrasados_iago_ant = 0
			@propostas_por_ant_iago = 0
		else
			@propostas_por_ant_iago = '%.2f' %  ((Float(planilha.select{|orcamento| (orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado")}.count) / @atendimentos_ant_iago) * 100)
			@propostas_iago_ant = '%.2f' %  ((Float(planilha.select{|orcamento| ((orcamento.status == "No Bid")&&(orcamento.proposta_enviada))||(orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado")||(orcamento.status == "Proposta Env") || (orcamento.status == "Negociação")}.count) / planilha.count) * 100)
			@atrasados_iago_ant = planilha.select{|orcamento| (orcamento.dataretorno!= "-")&&((DateTime.parse(orcamento.dataretorno).strftime('%a, %b %d %H:%M:%S %Z').to_time - orcamento.created_at) < 2.days)}.count
			@atrasados_iago_ant = '%.2f' % ((Float(@atrasados_iago_ant)/planilha.select{|orcamento| (orcamento.status != 'New')}.count)*100)
		end
		@convertidos_ant_iago = (planilha.select{|orcamento| (orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado")}.count)

		@vendidos_ant_iago = 0.0

		planilha.select{|orcamento| ((orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado"))&&(orcamento.valor!=nil)}.each do |planilha|
			@vendidos_ant_iago = @vendidos_ant_iago + planilha.valor
		end

		if @convertidos_ant_iago == 0
			@ticket_medio_ant_iago = 0
		else
			@ticket_medio_ant_iago = '%.2f' % (@vendidos_ant_iago/@convertidos_ant_iago)
		end

		########## THIAGO #########
			@vendidos_ant_thiago = @vendidos_ant_thiago - @vendidos_ant_iago
			@convertidos_ant_thiago = @convertidos_ant_thiago - @convertidos_ant_iago
		####################################

		@vendidos_ant_iago = '%.2f' % @vendidos_ant_iago


		planilha = (modelagens + orcamentos + adicionados).sort{|a,b| a.created_at <=> b.created_at }
		planilha = planilha.select{|orcamento| (orcamento.responsavel == "Thierre")}

		@atendimentos_ant_thierre = planilha.count

		if @atendimentos_ant_thierre == 0
			@propostas_thierre_ant = 0
			@atrasados_thierre_ant = 0
			@propostas_por_ant_thierre = 0
		else
			@propostas_por_ant_thierre = '%.2f' %  ((Float(planilha.select{|orcamento| (orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado")}.count) / @atendimentos_ant_thierre) * 100)
			@propostas_thierre_ant = '%.2f' %  ((Float(planilha.select{|orcamento| ((orcamento.status == "No Bid")&&(orcamento.proposta_enviada))||(orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado")||(orcamento.status == "Proposta Env") || (orcamento.status == "Negociação")}.count) / planilha.count) * 100)
			@atrasados_thierre_ant = planilha.select{|orcamento| (orcamento.dataretorno!= "-")&&((DateTime.parse(orcamento.dataretorno).strftime('%a, %b %d %H:%M:%S %Z').to_time - orcamento.created_at) < 2.days)}.count
			@atrasados_thierre_ant = '%.2f' % ((Float(@atrasados_thierre_ant)/planilha.select{|orcamento| (orcamento.status != 'New')}.count)*100)
		end

		@convertidos_ant_thierre = (planilha.select{|orcamento| (orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado")}.count)

		@vendidos_ant_thierre = 0.0

		planilha.select{|orcamento| ((orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado"))&&(orcamento.valor!=nil)}.each do |planilha|
			@vendidos_ant_thierre = @vendidos_ant_thierre + planilha.valor
		end


		if @convertidos_ant_thierre == 0
			@ticket_medio_ant_thierre = 0
		else
			@ticket_medio_ant_thierre = '%.2f' % (@vendidos_ant_thierre/@convertidos_ant_thierre)
		end

		########## THIAGO #########
			@vendidos_ant_thiago = @vendidos_ant_thiago - @vendidos_ant_thierre
			@convertidos_ant_thiago = @convertidos_ant_thiago - @convertidos_ant_thierre

			if @convertidos_ant_thiago == 0
				@ticket_medio_ant_thiago = 0
			else
				@ticket_medio_ant_thiago = '%.2f' % (@vendidos_ant_thiago/@convertidos_ant_thiago)
			end


			@vendidos_ant_thiago = '%.2f' % @vendidos_ant_thiago
		####################################

		@vendidos_ant_thierre = '%.2f' % @vendidos_ant_thierre

##########################################################################################################################
		
		########### METAS ##############

		@propostas_iago_meta = 20
		@propostas_thierre_meta = 80
		@atrasados_iago_meta = 85
		@atrasados_thierre_meta = 70
		@vendidos_meta_iago = 15000
		@vendidos_meta_thierre = 10000
		@vendidos_meta_thiago = 2000
		@atendimentos_meta_iago = 150
		@atendimentos_meta_thierre = 110
		@convertidos_meta_iago = 10
		@convertidos_meta_thierre = 20
		@convertidos_meta_thiago = 5
		@propostas_por_meta_iago = 10
		@propostas_por_meta_thierre = 10
		@ticket_medio_meta_iago = 1000
		@ticket_medio_meta_thierre = 500
		@ticket_medio_meta_thiago = 500

		@avaliacao_count_meta = 10
		@avaliacao_media_meta = 8


		@atendimentos_meta = 360
		@propostas_meta = 60
		@propostas_por_meta = 10
		@convertidos_meta = 30
		@vendidos_meta = 25000
		@ticket_medio_meta = 850
		@atrasados_meta = 80






		@mes_num = @mes
		if @mes==1
			@mes="Janeiro"
		elsif @mes==2
			@mes="Fevereiro"
		elsif @mes==3
			@mes="Março"
		elsif @mes==4
			@mes="Abril"
		elsif @mes==5
			@mes="Maio"
		elsif @mes==6
			@mes="Junho"
		elsif @mes==7
			@mes="Julho"
		elsif @mes==8
			@mes="Agosto"
		elsif @mes==9
			@mes="Setembro"
		elsif @mes==10
			@mes="Outubro"
		elsif @mes==11
			@mes="Novembro"
		elsif @mes==12
			@mes="Dezembro"	
		end

	end


	def usuarios
		@planilha1 = Orcamento.where.not(email:nil).where.not(status: "Cancelado") + Modeling.where.not(email:nil).where.not(status: "Cancelado") + Adicionado.where.not(email:nil).where.not(status: "Cancelado")
		@planilha = @planilha1.group_by{|d| d[:email]}.sort{|a,b| a[1].count <=> b[1].count}.reverse.first(15)


		@planilha2 = @planilha1.select{|orcamento| ((orcamento.status == "Fechado")||(orcamento.status == "Entregue")||(orcamento.status == "Produzindo")||(orcamento.status == "Finalizado"))}
		#@planilha2 = Orcamento.where.not(email:nil).where(status: "Fechado") + Modeling.where.not(email:nil).where(status: "Fechado") + Adicionado.where.not(email:nil).where(status: "Fechado")
		@planilha2 = @planilha2.group_by{|d| d[:email]}.sort{|a,b| a[1].count <=> b[1].count}.reverse.first(15)
	end


	def edit
		@orcamento = Orcamento.includes(:arquivos).find_by(identificador: params[:id])
		if @orcamento == nil
			@orcamento = Modeling.find_by(identificador: params[:id])
			if @orcamento == nil
				@orcamento = Adicionado.find_by(identificador: params[:id])
			end
		end

		if params[:versao]
			@orcamento = @orcamento.class.unscoped.where(identificador: @orcamento.identificador).find_by(versao: params[:versao])
		end

		if @orcamento.frete == nil
			@orcamento.frete = 0
		end
		if params[:format] != "pdf"
			if !@orcamento.items.any?
				@item = @orcamento.items.build
			end
		end
		respond_to do |format|
		  format.html
		  format.pdf do
		  	#@pdf = render_to_string :pdf => "#{@orcamento.identificador}", :template => "system/upload_pdf.html.erb",:layout => false
		  	#send_data(@pdf, :filename => "#{@orcamento.identificador}#{@orcamento.versao}.pdf",  :type=>"application/pdf")
		  	render pdf: "#{@orcamento.identificador}",
		  	template: "system/upload_pdf.html.erb",
		  	layout: false
		  end
		end
	end

	def update
		tipo = params[:tipo]
		id = params[:id]
		calculo = params[:calculo]
		versao = params[:versao]


		@orcamento = Orcamento.includes(:arquivos).find_by(identificador: id)
		if @orcamento == nil
			@orcamento = Modeling.find_by(identificador: id)
			if @orcamento == nil
				@orcamento = Adicionado.find_by(identificador: id)
				params = adicionado_params
			else
				params = modelagem_params
			end
		else
			params = upload_params
		end

		if versao
			@orcamento = @orcamento.class.unscoped.where(identificador: @orcamento.identificador).find_by(versao: versao)
		end

		if @orcamento.status == "Proposta Env"
			@orcamento.proposta_enviada = true
		end
		fechado = @orcamento.status

	    if @orcamento.update(params)
		  	if @orcamento.status == "Fechado"
		  		if @orcamento.prazo_final == ""
		  			flash[:alert] = "Rapaz, você bote o prazo!!"
		  		else
		  			flash[:success] = "Orçamento editado!"
		  		end
		  		if fechado != "Fechado"
	      			FechadoMailer.fechado_email(@orcamento).deliver
	      		end
	      	else
	      		flash[:success] = "Orçamento editado!"
	      	end
	      	if calculo
	      		redirect_to(system_edit_path(@orcamento.identificador, format: "pdf", versao: versao))
	      	else
	      		@orcamento.class.unscoped.where(identificador: @orcamento.identificador).each do |orcamento|
	      			orcamento.status = @orcamento.status
	      			orcamento.pag = @orcamento.pag
	      			orcamento.dataretorno = @orcamento.dataretorno
	      			orcamento.dataultimo = @orcamento.dataultimo
	      			orcamento.prazo_final = @orcamento.prazo_final
	      			orcamento.responsavel = @orcamento.responsavel
	      			orcamento.save
	      		end
	      		redirect_to(system_edit_path(@orcamento.identificador, versao: versao))
	      	end	
	    else
	      flash.now[:alert] = "Edição falhou! por favor cheque o formulário"
	      render :edit
	    end
	end



  	def enviar_avaliacao
	    identificador = params[:id]
		orcamento = Orcamento.find_by(identificador: identificador)
		modelagem = Modeling.find_by(identificador: identificador)
		adicionado = Adicionado.find_by(identificador: identificador)
		if orcamento
			@pedido = orcamento
			path = system_edit_path(@pedido.identificador)
		elsif modelagem
			@pedido = modelagem
			path = system_edit_path(@pedido.identificador)
		elsif orcamento
			@pedido = adicionado
			path = system_edit_path(@pedido.identificador)
		end
		if @pedido.email
			AvaliacaoMailer.avaliacao_email(@pedido).deliver
			flash[:success] = "Email enviado!"
			redirect_to path
		else
			flash.now[:danger] = "Esse pedido nao possui email. Favor adicionar email ou enviar de outra forma!"
			redirect_to path
		end
  	end


	private

	def upload_params
    	params.require(:orcamento).permit(:name, :sobrenome, :responsavel, :email, :empresa, :telefone, :cep, :status, :pag, :dataretorno, :dataultimo, :prazo_final, :versao, :tempo_impressao, :tempo_setup, :frete, :prazo_orc, :prazo_desejado, :tempo_execucao,:desconto, :valor,
    	items_attributes:[:id,:name,:tempo,:massa,:valor_unit,:quantidade,:valor,:resolucao,:infill,:cor,:material,:attachment,:_destroy],
    	servicos_attributes:[:id, :name, :valor_unit,:quantidade, :valor, :prazo,:_destroy])
  	end

  	def modelagem_params
    	params.require(:modeling).permit(:name, :sobrenome, :responsavel, :email, :empresa, :telefone, :cep, :status, :pag, :dataretorno, :dataultimo, :prazo_final, :versao, :tempo_impressao, :tempo_setup, :frete, :prazo_orc, :prazo_desejado, :tempo_execucao,:desconto, :valor, 
    		items_attributes:[:id,:name,:tempo,:massa,:valor_unit,:quantidade,:valor,:resolucao,:infill,:cor,:material,:attachment,:_destroy],
    		servicos_attributes:[:id, :name, :valor_unit, :quantidade, :valor, :prazo,:_destroy])
  	end
  	def adicionado_params
    	params.require(:adicionado).permit(:name, :sobrenome, :responsavel, :email, :empresa, :telefone, :cep, :status, :pag, :dataretorno, :dataultimo, :prazo_final, :versao, :tempo_impressao, :tempo_setup, :frete, :prazo_orc, :prazo_desejado, :tempo_execucao,:desconto, :valor, 
    		items_attributes:[:id,:name,:tempo,:massa,:valor_unit,:quantidade,:valor,:resolucao,:infill,:cor,:material,:attachment,:_destroy],
    		servicos_attributes:[:id, :name, :valor_unit, :quantidade, :valor, :prazo,:_destroy])
  	end


	def admin
    unless current_user.admin
      flash[:alert] = "Acesso negado!"
      redirect_to root_path
    end
  	end
end
