class CallbacksController < ApplicationController
	def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
    else
    #Follow.create(follower_id: @user.id, following_id: @user.id)
    redirect_to new_user_registration_url
    end
  end
 
  def failure
    redirect_to root_path
  end


end
