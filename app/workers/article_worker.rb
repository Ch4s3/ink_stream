# A background worker that builds new Articles from links
# or updates existing articles with `full_text` if they
# have been created by the ui
class ArticleWorker
  include Sidekiq::Worker

  # kicks off the `ArticleWorker`
  #
  # @param url [String] a url
  # @param article_id [Integer|nil] id of Article if one was already instanciated
  def perform(url, article_id = nil)
    uri = URI(url)
    client =
      if uri.host =~ /nytimes.com/
        NyTimes::Client.new(uri.path, article_id)
      elsif uri.host =~ /longreads.com/
        LongReads::Client.new(uri.path, article_id)
      elsif uri.host =~ /nautil.us/
        Nautilus::Client.new(uri.path, article_id)
      end
    client.try(:article)
  end
end
