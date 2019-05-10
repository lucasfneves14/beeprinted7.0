class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :store_location

  def store_location
  	session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end


  def after_sign_in_path_for(resource)
    if session[:previous_url] 
      session[:previous_url]
    else
      root_path
    end
  end

  def test_exception_notifier
    raise "Test Exception. This is a test exception to make sure the exception notifier is working."
  end

end
