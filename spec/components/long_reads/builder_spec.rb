require 'rails_helper'

RSpec.describe NyTimes::Builder, type: :builder do
  let!(:publication) { Publication.create(name: 'Long Reads') }

  describe 'building an article' do
    let(:response_body) { File.open('spec/fixtures/lr_article.html').read }
    let(:path) { '/2017/10/06/business/the-office-gets-remade-again.html' }
    let(:subject) { LongReads::Builder.new(response_body, path) }

    it 'creates a article in the database' do
      expect(subject.article).to eq(Article.first)
    end
  end
end
