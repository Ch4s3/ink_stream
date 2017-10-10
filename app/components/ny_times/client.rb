module NyTimes
  # HTTParty client for the NewYork Times that takes an article path
  # and get's the text of the article
  class Client
    attr_reader :code, :response_body
    include HTTParty
    base_uri 'nytimes.com'

    # intialize method for the client that sets the article's path
    #
    # @param path [String] a uri path
    # @param article_id [Integer] id of Article if one was already instanciated
    def initialize(path, article_id)
      @path = path
      @article_id = article_id
    end

    # This method gets the article and calls the builder, returning
    # an article if one is built
    #
    # @return [Article]
    def article
      response = self.class.get(@path)
      @code = response.code
      return if @code != 200
      @response_body = response.body
      NyTimes::Builder.new(@response_body, @path, @article_id).article
    end
  end
end
