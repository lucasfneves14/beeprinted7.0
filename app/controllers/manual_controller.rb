class ManualController < ApplicationController
  before_action :authenticate_user!, raise: false
  #skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :admin, only: [:new, :create, :edit, :update, :destroy, :index, :show]
  before_action :find_erro, only: [:edit, :update, :show, :delete]


  def index
  	@erros = Erro.all
  end

  def new
  	@erro = Erro.new
  end

  def create
  	@erro = Erro.create(erro_params)
  	if @erro.save
      flash[:notice] = "O Artigo foi criado com sucesso! Boa #{current_user.name} ;)"
      redirect_to erro_path(@erro.url)
    else
      flash[:alert] = "Algo de Errado ocorreu! Cheque o formulário."
      render :new
    end

  end

  def show
    @relacionados = Erro.where.not(id: @erro.id).order("RANDOM()").limit(4)
  end

  def edit

  end

  def update
  	@erro = Erro.find(params[:id])
  	if @erro.update(erro_params)
      flash[:notice] = "O artigo foi editado com sucesso!"
      redirect_to erro_path(@erro.url)
    else
      flash[:alert] = "Algo de errado ocorreu! Cheque o formulário"
      render :edit
    end
  end


  private
  def erro_params
    params.require(:erro).permit(:title, :resume,:summary,:image,:url,:seo_title,:seo_meta,:body)
  end
  def find_erro
    @erro = Erro.find_by(url: params[:id])
  end


  def admin
    unless current_user.admin
      redirect_to manual_path
    end
  end

end
