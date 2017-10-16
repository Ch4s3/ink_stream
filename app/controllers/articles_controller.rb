# frozen_string_literal: true

# Controller for Articles and related search functionality
class ArticlesController < ApplicationController
  before_action :find_article, only: :show
  before_action :validate_search, only: :results
  before_action :authenticate_user!, only: %i[new create]

  def new
    @article = Article.new
  end

  def create
    publication = Publication.find_by(id: article_params['publication']['publication_id'])
    @article =  Article.new(title: article_params['title'], link: article_params['link'],
                            publication: publication)
    if @article.save
      ArticleWorker.perform_async(@article.link, @article.id)
      message = 'The article has been created and an text is being parsed'
      flash_and_redirect(message, :success)
    else
      flash_and_redirect(@article.errors, :error, :back)
    end
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

  def validate_search
    error_message = 'You must include a title to search for articles'
    flash_and_redirect(error_message) if search_params['title'].blank?
  end

  def find_article
    @article = Article.find_by(uuid: show_params['id'])
  end

  def article_params
    params.require(:article)
          .permit(:title, :link, publication: :publication_id)
  end

  def show_params
    params.permit('id')
  end

  def search_params
    params.require(:articles_search_form)
          .permit(:publications, :title, :search_offset)
  end
end
