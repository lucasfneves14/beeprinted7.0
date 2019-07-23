class HomeController < ApplicationController
  layout false
  before_action :authenticate_user!, raise: false
  skip_before_action :authenticate_user!, only: [:index]
  def index
  	#@blog = Blog.includes(:user).all.order('created_at DESC').limit(4)
    @portfolio = Post.includes(:user, :services).all.order('created_at DESC').limit(9)
    @contato = Contato.new
  end
  def campanha
  	@portfolio = Post.includes(:user, :services).all.order('created_at DESC').limit(10)
    @contato = Contato.new
  end

end
