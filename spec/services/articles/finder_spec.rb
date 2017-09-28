require 'rails_helper'

RSpec.describe Articles::Finder, type: :service do
  let(:publication) { Publication.create(name: 'Some Pub') }
  let!(:articles) do
    10.times do
      Article.create(title: Faker::Hipster.sentence, publication: publication)
    end
  end

  describe 'Finding articles by full title' do
    let(:subject) { Articles::Finder.find('', Article.first.title[0..5], 0) }

    it 'returns matching articles' do
      expect(subject[0]).to eq(Article.first)
    end

    it 'returns results in under 20 ms' do
      expect { Articles::Finder.find('', 'e', 0) }.to perform_under(0.02)
    end
  end

  describe 'Findng articles by full title' do
    let(:subject) { Articles::Finder.find('', Article.first.title, 0) }

    it 'returns matching articles' do
      expect(subject[0]).to eq(Article.first)
    end
  end

  describe 'Findng articles by title and publication' do
    let(:subject) { Articles::Finder.find(publication.name, Article.first.title, 0) }

    it 'returns matching articles' do
      expect(subject[0]).to eq(Article.first)
    end
  end

  describe 'Findng articles with an offset' do
    let!(:more_articles) do
      10.times do
        Article.create(title: Faker::Hipster.sentence, publication: publication)
      end
    end

    let(:subject) { Articles::Finder.find('', 'a', 10) }

    it 'returns matching articles from the next set of resutls' do
      previous_set_last_id = Articles::Finder.find('', 'a', 0).last.id
      expect(subject.pluck(:id)).to_not include(previous_set_last_id)
    end
  end
end
