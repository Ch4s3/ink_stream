require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:subject) { User.new(email: 'test@is.test', password: '1234567') }
    it 'validates passowrd length' do
      expect(subject).to be_invalid
      expect(subject.errors.messages.keys).to include(:password)
    end

    it 'validates emails' do
      subject.password = '12345678'
      subject.email = 'some invalid input'
      expect(subject).to be_invalid
      expect(subject.errors.messages.keys).to include(:email)
    end
  end
end
