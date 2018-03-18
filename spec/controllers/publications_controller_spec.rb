# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicationsController, type: :controller do
  describe 'GET #new' do
    context 'with admin user' do
      let(:user) { User.create(email: 'test@is.test', password: '1234Password', admin: true) }
      let!(:auth) { sign_in(user) }
      let(:subject) { get :new }

      it 'returns a 200' do
        expect(subject).to have_http_status(200)
      end
    end
  end

  describe 'POST #create' do
    context 'with admin user' do
      let(:user) { User.create(email: 'test@is.test', password: '1234Password', admin: true) }
      let(:publication_params) do
        { publication: {
          name: 'some name',
          site: 'https://news.test.test',
          description: 'some description'
        } }
      end
      let!(:auth) { sign_in(user) }
      let(:subject) { post :create, params: publication_params }

      it 'creates a new publication' do
        expect(subject).to have_http_status(302)
        expect(Publication.count).to eq(1)
      end

      context 'with invalid params' do
        let(:publication_params) { { publication: { name: '' } } }

        it 'responds with an error and does not create a Publication' do
          subject
          expect(flash[:error]).to be_present
          expect(Publication.count).to eq(0)
        end
      end
    end
  end
end
