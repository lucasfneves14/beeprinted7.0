class BlogsController < ApplicationController
	before_action :authenticate_user!, raise: false
    skip_before_action :authenticate_user!, only: [:index, :show]
	before_action :find_blog, only: [:edit, :update, :show, :delete]

  # Index action to render all posts
  def index
    blogs = Blog.all.includes(:categorium, :user).order('created_at DESC')
    @blog1 = blogs.limit(3)
    @popular = blogs.limit(4)
    @blogs = blogs - @blog1
  end

  # New action for creating post
  def new
    @blog = current_user.blogs.build
  end

  # Create action saves the post into database
  def create
    @blog = current_user.blogs.build(blog_params)
    string = @blog.body
    string1 = "src=\""
    string2 = "\""
    stringsrc= string[/#{string1}(.*?)#{string2}/m,1]
    while stringsrc do
      string[/#{string1}(.*?)#{string2}/m,1]
      string_rep = "#{string1}#{stringsrc}#{string2}"
      string.sub! "#{string_rep}", "class=lazyload data-src=#{stringsrc}"
      stringsrc= string[/#{string1}(.*?)#{string2}/m,1]
    end
    @blog.body = string

    if @blog.save
      flash[:notice] = "O Artigo foi criado com sucesso! Boa #{current_user.name} ;)"
      redirect_to blog_path(@blog.url)
    else
      flash[:alert] = "Algo de Errado ocorreu! Cheque o formulário."
      render :new
    end
  end

  # Edit action retrives the post and renders the edit page
  def edit
    string = @blog.body
    string1 = "class=lazyload data-src="
    string2 = " "
    stringsrc= string[/#{string1}(.*?)#{string2}/m,1]
    while stringsrc do
      string[/#{string1}(.*?)#{string2}/m,1]
      string_rep = "#{string1}#{stringsrc}#{string2}"
      string.sub! "#{string_rep}", "src=\"#{stringsrc}\""
      stringsrc= string[/#{string1}(.*?)#{string2}/m,1]
    end
    @blog.body = string
  end

  # Update action updates the post with the new information
  def update
    @blog = Blog.find(params[:id])
    string = @blog.body
    string1 = "src=\""
    string2 = "\""
    stringsrc= string[/#{string1}(.*?)#{string2}/m,1]
    while stringsrc do
      string[/#{string1}(.*?)#{string2}/m,1]
      string_rep = "#{string1}#{stringsrc}#{string2}"
      string.sub! "#{string_rep}", "class=lazyload data-src=#{stringsrc}"
      stringsrc= string[/#{string1}(.*?)#{string2}/m,1]
    end
    @blog.body = string
    if @blog.update_attributes(blog_params)
      flash[:notice] = "O artigo foi editado com sucesso!"
      redirect_to blog_path(@blog.url)
    else
      flash[:alert] = "Algo de errado ocorreu! Cheque o formulário"
      render :edit
    end
  end

  # The show action renders the individual post after retrieving the the id
  def show
    @blogs = Blog.all.includes(:categorium, :user).where.not(id: @blog.id).order('created_at DESC')
    @previous = @blogs.where("id < ?", @blog.id).last
    @next = @blogs.where("id > ?", @blog.id).first
    @relacionados = @blogs.limit(3)
    @popular = @blogs.limit(4)
  end

  # The destroy action removes the post permanently from the database
  def destroy
    if @blog.destroy
      flash[:notice] = "O artigo foi deletado com sucesso!"
      redirect_to blogs_path
    else
      flash[:alert] = "Algo de errado ocorreu! O artigo nao foi excluído."
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :summary,:attachment,:url,:seo_title,:seo_meta,:body, categorium_ids:[])
  end

  def find_blog
    @blog = Blog.includes(:categorium, :user).find_by(url: params[:id])
  end
end
