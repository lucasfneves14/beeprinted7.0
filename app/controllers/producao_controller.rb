class ProducaoController < ApplicationController
	layout 'system/navbar'
	def jobs
		orcamentos = Orcamento.where(status: 'Fechado')
		modelagens = Modeling.where(status: 'Fechado')
		adicionados = Adicionado.where(status: 'Fechado')

		@jobs = (modelagens + orcamentos + adicionados).sort{|a,b| a.created_at <=> b.created_at }
		orcamentos = current_user.orcamentos.where(status: 'Produzindo')
		modelagens = current_user.modelings.where(status: 'Produzindo')
		adicionados = current_user.adicionados.where(status: 'Produzindo')
		@producao = (modelagens + orcamentos + adicionados).sort{|a,b| a.created_at <=> b.created_at }

	end

	def index
		orcamentos = current_user.orcamentos.where(status: 'Produzindo')
		modelagens = current_user.modelings.where(status: 'Produzindo')
		adicionados = current_user.adicionados.where(status: 'Produzindo')

		@producao = (modelagens + orcamentos + adicionados).sort{|a,b| a.created_at <=> b.created_at }

	end

	def show
		@job = Orcamento.find_by(identificador: params[:id])
		if @job == nil
			@job = Modeling.find_by(identificador: params[:id])
		end
		if @job == nil
			@job = Adicionado.find_by(identificador: params[:id])
		end


	end

	def aceitar_job
		@orcamento = Orcamento.find_by(identificador: params[:id])
		if @orcamento == nil
			@orcamento = Modeling.find_by(identificador: params[:id])
			if @orcamento == nil
				@orcamento = Adicionado.find_by(identificador: params[:id])
				@orcamento.status = "Produzindo"
				current_user.adicionados << @orcamento
			else
				@orcamento.status = "Produzindo"
				current_user.modelings << @orcamento
			end
		else
			@orcamento.status = "Produzindo"
			current_user.orcamentos << @orcamento
		end

		
		flash[:success] = "Job Aceito!"
		redirect_to producao_show_path(@orcamento.identificador)

	end
end
