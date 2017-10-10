# A background worker that builds new Articles from links
# or updates existing articles with excerpts if they
# have been created by the ui
class ArticleWorker
  include Sidekiq::Worker

  def perform(url, article_id = nil)
    uri = URI(url)
    if uri.host =~ /nytimes.com/
      client = NyTimes::Client.new(uri.path, article_id)
      client.article
    end
  end
end
