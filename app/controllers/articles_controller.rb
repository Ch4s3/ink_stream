# Controller for Articles and related search functionality
class ArticlesController < ApplicationController
  before_action :find_article, only: [:show]
  before_action :validate_search, only: [:results]
  before_action :authenticate_user!, only: %i[new create]

  def new
    @article = Article.new
  end

  def results
    @publications = search_params[:publications]
    @title_search = search_params[:title]
    @search_offset = search_params[:search_offset].to_i || 0
    @articles =
      Articles::Finder.find(@publications, @title_search, @search_offset)
  end

  def show
    flash_and_redirect('The requested article does not exist') unless @article
  end

  def search
    @articles_search_form ||= ArticlesSearchForm.new
  end

  private

  def flash_and_redirect(message, flash_type = :error, redirect_path = root_url)
    flash[flash_type] = message
    redirect_to(redirect_path)
  end

  def validate_search
    error_message = 'You must include a title to search for articles'
    flash_and_redirect(error_message) if search_params['title'].blank?
  end

  def find_article
    @article = Article.find_by(uuid: show_params['id'])
  end

  def show_params
    params.permit('id')
  end

  def search_params
    params.require(:articles_search_form)
          .permit(:publications, :title, :search_offset)
  end
end
