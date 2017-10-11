# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_raven_context

  private

  def authorize_admin!
    message = 'You are not authorized to alter publications'
    flash_and_redirect(message) unless current_user.admin?
  end

  def flash_and_redirect(message, flash_type = :error, redirect_path = root_url)
    flash[flash_type] = message
    redirect_to(redirect_path)
  end

  def flash_and_render(message, flash_type = :error, render_action = :index)
    flash[flash_type] = message
    render render_action
  end

  def set_raven_context
    Raven.user_context(id: current_user.try(:id))
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
