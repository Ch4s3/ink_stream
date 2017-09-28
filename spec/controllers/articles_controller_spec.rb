require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #create' do
    it 'returns http success' do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    let(:publication) { Publication.create(name: 'Some Pub') }
    let(:article) { Article.create(title: 'Some Title', publication: publication).reload }

    it 'returns http success' do
      get :show, params: { id: article.uuid }
      expect(response).to have_http_status(:success)
    end

    it 'returns in under 70 ms' do
      expect { get :show, params: { id: article.uuid } }.to perform_under(0.07).and_sample(20)
    end
  end

  describe 'GET #search' do
    it 'returns http success' do
      get :search
      expect(response).to have_http_status(:success)
    end
  end
end
