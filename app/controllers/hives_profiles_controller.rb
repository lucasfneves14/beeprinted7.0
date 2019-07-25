class HivesProfilesController < ApplicationController
	before_action :authenticate_modeler!, raise: false
	layout 'hives/navbar'
	def show
		jobs_done = current_modeler.jobs.where(done:true)
		@preco = 0
		jobs_done.each do |job_done|
			@preco = @preco + job_done.value
		end
		@count = jobs_done.count
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
