require 'rails_helper'

RSpec.describe 'user request', type: :request do
  describe 'POST /api/v1/users' do
    let(:valid_attributes) { { email: 'jackson@gmail.com', password: '123Qweasd*' } }
    before { post '/api/v1/users', params: valid_attributes }
    context 'when the user is valid' do
      it 'return message' do
        expect(auth_response_body['message']).to match(/User created successfully/)
      end
    end
  end
end
