require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe 'GET #new' do
    let(:user) { User.create(email: 'test@is.test', password: '1234Password') }

    it 'returns http success for signed in users' do
      sign_in(user)
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'redirects without sign in' do
      get :new
      expect(response).to have_http_status(302)
    end
  end

  describe 'POST #create' do
    let(:user) { User.create(email: 'test@is.test', password: '1234Password') }
    let(:post_params) do
      { article: {
        title: 'Some Title', link: 'www.test.test',
        publication: { publication_id: 1 }
      } }
    end
    it 'returns http success for signed in users' do
      sign_in(user)
      post :create, params: post_params
      expect(response).to have_http_status(302)
      expect(Article.last.title).to eq('Some Title')
    end

    it 'redirects without sign in' do
      get :new
      expect(response).to have_http_status(302)
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
