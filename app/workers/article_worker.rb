class ArticleWorker
  include Sidekiq::Worker

  def perform(url, article_id = nil)
    uri = URI(url)
    case
    when uri.host =~ /nytimes.com/
      client = NyTimes::Client.new(uri.path, article_id)
      client.article
    end
  end
end
