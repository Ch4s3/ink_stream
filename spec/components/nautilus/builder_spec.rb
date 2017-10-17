require 'rails_helper'

RSpec.describe Nautilus::Builder, type: :builder do
  let!(:publication) { Publication.create(name: 'Nautilus') }

  describe 'building an article' do
    let(:response_body) { File.open('spec/fixtures/nautilus_article.html').read }
    let(:path) { '/feature/257/how-to-obfuscate' }
    let(:subject) { Nautilus::Builder.new(response_body, path) }

    it 'creates a article in the database' do
      expect(subject.article).to eq(Article.first)
    end
  end
end
