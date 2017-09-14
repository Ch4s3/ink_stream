class ArticlesController < ApplicationController
  def new
  end

  def index
  end

  def create
  end

  def results
    @articles = Article.where("title LIKE ?", "%#{articles_search_params[:title]}%")
  end

  def show
    binding.pry
    @article = Article.last
  end

  def search
    @articles_search_form = ArticlesSearchForm.new
  end

  private

  def articles_search_params
    params.require(:articles_search_form).permit(:publications, :title)
  end
end
