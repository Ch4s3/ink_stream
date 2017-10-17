require 'rails_helper'

RSpec.describe Nautilus::Builder, type: :client do
  let!(:publication) { Publication.create(name: 'New York Times') }

  describe 'building an article' do
    let(:response_body) { File.open('spec/fixtures/nautilus_article.html').read }
    let(:url) { 'http://mitp.nautil.us/feature/257/how-to-obfuscate' }
    let(:article_id) { nil }
    let(:subject) { Nautilus::Client.new(url, article_id) }

    context 'good response' do
      let!(:stub) { stub_request(:any, /nautil/).to_return(body: response_body) }

      it 'creates a article in the database' do
        expect(subject.article.title).to eq(Article.first.title)
        expect(subject.article.date).to eq(Article.first.date)
      end
    end

    context '404 response' do
      let!(:stub) { stub_request(:any, /nautil/).to_return(status: 404) }

      it 'captures the code and does not create an article' do
        expect(subject.article).to eq(nil)
        expect(subject.code).to eq(404)
      end
    end
  end
end
