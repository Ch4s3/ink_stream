# frozen_string_literal: true

# HTTParty generic client for that takes an article path
# and get's the text of the article
class GenericClient
  attr_reader :code, :response_body
  include HTTParty
  base_uri 'https://test.test'

  # intialize method for the client that sets the article's path
  #
  # @param [String] path a uri path
  # @param [Integer] article_id id of Article if one was already instanciated
  def initialize(path, article_id = nil)
    @path = path
    @article_id = article_id
  end

  # This method gets the article and calls the builder, returning
  # an article if one is built. It will fail if base_uri is not set
  #
  # @return [Article]
  def article
    response = self.class.get(@path)
    @code = response.code
    return if @code != 200
    @response_body = response.body
    call_builder
  end

  private

  def call_builder
    raise NotImplementedError, 'You must implement the call_builder method'
  end
end
