class RegistrationsController < Devise::RegistrationsController
  protected
  def stored_location_for(users)
  	nil
  end

  def after_sign_up_path_for(users)
  	posts_path
  end

  def after_sign_out_path_for(users)
    posts_path
  end

  def after_update_path_for(resource)
  	session[:previous_url]
  end




  private

  def sign_up_params
  	params.require(:user).permit(:email, :name, :sobrenome, :password, :password_confirmation)
  end

  def account_update_params
  	params.require(:user).permit(:email, :name, :sobrenome, :password, :password_confirmation, :current_password)
  end


end