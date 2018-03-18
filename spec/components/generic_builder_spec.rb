require 'rails_helper'

RSpec.describe GenericBuilder, type: :builder do
  let!(:publication) { Publication.create(name: 'New York Times') }

  describe 'implementation errors' do
    let(:response_body) { File.open('spec/fixtures/nyt_article.html').read }
    let(:path) { '/2017/10/06/business/the-office-gets-remade-again.html' }
    let(:subject) { GenericBuilder.new(response_body, path) }

    it 'raises on publication_url' do
      expect {subject.publication_url}.to raise_error(NotImplementedError)
    end

    it 'raises on article_title' do
      expect {subject.article_title}.to raise_error(NotImplementedError)
    end

    it 'raises on article_full_text' do
      expect {subject.article_full_text}.to raise_error(NotImplementedError)
    end

    it 'raises on article_published_on' do
      expect {subject.article_published_on}.to raise_error(NotImplementedError)
    end
  end
end
