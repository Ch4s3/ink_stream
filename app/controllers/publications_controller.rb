# frozen_string_literal: true

# Controller for managing the `Publication` model
# creating and modifying publications cna only be done by
# a user who is an admin
class PublicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, only: %i[new create]
  before_action :set_publications, only: :index
  before_action :find_article, only: :show

  def new
    @publication = Publication.new
  end

  def create
    @publication = Publication.new(publication_params)
    if @publication.save
      message = 'The article has been created successfully'
      flash_and_redirect(message, :success)
    else
      flash_and_render(@publication.errors, :error, :create)
    end
  end

  private

  def find_article
    @publication = Publication.find_by(show_params)
  end

  def publication_params
    params.require('publication').permit('name', 'site', 'description')
  end

  def show_params
    params.permit('id')
  end

  def set_publications
    @publications = Publication.all
  end
end
