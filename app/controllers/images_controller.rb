class ImagesController < ApplicationController
  def create
  	@image = Image.create(image_params)
  	if @image.save
  		render json: { message: "success", fileID: @image.id, filename: File.basename(@image.attachment.path)}, :status => 200
    else
    	render json: { error: @image.errors.full_messages.join(',')}, :status => 400
    end

  end

  def destroy
    @image = Image.find(params[:id])
    if @image.destroy
      respond_to do |format|  
        format.json {render json: { message: "Arquivo deletado do servidor!" }}
      end
    else
      render json: { message: @image.errors.full_messages.join(',') }
    end
  end



private

def image_params
	params.require(:image).permit(:attachment)
end


end
