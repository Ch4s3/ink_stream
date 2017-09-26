class ArticlesController < ApplicationController
  def new
  end

  def index
  end

  def create
  end

  def results
    @articles =
      Articles::Finder.find(articles_search_params[:publications],
                            articles_search_params[:title])
  end

  def show
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
