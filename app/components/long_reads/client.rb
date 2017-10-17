# frozen_string_literal: true

module LongReads
  # HTTParty client for LongReads that takes an article path
  # and get's the text of the article
  class Client < GenericClient
    private

    def base_uri
      'longreads.com'
    end

    def call_builder
      LongReads::Builder.new(@response_body, @path, @article_id).article
    end
  end
end
