require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'scopes' do
    let!(:article) { Article.create(title: 'Bluth Banana Stand Burns') }
    let(:search) { 'Banana Stand' }
    let(:subject) { Article.fuzzy_title(search) }

    it 'finds articles by partial title' do
      expect(subject).to eq([article])
    end
  end

  describe '#update_with_hash_by_id' do
    let!(:article) { Article.create(title: 'Bluth Banana Stand Burns') }
    let(:new_hash) { { title: 'Bluth Bananas Burn', link: 'https://news.test.test/bananas' } }
    let(:id) { article.id }
    let(:subject) { Article.update_with_hash_by_id(new_hash, id) }
    it 'finds and updates an article wih a valid hash of data' do
      expect(subject).to eq(true)
      expect(article.reload.title).to eq(new_hash[:title])
      expect(article.reload.link).to eq(new_hash[:link])
    end

    context 'with out nonexistent id' do
      let(:id) { Article.order(:id).max.id + 1 }

      it 'returns nil' do
        expect(subject).to eq(nil)
      end
    end
  end
end
