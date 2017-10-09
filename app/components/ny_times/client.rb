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
    def initialize(path)
      @path = path
    end

    # This method gets the article and sets the @full_text on the client
    #
    # @return [String]
    def article
      response = self.class.get(@path)
      @code = response.code
      binding.pry
      return if @code != 200
      @response_body = response.body
      NyTimes::Builder.new(@response_body, @path)
    end
  end
end
