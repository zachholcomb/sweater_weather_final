require 'rails_helper'

RSpec.describe 'User Registration API' do
  it 'can register a user via post request' do
    expect(User.all.length).to eq(0)
    user_params =  {
    "email": "whatever@example.com",
    "password": "password",
    "password_confirmation": "password"
    }

    post '/api/v1/users', params: user_params
    expect(response).to be_successful
    user_response = JSON.parse(response.body, symbolize_names: true)
    
    expect(User.all.length).to eq(1)
    expect(user_response[:data][:attributes][:email]).to eq("whatever@example.com")
    expect(user_response[:data][:attributes][:api_key]).to_not eq(nil)
    expect(user_response[:data][:attributes][:api_key].length).to eq(27)
  end
end