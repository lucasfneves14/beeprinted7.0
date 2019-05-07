class HomeController < ApplicationController
  layout false
  def index
  	@blog = Blog.all.order('created_at DESC').limit(4)
    @portfolio = Post.all.order('created_at DESC').limit(10)
    @contato = Contato.new
  end
end
