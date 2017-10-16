# A background worker that builds new Articles from links
# or updates existing articles with `full_text` if they
# have been created by the ui
class ArticleWorker
  include Sidekiq::Worker

  def perform(url, article_id = nil)
    uri = URI(url)
    client =
      if uri.host =~ /nytimes.com/
        NyTimes::Client.new(uri.path, article_id)
      elsif uri.host =~ /longreads.com/
        LongReads::Client.new(uri.path, article_id)
      end
    client.article
  end
end
