class NotFoundController < ApplicationController
	def not_found
    	render(:status => 404)
  	end

  	def internal_server_error
  		if Rails.env.development?
    		render(:status => 500)
    	else
    		render(:status => 404)
    	end
  	end
end
