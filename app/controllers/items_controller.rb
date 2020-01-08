class ItemsController < ApplicationController
	def create
  	@item = Item.create(item_params)
  	if @item.attachment != nil
  		string = File.basename(@item.attachment.url)
		@item.name = CGI.unescape(string)
	end
    
    #file = ::Pipedrive::File.new
    #@file = file.create(file: params[:arquivo][:attachment])
    #puts @arquivo.attachment.url
    #puts @arquivo.attachment
    #puts params[:arquivo][:attachment]
    #puts @file
  	if @item.save

  		render json: { message: "success", fileID: @item.id, filename: File.basename(@item.attachment.path)}, :status => 200
    else
    	render json: { error: "Um ERRO ocorreu! Por favor, entre em contato em contato@beeprinted.com.br"}, :status => 400
    end

  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      respond_to do |format|  
        format.json {render json: { message: "Arquivo deletado do servidor!" }}
      end
    else
      render json: { message: @item.errors.full_messages.join(',') }
    end
  end



private

def item_params
	params.require(:item).permit(:attachment)
end
end
