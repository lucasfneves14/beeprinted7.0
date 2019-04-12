class PostsController < ApplicationController
  def index
  	@posts = Post.all
  end

  def new
  	@post = Post.new
    @image = Image.new
  end

  def create
    @post = Post.create(post_params)
    array = @post.array.split(",")
    array.each do |file|
      puts file
      if Image.where(id: file).any?
        image = Image.find(file)
        @post.images << image
      end
    end
    if @post.save
      flash[:success] = "Seu projeto foi salvo!"
      redirect_to posts_path
    else
      flash[:alert] = "Seu projeto nao pode ser salvo! Por favor, cheque o formulário."
      @image = Image.new
      render :new
    end
  end


  private
  def post_params
    params.require(:post).permit(:caption, :array)
  end

end
