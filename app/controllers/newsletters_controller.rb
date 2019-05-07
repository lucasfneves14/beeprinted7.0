class NewslettersController < ApplicationController
	def create
		@news = Newsletter.create(news_params)
		@ja_tem = Newsletter.find_by(email: @news.email)
		if @ja_tem
			flash[:alert] = "Esse email já está registrado em nossa Newsletter!"
			redirect_back fallback_location: blogs_path
		else
			if @news.save
				flash[:success] = "Obrigado pela sua inscrição. A partir de agora você ficará por dentro do mundo da Impressão 3D!"
				redirect_back fallback_location: blogs_path
			else
				flash[:alert] = "Algo de errado ocorreu!"
				redirect_back fallback_location: blogs_path
			end
		end
	end

	private
	def news_params
    	params.require(:newsletter).permit(:email)
  	end
end
