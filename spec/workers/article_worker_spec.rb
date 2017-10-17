require 'rails_helper'
RSpec.describe ArticleWorker, type: :worker do
  let(:response_body) { File.open('spec/fixtures/lr_article.html').read }
  let(:url) { 'https://www.longreads.com/2017/10/06/business/the-office-gets-remade-again.html' }
  let(:article_id) { nil }
  context 'with a valid url' do
    let(:subject) { ArticleWorker.perform_async(url, article_id) }
    let!(:stub) { stub_request(:any, /longreads/).to_return(body: response_body) }

    it 'queues a job' do
      subject
      expect(ArticleWorker).to have_enqueued_sidekiq_job(url, nil)
    end

    it 'builds an article' do
      Sidekiq::Testing.inline! do
        subject
      end
      expect(Article.first).to be_present
      expect(Article.first.link).to eq(url)
    end
  end
  context 'with an invalid url' do
    let(:url) { 'https://test.test' }
    let(:subject) { ArticleWorker.perform_async(url, article_id) }

    it 'returns nil and does not build an article' do
      Sidekiq::Testing.inline! do
        subject
      end
      expect(Article.first).to be_nil
    end
  end
end
