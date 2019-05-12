class ProfilesController < ApplicationController
	protect_from_forgery
  	before_action :authenticate_user!, raise: false
  	before_action :admin
	def edit
		@user = User.find(params[:id])
	end

	def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Perfil Editado!"
      redirect_to(root_path)
    else
      flash.now[:alert] = "Edição falhou! Por favor cheque o formulário"
      render :edit
    end
  end


  private
  def user_params
    params.require(:user).permit(:avatar, :description)
  end

  def admin
    unless current_user.admin
      flash[:alert] = "Acesso negado!"
      redirect_to posts_path
    end
  end

end
