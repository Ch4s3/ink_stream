require 'rails_helper'

RSpec.describe NyTimes::Builder, type: :builder do
  let!(:publication) { Publication.create(name: 'New York Times') }

  describe 'building an article' do
    let(:response_body) { File.open('spec/fixtures/nyt_article.html').read }
    let(:path) { '/2017/10/06/business/the-office-gets-remade-again.html' }
    let(:subject) { NyTimes::Builder.new(response_body, path) }

    it 'creates a article in the database' do
      expect(subject.article).to eq(Article.first)
    end
  end
end
