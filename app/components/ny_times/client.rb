# frozen_string_literal: true

module NyTimes
  # HTTParty client for the NewYork Times that takes an article path
  # and get's the text of the article
  class Client < GenericClient
    base_uri 'nytimes.com'

    private

    def call_builder
      NyTimes::Builder.new(@response_body, @path, @article_id).article
    end
  end
end
