class ArticleWorker
  include Sidekiq::Worker

  def perform(url)
    uri = URI(url)
    case
    when uri.host =~ /nytimes.com/
      client = NyTimes::Client.new(uri.path)
      client.article
    end
  end
end
