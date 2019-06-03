class ReferencesController < ApplicationController
  def create
  	@reference = Reference.create(reference_params)
  	if @reference.save
  		render json: { message: "success", fileID: @reference.id, filename: File.basename(@reference.attachment.path)}, :status => 200
    else
    	render json: { error: "Um ERRO ocorreu! Por favor, entre em contato em contato@beeprinted.com.br"}, :status => 400
    end
  end

  def destroy
  	@reference = Reference.find(params[:id])
    if @reference.destroy
      respond_to do |format|  
        format.json {render json: { message: "Arquivo deletado do servidor!" }}
      end
    else
      render json: { message: @reference.errors.full_messages.join(',') }
    end
  end

  private

	def reference_params
		params.require(:reference).permit(:attachment)
	end



end
