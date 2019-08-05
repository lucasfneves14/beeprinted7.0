class HivesProfilesController < ApplicationController
	before_action :authenticate_modeler!, raise: false
	layout 'hives/navbar'
	def show
		@rating = 0
		if current_modeler.ratings.any?
			ratings = current_modeler.ratings
			ratings.each do |rating|
				@rating = @rating + rating.value
			end

			@rating = @rating.to_f/ratings.count

			@rating = @rating.round
		end

		jobs_done = current_modeler.jobs.where(done:true)
		@preco = 0
		jobs_done.each do |job_done|
			@preco = @preco + job_done.value
		end
		@count = jobs_done.count
		@ajuste = jobs_done.where(tipo: "Ajustes para Impressão").count
		@completa = jobs_done.where(tipo: "Modelagem Completa").count
		@parcial = jobs_done.where(tipo: "Modelagem Parcial").count
		@design = jobs_done.where(tipo: "Design de Produto").count
	end

	def edit

	end

	def update
	    respond_to do |format|
	      if current_modeler.update(modeler_params)
	        format.html { redirect_to hives_profile_path, notice: 'Perfil atualizado com sucesso.' }
	      else
	        format.html { render :edit }
	      end
	    end
  	end

  	def pagamentos

  	end
  	def instrucoes

  	end
  	def ajuda

  	end


  	private
  	def modeler_params
      params.require(:modeler).permit(:name, :image, :city)
    end


end
