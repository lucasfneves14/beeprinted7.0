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
    @orcamento = Orcamento.new
    @arquivo = Arquivo.new
    @modeling = Modeling.new
    @reference = Reference.new
    if current_user
      @orcamento.name = "#{current_user.name} #{current_user.sobrenome}"
      @modeling.name = "#{current_user.name} #{current_user.sobrenome}"
      @orcamento.email = current_user.email
      @modeling.email = current_user.email
    end
  end

end
