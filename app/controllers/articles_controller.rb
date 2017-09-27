class ArticlesController < ApplicationController
  before_action :find_article, only: [:show]
  before_action :validate_search, only: [:results]


  def results
    @publications = articles_search_params[:publications]
    @title_search = articles_search_params[:title]
    @search_offset = articles_search_params[:search_offset].to_i || 0
    @articles =
      Articles::Finder.find(@publications, @title_search, @search_offset)
  end

  def show
    unless @article
      flash[:error] = 'The requested article does not exist'
      redirect_to root_url
    end
  end

  def search
    @articles_search_form = ArticlesSearchForm.new
  end

  private
  def validate_search
    if articles_search_params['title'].blank?
      flash[:error] = 'You must include a title to search for articles'
      redirect_to root_url
    end
  end

  def find_article
    @article = Article.where(uuid: article_show_params['id']).first
  end

  def article_show_params
    params.permit('id')
  end

  def articles_search_params
    params.require(:articles_search_form)
          .permit(:publications, :title, :search_offset)
  end
end
