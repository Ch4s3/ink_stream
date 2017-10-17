# frozen_string_literal: true

module Nautilus
  # HTTParty client for Nautilus that takes an article path
  # and get's the text of the article
  class Client < GenericClient
    base_uri 'mitp.nautil.us'

    private

    def call_builder
      Nautilus::Builder.new(@response_body, @path, @article_id).article
    end
  end
end
