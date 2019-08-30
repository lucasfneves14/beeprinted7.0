class ArquivosController < ApplicationController
	#require 'rest-client'
  def create
  	@arquivo = Arquivo.create(arquivo_params)
    
    #file = ::Pipedrive::File.new
    #@file = file.create(file: params[:arquivo][:attachment])
    #puts @arquivo.attachment.url
    #puts @arquivo.attachment
    #puts params[:arquivo][:attachment]
    #puts @file
  	if @arquivo.save

  		render json: { message: "success", fileID: @arquivo.id, filename: File.basename(@arquivo.attachment.path)}, :status => 200
    else
    	render json: { error: "Um ERRO ocorreu! Por favor, entre em contato em contato@beeprinted.com.br"}, :status => 400
    end

  end

  def destroy
    @arquivo = Arquivo.find(params[:id])
    if @arquivo.destroy
      respond_to do |format|  
        format.json {render json: { message: "Arquivo deletado do servidor!" }}
      end
    else
      render json: { message: @arquivo.errors.full_messages.join(',') }
    end
  end



private

def arquivo_params
	params.require(:arquivo).permit(:attachment)
end


end
