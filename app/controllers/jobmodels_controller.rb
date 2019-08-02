class JobmodelsController < ApplicationController
  def create
  	@jobmodel = Jobmodel.create(jobmodel_params)
  	if @jobmodel.save
  		render json: { message: "success", fileID: @jobmodel.id, filename: File.basename(@jobmodel.attachment.path)}, :status => 200
    else
    	render json: { error: "Um ERRO ocorreu! Por favor, tente novamente ou entre em contato em contato@beeprinted.com.br"}, :status => 400
    end

  end

  def destroy
    @jobmodel = Jobmodel.find(params[:id])
    if @jobmodel.destroy
      respond_to do |format|  
        format.json {render json: { message: "Arquivo deletado do servidor!" }}
      end
    else
      render json: { message: @jobmodel.errors.full_messages.join(',') }
    end
  end



private

def jobmodel_params
	params.require(:jobmodel).permit(:attachment)
end
end
