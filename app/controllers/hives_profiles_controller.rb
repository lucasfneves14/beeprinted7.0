class HivesProfilesController < ApplicationController
	before_action :authenticate_modeler!, raise: false
	layout 'hives/navbar'
	def show
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


  	private
  	def modeler_params
      params.require(:modeler).permit(:name, :image, :city)
    end


end
