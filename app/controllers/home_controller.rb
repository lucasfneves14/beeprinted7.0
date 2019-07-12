class HomeController < ApplicationController
  layout false
  def index
  	#@blog = Blog.includes(:user).all.order('created_at DESC').limit(4)
    @portfolio = Post.includes(:user, :services).all.order('created_at DESC').limit(9)
    @contato = Contato.new
  end
end
