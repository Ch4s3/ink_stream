# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_raven_context

  private

  def set_raven_context
    Raven.user_context(id: current_user.try(:id))
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
