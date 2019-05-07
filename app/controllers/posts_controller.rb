class PostsController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!, raise: false
  skip_before_action :authenticate_user!, only: [:show, :index]
  before_action :owned_post, only: [:edit, :update, :destroy]
  def index
  	@posts = Post.all
  end

  def new
  	@post = current_user.posts.build
    @image = Image.new
  end

  def create
    @post = current_user.posts.build(post_params)
    array = @post.array.split(",")
    array.each do |file|
      puts file
      if Image.where(id: file).any?
        image = Image.find(file)
        @post.images << image
      end
    end
    if @post.save
      flash[:success] = "Seu projeto foi criado!"
      redirect_to posts_path
    else
      flash[:alert] = "Seu projeto não pode ser salvo! Por favor, cheque o formulário."
      @image = Image.new
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @image = @post.images.first
    @images = @post.images.all[1..-1]
    @recomendados = Post.all.where.not(id: params[:id]).sample(5)
    @contato = Contato.new
  end

  def edit
    @post = Post.find(params[:id])
    @image = Image.new
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "Projeto Editado!"
      redirect_to(post_path(@post))
    else
      flash.now[:alert] = "Edição falhou! por favor cheque o formulário"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = "Projeto excluído!"
      redirect_to posts_path
    else
      flash.alert[:alert] = "Não foi possível excluir o arquivo!"
      render :edit
    end
  end


  private
  def post_params
    params.require(:post).permit(:caption, :array, :description, service_ids:[])
  end

  def owned_post
    @post = Post.find(params[:id])
    unless current_user == @post.user
      flash[:alert] = "Esse projeto não pertence a você!"
      redirect_to posts_path
    end
  end

end
